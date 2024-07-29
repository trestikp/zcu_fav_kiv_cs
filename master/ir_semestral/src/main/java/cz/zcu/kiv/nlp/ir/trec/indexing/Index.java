package cz.zcu.kiv.nlp.ir.trec.indexing;

import cz.zcu.kiv.nlp.ir.trec.core.AppWorkspace;
import cz.zcu.kiv.nlp.ir.trec.data.Document;
import cz.zcu.kiv.nlp.ir.trec.data.Result;
import cz.zcu.kiv.nlp.ir.trec.preprocessing.Preprocessor;
import cz.zcu.kiv.nlp.ir.trec.searching.CosineSimilarity;
import cz.zcu.kiv.nlp.ir.trec.searching.Searcher;
import cz.zcu.kiv.nlp.ir.trec.util.GeneralUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 * @author tigi
 *
 * Třída reprezentující index.
 *
 * Tuto třídu doplňte tak aby implementovala rozhranní {@link Indexer} a {@link Searcher}.
 * Pokud potřebujete, přidejte další rozhraní, která tato třída implementujte nebo
 * přidejte metody do rozhraní {@link Indexer} a {@link Searcher}.
 *
 *
 */
public class Index implements Indexer, Searcher {
    static Logger LOGGER = LoggerFactory.getLogger(Index.class);

    /** Inverted index is map of: term -> List<IndexEntry> (for IndexEntry see its own class) */
    private final Map<String, List<IndexEntry>> invertedIndex = new HashMap<>(); // term: doc1 -> doc2 -> doc3...
    /** Map of: documentID -> DocumentRef (object) - this is to avoid multiple references to the same object.
     * Little memory overhead, because DocumentRef contains documentId as well
     */
    private final Map<String, DocumentRef> docReferences = new HashMap<>(); // convenience map - a bit wasteful, because DocumentRef contains ID string as well
    /** All paths to documents, that are indexed here. This is here because it must be serialized when saving to file */
    private final List<String> docAbsolutePaths = new ArrayList<>();
    private Long docCount = 0L;
    /** Own instance of settings, se settings can be restored when the index is selected
     * (so the queries are processed the same way)
     */
    private final IndexSetting settings;


    public Index() {
        settings = IndexSetting.extractSettings();
    }

    /**
     * Adds List of documents to this index.
     * @param documents List of Document
     */
    public void index(List<Document> documents) {
        docCount += documents.size();

        IndexSetting.applySettings(settings); // settings should always be init

        int indexedCount = 0;
        long timeStart = System.nanoTime();

        for (int i = 0; i < documents.size(); i++) {
            if (indexDocThroughCache(documents.get(i))) {
                indexedCount++;
            }

            if (i % 100 == 0) {
                System.out.printf("Indexing documents: %.2f%% (%d/%d)\r",
                        (((double) i / documents.size()) * 100), i, documents.size());
            }
        }

        long timeEnd = System.nanoTime();
        System.out.println("Finished indexing documents. Indexed " + indexedCount + "/" + documents.size() +
                " documents in " + ((timeEnd - timeStart) / 1000000) + "ms");

        if (indexedCount < documents.size()) {
            System.out.println("Some document IDs already are in the index. See logs for more details");
        }

        calculateTfIdf();
    }

    /**
     * Adds a single Document to the index.
     * @param document Document
     */
    public void indexDocument(Document document) {
        docCount++;

        IndexSetting.applySettings(settings); // settings should always be init

        if (indexDocThroughCache(document)) {
            System.out.println("Successfully indexed document.");
        }

        calculateTfIdf();
    }

    /**
     * Default search method for this index.
     * @param query desired query
     * @return List of Result
     */
    public List<Result> search(String query) {
        return CosineSimilarity.executeQuery(this, query);
    }

    @Override
    public List<IndexEntry> getEntriesForTerm(String term) {
        return this.invertedIndex.get(term);
    }

