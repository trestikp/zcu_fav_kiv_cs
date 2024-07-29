package cz.zcu.kiv.nlp.ir.trec.core;

import cz.zcu.kiv.nlp.ir.trec.data.DocumentCache;
import cz.zcu.kiv.nlp.ir.trec.indexing.Index;

/**
 * Wrapper for meta-information about an index.
 */
public class IndexInformation {
    /** Name is optional */
    public String name = "";
    /** Flag if index is saved to file - optional */
    public Boolean isFileIndex = false;
    /** Path to the file of the index (if it's file-based) */
    public String indexPath = null;

    /** Reference to the index itself */
    private final Index index;
    /** Documents of the index held in memory - currently missing lazy loading (all documents must be in cache) */
    private final DocumentCache docCache;

    public IndexInformation(Index index) {
        this.index = index;
        docCache = new DocumentCache();
    }

    public Index getIndex() {
        return index;
    }

    public DocumentCache getDocCache() {
        return docCache;
    }

    @Override
    public String toString() {
        return "Index: " + (name.equals("") ? "unnamed" : name) + ", file based: " +
                (isFileIndex ? "true, index file path: " + indexPath : "false");
    }
}
