package cz.zcu.kiv.nlp.ir.trec.searching;

import cz.zcu.kiv.nlp.ir.trec.data.AbstractResult;
import cz.zcu.kiv.nlp.ir.trec.data.Result;
import cz.zcu.kiv.nlp.ir.trec.data.ResultImpl;
import cz.zcu.kiv.nlp.ir.trec.indexing.DocumentRef;
import cz.zcu.kiv.nlp.ir.trec.indexing.IndexEntry;
import cz.zcu.kiv.nlp.ir.trec.indexing.Indexer;
import cz.zcu.kiv.nlp.ir.trec.preprocessing.Preprocessor;
import cz.zcu.kiv.nlp.ir.trec.util.GeneralUtils;

import java.util.*;

public class CosineSimilarity {
	public static List<Result> executeQuery(Indexer index, String query) {
		if (query == null || query.equals("")) {
			return null;
		}

		long timeStart = System.nanoTime();

		var qTokens = Preprocessor.getInstance().processText(query);
		var queryTfDict = GeneralUtils.createTfDict(qTokens);
		var queryTfIdfDict = index.calculateQueryTfIdf(queryTfDict);
		Map<DocumentRef, Map<String, List<IndexEntry>>> relevantDocs = new HashMap<>();
		List<Result> results = new LinkedList<>();

		queryTfIdfDict.forEach((term, qTf) -> {
			var termEntries = index.getEntriesForTerm(term);
			if (termEntries != null) {
				termEntries.forEach(entry -> {
					relevantDocs.computeIfAbsent(entry.document, key -> new HashMap<>());
					relevantDocs.get(entry.document).computeIfAbsent(term, key -> new ArrayList<>());
					relevantDocs.get(entry.document).get(term).add(entry);
				});
			}
		});

		double qSum = 0.0d;
		for (Map.Entry<String, Double> e : queryTfIdfDict.entrySet()) {
			Double tfIdfWeight = e.getValue();
			qSum += tfIdfWeight * tfIdfWeight;
		}
		final double qSumTotal = qSum;

		relevantDocs.forEach((document, termMap) -> {
			double denominator = 0.0d;

			for (Map.Entry<String, List<IndexEntry>> entry : termMap.entrySet()) {
				String term = entry.getKey();
				List<IndexEntry> entries = entry.getValue();

				for (IndexEntry iEntry : entries) {
					denominator += queryTfIdfDict.get(term) * iEntry.tfIdfWeight;
				}
			}

			double similarity = denominator / (Math.sqrt(document.getTfIdfSum()) * Math.sqrt(qSumTotal));
			AbstractResult r = new ResultImpl();
			r.setScore((float) similarity);
			r.setDocumentID(document.getDocId());
			results.add(r);
		});

		Collections.sort(results);

		for (int i = 0; i < results.size(); i++) {
			// potentially dangerous cast
			((ResultImpl) results.get(i)).setRank(i + 1);
		}


		long timeEnd = System.nanoTime();
		System.out.println("Executed query in " + ((timeEnd - timeStart) / 1000000) + "ms");

		return results;
	}
}
