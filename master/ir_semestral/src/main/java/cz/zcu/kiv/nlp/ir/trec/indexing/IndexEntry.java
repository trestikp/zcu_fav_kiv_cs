package cz.zcu.kiv.nlp.ir.trec.indexing;

import java.io.Serializable;

/**
 * Instances of this class are saved in the index instead of just document ID. Reason is to save some memory by
 * having term frequency paired with "document ID". Also replaced document ID with reference to document
 */
public class IndexEntry implements Serializable {
    /** Document reference (originally was the Document itself, but they get serialized to file in the index itself) */
    public DocumentRef document;
    /** Term frequency in the @document - used to calculate TF-IDF weight */
    public Integer termFreq;
    /** TF-IDF weight of a term in @document */
    public Double tfIdfWeight = 0.0d;

    public IndexEntry(DocumentRef document, Integer termFreq) {
        this.document = document;
        this.termFreq = termFreq;
    }
}
