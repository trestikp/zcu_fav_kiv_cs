package cz.zcu.kiv.nlp.ir.trec.indexing;

import java.io.Serializable;

/**
 * This is used to determine what will be used as the document text for indexing.
 */
public enum IndexingMethod implements Serializable {
    TEXT_ONLY,
    TITLE_ONLY,
    TEXT_AND_TITLE
}
