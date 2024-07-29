package cz.zcu.kiv.nlp.ir.trec.indexing;

import cz.zcu.kiv.nlp.ir.trec.data.Document;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Tigi on 6.1.2015.
 *
 * Rozhraní, pro indexaci dokumentů.
 *
 * Pokud potřebujete/chcete můžete přidat další metody např. pro indexaci po jednotlivých dokumentech
 * a jiné potřebné metody (např. CRUD operace update, delete, ... dokumentů), ale zachovejte původní metodu.
 *
 * metodu index implementujte ve třídě {@link Index}
 */
public interface Indexer extends Serializable {

    /**
     * Metoda zaindexuje zadaný seznam dokumentů
     *
     * @param documents list dokumentů
     */
    void index(List<Document> documents);
    void indexDocument(Document document);
    List<IndexEntry> getEntriesForTerm(String term);
    Map<String, Double> calculateQueryTfIdf(HashMap<String, Integer> tokenDict);
    List<String> getDocAbsolutePaths();
    void addDocAbsolutePath(String path);
    IndexSetting getIndexSetting();
//    void removeDocAbsolutePath(String path);
}
