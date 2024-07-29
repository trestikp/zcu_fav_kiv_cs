package cz.zcu.kiv.nlp.ir.trec.data;

import java.util.LinkedList;
import java.util.List;

/**
 * Convenience class to hold documents for an index. Originally this was supposed to be more powerful and hold only
 * recent/ desired documents in cache, but currently all documents are in the case and lazy loading is missing.
 */
public class DocumentCache {
    private final List<Document> documents = new LinkedList<>();


    public List<Document> getDocuments() {
        return documents;
    }
}
