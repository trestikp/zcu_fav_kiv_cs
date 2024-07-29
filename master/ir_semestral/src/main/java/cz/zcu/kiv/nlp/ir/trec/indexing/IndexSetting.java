package cz.zcu.kiv.nlp.ir.trec.indexing;

import java.io.Serializable;

/**
 * Settings for indexing and query processing, these settings are extracted to each index to allow each index to have
 * its own settings.
 */
public class IndexSetting implements Serializable {
    public static boolean REMOVE_STOPWORDS = false;
    public static boolean APPLY_STEMMING = true;
    public static IndexingMethod  INDEXING_METHOD = IndexingMethod.TEXT_AND_TITLE;

    /**
     * Extract current values to an instance which is saved on index.
     * @return instance of this class
     */
    public static IndexSetting extractSettings() {
        return new IndexSetting();
    }

    /**
     * Applies settings from index to be global (used by queries as well).
     * @param settings instance of this class
     */
    public static void applySettings(IndexSetting settings) {
        IndexSetting.REMOVE_STOPWORDS = settings.removeStopwords;
        IndexSetting.APPLY_STEMMING = settings.applyStemming;
        IndexSetting.INDEXING_METHOD = settings.indexingMethod;
    }

    public boolean removeStopwords;
    public boolean applyStemming;
    public IndexingMethod indexingMethod;
    private IndexSetting() {
        removeStopwords = IndexSetting.REMOVE_STOPWORDS;
        applyStemming = IndexSetting.APPLY_STEMMING;
        indexingMethod = IndexSetting.INDEXING_METHOD;
    }
}