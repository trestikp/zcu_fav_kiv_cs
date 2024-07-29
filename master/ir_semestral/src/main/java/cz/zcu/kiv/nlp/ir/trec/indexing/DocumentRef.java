package cz.zcu.kiv.nlp.ir.trec.indexing;

import java.io.Serializable;

/**
 * Convenience class replacing document IDs in the index. Reason is that tfIdfSum of the document can be saved here
 * and it saves processing time.
 */
public class DocumentRef implements Serializable {
    private final String documentId;
    private Double tfIdfSum = 0.0d; // used for cosine similarity


    public DocumentRef(String documentId) {
        this.documentId = documentId;
    }

    public String getDocId() {
        return documentId;
    }

    public Double getTfIdfSum() {
        return tfIdfSum;
    }

    public void addToTfIdfSum(double tfIdfWeight) {
        this.tfIdfSum += tfIdfWeight;
    }
}
