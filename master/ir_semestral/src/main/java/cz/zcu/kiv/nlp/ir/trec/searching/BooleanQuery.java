package cz.zcu.kiv.nlp.ir.trec.searching;

import cz.zcu.kiv.nlp.ir.trec.cli.ConsoleInterface;
import cz.zcu.kiv.nlp.ir.trec.data.AbstractResult;
import cz.zcu.kiv.nlp.ir.trec.data.Result;
import cz.zcu.kiv.nlp.ir.trec.data.ResultImpl;
import cz.zcu.kiv.nlp.ir.trec.indexing.IndexEntry;
import cz.zcu.kiv.nlp.ir.trec.indexing.Indexer;
import cz.zcu.kiv.nlp.ir.trec.preprocessing.Preprocessor;
import org.slf4j.LoggerFactory;

import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Stream;

public class BooleanQuery {
    static org.slf4j.Logger LOGGER = LoggerFactory.getLogger(ConsoleInterface.class);


    public static List<Result> executeQuery(Indexer index, String query) {
        if (query == null || query.equals("")) {
            return null;
        }

        long timeStart = System.nanoTime();

        var clausesPrioList = parseQueryToClauses(query);

        if (clausesPrioList == null || clausesPrioList.isEmpty()) {
            System.out.println("Error in preparing boolean query. The query is either empty or brackets do not match");
            return Collections.emptyList(); // return empty list - because we got here, but didnt search for results
        }

        ProcessedClause result = null;
        // stack to hold multiple clauses before merging them (until the most inner clause is processed)
        Stack<ProcessedClause> mergeStack = new Stack<>();

        for (int i = 0; i < clausesPrioList.size(); i++) {
            var currentClause = processClause(index, clausesPrioList.get(i).second);

            if (currentClause == null) {
                continue;
            }

            if (result == null) { // this ensures, that i == 0 never goes further
                // only go further after we get some results (skip operators at the start - eg.: "OR (test)")
                if (currentClause.hasTerms) {
                    result = currentClause;
                }
                continue;
            }

            if (clausesPrioList.get(i - 1).first > clausesPrioList.get(i).first) {
                // priority is dropping, first we merge queued clause results, then we add "suffix" (current clause)
                if (!mergeStack.isEmpty()) {
                    mergeClauseStack(mergeStack, result, false);
                }

                mergeStack.push(currentClause);
                if (currentClause.hasTerms) {
                    // merge results to existing results, because we are appending results to a clause
                    mergeClauseStack(mergeStack, result, true);
                }
            } else {
                // priority is ascending - we must wait with merging the lists (we must merge from highest to lowest)
                mergeStack.push(currentClause);
            }
        }

        // merge leftovers - if the last clause ends with ')' it would end on the highest prio -> never get merged
        if (!mergeStack.isEmpty()) {
            mergeClauseStack(mergeStack, result, false);
        }

        if (result == null) {
            LOGGER.debug("Result is null");
            return Collections.emptyList();
        }

        List<Result> output = new LinkedList<>();
        result.documentEntries.forEach((docId, entryList) -> {
            AbstractResult r = new ResultImpl();
            AtomicInteger termCount = new AtomicInteger();
            entryList.forEach(entry -> {
                termCount.addAndGet(entry.termFreq);
            });
            r.setScore((float) termCount.get());
            r.setDocumentID(docId);
            output.add(r);
        });

        Collections.sort(output);

        for (int i = 0; i < output.size(); i++) {
            // potentially dangerous cast
            ((ResultImpl) output.get(i)).setRank(i + 1);
        }

        long timeEnd = System.nanoTime();
        System.out.println("Executed query in " + ((timeEnd - timeStart) / 1000000) + "ms");

        return output;
    }

    /**
     * Merge left: clause1(clause2)...: results of clause2 are merged to the clause1 (its predecessor hence left).
     * However in the implementation we are working with the stack, which means currentClause = predecessor and
     * "previousClause" means the newer clause (clause2) so we are merging previous into current.
     * @param mergeStack
     * @param target
     */
    private static void mergeClauseStack(Stack<ProcessedClause> mergeStack, ProcessedClause target, boolean isSuffix) {
        if (mergeStack.size() == 0) {
            LOGGER.warn("Nothing to merge");
            return;
        }

        ProcessedClause currentClause;
        var previousClause = mergeStack.pop();
        MergeOperation mergeOperation = isSuffix ? previousClause.frontOperation : target.tailOperation;
        boolean connectClauses = false;

        while (!mergeStack.isEmpty()) {
            currentClause = mergeStack.pop();

            if (currentClause.hasTerms) {
                if (!connectClauses) { // we are not connecting two clauses "independent" clauses but directly connected ones
                    mergeOperation = currentClause.tailOperation;
                }

                doMerge(currentClause, previousClause, mergeOperation);
                previousClause = currentClause;
            } else {
                mergeOperation = currentClause.frontOperation;
                connectClauses = true;
            }
        }

        doMerge(target, previousClause, mergeOperation);
    }