    /**
     * Calculates TF-IDF weight for a query dictionary.
     * @param tokenDict Map of query terms and TF
     * @return Map of TF-IDF weight for the query terms
     */
    @Override
    public HashMap<String, Double> calculateQueryTfIdf(HashMap<String, Integer> tokenDict) {
        HashMap<String, Double> tfIdfDict = new HashMap<>();

        tokenDict.forEach((token, freq) -> {
            if (invertedIndex.get(token) == null) // token not in index - nothing to do
                tfIdfDict.put(token, 0.0d);
            else // calculate tf-idf: (1 + log(tf)) * log(N / df)
                tfIdfDict.put(token, (1 + Math.log10(freq)) *
                        Math.log10(docCount / (double) invertedIndex.get(token).size()));
        });

        return tfIdfDict;
    }

    /**
     * Addition of a single document. First preprocessing document text, then adding the results to inverted index.
     * @param doc Document
     */
    private void indexDoc(Document doc) {
        String toBeIndexed = "";
        switch (settings.indexingMethod) {
            case TEXT_ONLY -> toBeIndexed = doc.getText();
            case TITLE_ONLY -> toBeIndexed = doc.getTitle();
            case TEXT_AND_TITLE -> toBeIndexed = doc.getTitle() + " " + doc.getText();
            default -> toBeIndexed = doc.getText();
        }

        var tokens = Preprocessor.getInstance().processText(toBeIndexed);
        doc.setTokenCount(tokens.length); // NOTE: setting document token count here, MUST be after preprocessing

        Arrays.stream(tokens).forEach(term -> {
            invertedIndex.computeIfAbsent(term, key -> new LinkedList<>());

            // NOTE: have to use ID comparisons, because comparing instances wouldn't work if we wanted to add a new
            // document with already existing ID, but it would have different instance
            if (invertedIndex.get(term).stream().noneMatch(entry -> entry.document.getDocId().equals(doc.getId()))) {
                DocumentRef docRef = docReferences.computeIfAbsent(doc.getId(), key -> new DocumentRef(doc.getId()));
                invertedIndex.get(term).add(new IndexEntry(docRef, (int) GeneralUtils.countTfFromTokens(term, tokens)));
            }
        });
    }

    /**
     * Calls indexDoc(Document) while also adding the document to appropriate DocumentCache.
     * @param doc Document
     * @return success status
     */
    private boolean indexDocThroughCache(Document doc) {
        var documentCache = AppWorkspace.getInstance().getDocumentCacheForIndex(this).getDocuments();
        if (documentCache.stream().anyMatch(d -> d.getId().equals(doc.getId()))) {
            LOGGER.warn("Document with ID '" + doc.getId() + "' already exists. Skipping...");
            return false;
        }

        indexDoc(doc);

        documentCache.add(doc);

        return true;
    }

    /**
     * Calculates TF-IDF weights for all indexed documents and saves sum of squares to their DocumentRef.
     */
    private void calculateTfIdf() {
        // NOTE: tf-idf: (1 + log10(tf)) * log10(idf)
        // tf: IndexEntry -> termFreq, df -> docCount, idf -> entryList.size() / df

        invertedIndex.forEach((term, entryList) -> {
            entryList.forEach(docEntry -> {
                // NOTE: entryList.size cannot be 0, because otherwise there would be no entry
                docEntry.tfIdfWeight = (1 + Math.log10(docEntry.termFreq)) *
                                            Math.log10(docCount / (double) entryList.size());
                docEntry.document.addToTfIdfSum(docEntry.tfIdfWeight * docEntry.tfIdfWeight);
            });
        });
    }

    @Override
    public List<String> getDocAbsolutePaths() {
        return docAbsolutePaths;
    }

    @Override
    public void addDocAbsolutePath(String path) {
        docAbsolutePaths.add(path);
    }

    @Override
    public IndexSetting getIndexSetting() {
        return settings;
    }
}