    private static void doMerge(ProcessedClause target, ProcessedClause source, MergeOperation operation) {
        switch (operation) {
            case AND -> andOperationOnResults(target.documentEntries, source.documentEntries);
            case OR  -> orOperationOnResults(target.documentEntries, source.documentEntries);
            case NOT -> notOperationOnResults(target.documentEntries, source.documentEntries);
        }
    }

    private static ProcessedClause processClause(Indexer index, String query) {
        if (query == null || query.trim().length() == 0) {
            LOGGER.trace("Processing empty or non-existing clause");
            return null;
        }

        LOGGER.trace("Processing clause: " + query);

        // preparation
        AtomicReference<MergeOperation> frontMerge = new AtomicReference<>(MergeOperation.AND);
        AtomicReference<MergeOperation> state = new AtomicReference<>(MergeOperation.AND);
        AtomicBoolean firstIteration = new AtomicBoolean(true);
        AtomicBoolean startingMergeOperation = new AtomicBoolean(true);
        AtomicBoolean hasTerms = new AtomicBoolean(false);
        Map<String, List<IndexEntry>> clauseResult = new HashMap<>();

        // tokenization
        var tokens = query.split("\\s+");
        tokens = Preprocessor.getInstance().stemTokensWithExceptions(tokens, List.of("AND", "OR", "NOT"));

        Arrays.stream(tokens).forEach(token -> {
            switch (token) {
                case "AND" -> {
                    if (startingMergeOperation.get()) {
                        frontMerge.set(MergeOperation.AND);
                    } else {
                        state.set(MergeOperation.AND);
                    }
                }
                case "OR"  -> {
                    if (startingMergeOperation.get()) {
                        frontMerge.set(MergeOperation.OR);
                    } else {
                        state.set(MergeOperation.OR);
                    }
                }
                case "NOT" -> {
                    if (startingMergeOperation.get()) {
                        frontMerge.set(MergeOperation.NOT);
                    } else {
                        state.set(MergeOperation.NOT);
                    }
                }
                default -> {
                    token = token.toLowerCase();
                    token = Preprocessor.getInstance().stemToken(token);
                    var termEntries = index.getEntriesForTerm(token);

                    if (termEntries == null || termEntries.isEmpty()) {
                        break; // termEntries should never be empty, but they can be null
                    }

                    if (firstIteration.get()) {
                        orOperation(clauseResult, termEntries);
                        firstIteration.set(false);
                        startingMergeOperation.set(false); // this is the first time we reach here
                        hasTerms.set(true);
                    } else {
                        mergeListToResults(clauseResult, termEntries, state.get());
                    }

                    state.set(MergeOperation.AND); // reset state
                }
            }
        });


        return new ProcessedClause(frontMerge.get(), clauseResult, state.get(), hasTerms.get());
    }

    private static Map<String, List<IndexEntry>> mergeListToResults(Map<String, List<IndexEntry>> results,
                                                                    List<IndexEntry> postings,
                                                                    MergeOperation operation)
    {
        switch (operation) {
            case AND -> {
                return andOperation(results, postings);
            }
            case OR -> {
                return orOperation(results, postings);
            }
            case NOT -> {
                return notOperation(results, postings);
            }
        }

        return results;
    }

    private static List<Pair<Integer, String>> parseQueryToClauses(String query) {
        int lvlCounter = 0;
        List<Pair<Integer, String>> clauses = new ArrayList<>();
        int lastIndex = 0;
        int lbCnt = 0, rbCnt = 0;

        for (int i = 0; i < query.length(); i++) {
            switch (query.charAt(i)) {
                case '(' -> {
                    clauses.add(new Pair<>(lvlCounter, query.substring(lastIndex, i)));
                    lastIndex = i + 1; // +1 - exclude the bracket
                    lvlCounter++;
                    lbCnt++;
                }
                case ')' -> {
                    if (rbCnt < lbCnt) {
                        clauses.add(new Pair<>(lvlCounter, query.substring(lastIndex, i)));
                        lastIndex = i + 1; // +1 - exclude the bracket
                        lvlCounter--;
                        rbCnt++;
                    } else {
                        System.out.println("Too many right brackets");
                        LOGGER.error("Too many right brackets");
                        return null;
                    }
                }
            }
        }

        if (lbCnt != rbCnt) {
            System.out.println("Left and right bracket count mismatch");
            LOGGER.error("Left and right bracket count mismatch");
            return null;
        }

        if (lastIndex < query.length()) { // add "suffix" after last bracket to the end of the query
            clauses.add(new Pair<>(lvlCounter, query.substring(lastIndex)));
        }

        return clauses;
    }

    /**
     * Removes all document ID entries that DO NOT match any of the new postings and if the new postings do match, then
     * the entry is added to existing map = logical AND (only the intersection of both collections).
     * @param results
     * @param newPostings
     * @return
     */
    private static Map<String, List<IndexEntry>> andOperation(Map<String, List<IndexEntry>> results,
                                                              List<IndexEntry> newPostings)
    {
        List<String> removeList = new LinkedList<>();

        results.keySet().forEach(docId -> {
            var entry = newPostings.stream().filter(posting -> docId.equals(posting.document.getDocId())).findFirst();
            if (entry.isPresent()) {
                results.get(docId).add(entry.get());
            } else {
                removeList.add(docId);
            }
        });

        removeList.forEach(results::remove);

        return results;
    }

    /**
     * Merges all postings into the document entries map = logical OR (all results).
     * @param results
     * @param newPostings
     * @return
     */
    private static Map<String, List<IndexEntry>> orOperation(Map<String, List<IndexEntry>> results,
                                                             List<IndexEntry> newPostings)
    {
        newPostings.forEach(entry -> {
            results.computeIfAbsent(entry.document.getDocId(), key -> new ArrayList<>());
            results.get(entry.document.getDocId()).add(entry);
        });

        return results;
    }

    /**
     *  Removes all document ID entries that are present in the new postings = logical NOT
     *  (remove all matching results).
     * @param results
     * @param newPostings
     * @return
     */
    private static Map<String, List<IndexEntry>> notOperation(Map<String, List<IndexEntry>> results,
                                                              List<IndexEntry> newPostings)
    {
        newPostings.forEach(entry -> results.remove(entry.document.getDocId()));
        return results;
    }

    private static Map<String, List<IndexEntry>> andOperationOnResults(Map<String, List<IndexEntry>> results,
                                                                       Map<String, List<IndexEntry>> clauseResults)
    {
        List<String> removeList = new LinkedList<>();

        results.forEach((docId, entryList) -> {
            var clauseEntryList = clauseResults.get(docId);
            if (clauseEntryList == null) {
                removeList.add(docId);
            } else {
//                results.get(docId) = ... // if bellow doesnt work
                entryList = Stream.concat(clauseEntryList.stream(), entryList.stream()).distinct().toList();
            }
        });

        removeList.forEach(results::remove);

        return results;
    }

    private static Map<String, List<IndexEntry>> orOperationOnResults(Map<String, List<IndexEntry>> results,
                                                                      Map<String, List<IndexEntry>> clauseResults)
    {
        clauseResults.forEach((docId, entryList) -> {
            var resultEntryList = results.get(docId);
            if (resultEntryList != null) {
                // results.get(docId) = ...
                resultEntryList = Stream.concat(resultEntryList.stream(), entryList.stream()).distinct().toList();
            } else {
                results.put(docId, entryList);
            }
        });

        return results;
    }

    private static Map<String, List<IndexEntry>> notOperationOnResults(Map<String, List<IndexEntry>> results,
                                                                       Map<String, List<IndexEntry>> clauseResults)
    {
        clauseResults.keySet().forEach(results::remove);
        return results;
    }


    private static class ProcessedClause {
        public MergeOperation frontOperation;
        public Map<String, List<IndexEntry>> documentEntries;
        public MergeOperation tailOperation;
        public boolean hasTerms;

        public ProcessedClause(MergeOperation frontOperation, Map<String, List<IndexEntry>> documentEntries,
                               MergeOperation tailOperation, boolean hasTerms)
        {
            this.frontOperation = frontOperation;
            this.documentEntries = documentEntries;
            this.tailOperation = tailOperation;
            this.hasTerms = hasTerms;
        }
    }

    private static class Pair<S, T> {
        public S first;
        public T second;

        public Pair(S first, T second) {
            this.first = first;
            this.second = second;
        }
    }

    private enum MergeOperation {
        AND,
        OR,
        NOT
    }
}
