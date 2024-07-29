package cz.zcu.kiv.nlp.ir.trec.core;

import cz.zcu.kiv.nlp.ir.trec.cli.ConsoleInterface;
import cz.zcu.kiv.nlp.ir.trec.data.Document;
import cz.zcu.kiv.nlp.ir.trec.data.DocumentCache;
import cz.zcu.kiv.nlp.ir.trec.data.Result;
import cz.zcu.kiv.nlp.ir.trec.indexing.Index;
import cz.zcu.kiv.nlp.ir.trec.indexing.IndexSetting;
import cz.zcu.kiv.nlp.ir.trec.indexing.Indexer;
import cz.zcu.kiv.nlp.ir.trec.util.GeneralUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Holder for main information about running application. Contains high-level handlers for user commands.
 * This class is an instance.
 */
public class AppWorkspace {
    static Logger LOGGER = LoggerFactory.getLogger(ConsoleInterface.class);

    /** Number of results, that is printed on single page */
    public static final Integer PAGE_SIZE = 10;

    /** Holds current in-memory indexes and their meta-information */
    private final List<IndexInformation> indexes = new ArrayList<>(8);
    /** Contains results from the latest ran query */
    public List<Result> results = null;
    /** Currently displayed result page with a maximum of (results.size() / PAGE_SIZE) */
    public Integer currentPage = 1;
    /** Index that is currently used and all action that do not specify index number are performed on this (eg. queries) */
    private Index currentIndex = null;

    private static AppWorkspace instance;

    public static AppWorkspace getInstance() {
        if (instance == null) {
            instance = new AppWorkspace();
        }
        return instance;
    }

    /**
     * Handler to create a new index.
     * @param documents List<Document> documents, required
     * @return the index number
     */
    public int createNewIndex(List<Document> documents) {
        if (documents == null || documents.isEmpty()) {
            return -1;
        }

        Index index = new Index();
        this.indexes.add(new IndexInformation(index));

        // indexing after filling document cache, so index can check if document ID isn't duplicate
        index.index(documents);

        return this.indexes.size();
    }

    /**
     * Handler to add new documents to already existing index. The existing index must be set as the CURRENT index!
     * @param documents List<Document> documents, required
     * @return true on success, false on failure
     */
    public boolean addDocumentsToCurrentIndex(List<Document> documents) {
        if (this.currentIndex == null) {
            return false;
        }

        this.currentIndex.index(documents);

        return true;
    }

    /**
     * @return currentIndex (Index)
     */
    public Index getCurrentIndex() {
        return currentIndex;
    }

    /**
     * @return indexes (List<IndexInformation>)
     */
    public List<IndexInformation> getIndexes() {
        return indexes;
    }

    /**
     * Sets current index. Clears results and restores the index settings.
     * @param indexIndex index of desired index in indexes
     * @return true on success, false otherwise
     */
    public boolean setCurrentIndex(int indexIndex) {
        if (indexIndex < 0 || indexIndex >= indexes.size()) {
            return false;
        }
        this.currentIndex = indexes.get(indexIndex).getIndex();
        this.results = null; // remove previous query results when swapping index
        IndexSetting.applySettings(this.currentIndex.getIndexSetting()); // apply index setting for query processing

        return true;
    }

    /**
     * Deletes index with selected index (indexIndex) from memory and optionally its file (if it is file-based).
     * @param indexIndex index of the index in indexes
     * @param removeFile boolean to remove index file (if it's file-based)
     * @return true on success, false otherwise
     */
    public boolean deleteIndex(int indexIndex, boolean removeFile) {
        if (indexIndex < 0 || indexIndex >= indexes.size()) {
            return false;
        }

        if (removeFile) {
            IndexInformation i  = this.indexes.get(indexIndex);
            try {
                Files.delete(Path.of(i.indexPath));
            } catch (IOException e) {
                System.out.println("Failed to delete index file. The file will be preserved.");
            }
        }

        this.indexes.remove(indexIndex);


        return true;
    }

    /**
     * Saves selected index to supplied path. Uses index name as default filename for the index or current timestamp
     * if the index doesn't have a name.
     * @param indexIndex index of the index in indexes
     * @param path target path (must be a directory)
     */
    public void saveIndex(int indexIndex, String path) {
        var indexInfo = indexes.get(indexIndex);
        if (indexInfo.name != null && !indexInfo.name.equals("")) {
            saveIndex(indexIndex, path, indexInfo.name);
        } else {
            DateFormat SDF = new SimpleDateFormat("yyyyMMdd_HHmmSS");
            saveIndex(indexIndex, path, SDF.format(new Date())); // using current timestamp as the name
        }
    }

    /**
     * Saves selected index to supplied path. Saves the index under supplied filename.
     * @param indexIndex index of the index in indexes
     * @param filename filename under which the index will be saved
     * @param path target path (must be a directory)
     */
    public void saveIndex(int indexIndex, String path, String filename) {
        if (indexIndex < 0 || indexIndex >= indexes.size()) {
            System.out.println("index out of bounds - return or print?");
            return;
        }

        var indexInfo = indexes.get(indexIndex);

//        filename = filename + ".idx";

        try (FileOutputStream fout = new FileOutputStream(path + File.separator + filename)) {
            ObjectOutputStream oos = new ObjectOutputStream(fout);
            oos.writeObject(indexInfo.getIndex());
            oos.flush();
            oos.close();
        } catch (IOException e) {
            LOGGER.error("Cannot save index. Reason: " + e.getMessage());
            System.out.println("Cannot save index because " + path + File.separator + filename + " doesn't exit or it" +
                    " isn't a directory.");
            return;
        }

        String indexPath = new File(path + File.separator + filename).getAbsolutePath();
        indexInfo.indexPath = indexPath;
        indexInfo.name = filename;
        indexInfo.isFileIndex = true;

        System.out.println("Successfully saved index. Path (absolute): " + indexPath);
    }

    /**
     * Loads index from supplied path.
     * @param path Path to the index file.
     * @return index number (index + 1) of loaded index, -1 on error
     */
    public int loadIndex(String path) {
        try (FileInputStream fin = new FileInputStream(path)) {
            ObjectInputStream ois = new ObjectInputStream(fin);
            Index index = (Index) ois.readObject();

            File indexFile = new File(path);
            IndexInformation indexInfo = new IndexInformation(index);
            indexInfo.name = indexFile.getName();
            indexInfo.isFileIndex = true;
            indexInfo.indexPath = indexFile.getAbsolutePath();
            this.indexes.add(indexInfo);

            List<Document> documents = new LinkedList<>();
            index.getDocAbsolutePaths().forEach(docPath -> {
                var loadedDocs = GeneralUtils.loadJSONDocuments(docPath);
                if (loadedDocs != null) {
                    documents.addAll(loadedDocs);
                } else {
                    LOGGER.error("Failed to load documents into cache while loading index from a file. Path " +
                            docPath + " is no longer valid");
                }
            });
            indexInfo.getDocCache().getDocuments().addAll(documents);

            return this.indexes.size();
        } catch (IOException | ClassNotFoundException e ) {
            LOGGER.error("Cannot load index. Reason: " + e.getMessage());
            System.out.println("Cannot load index because " + path + " doesn't exist or the index file is damaged.");
        }

        return -1;
    }

    /**
     * Sets name of the CURRENT index.
     * @param name desired name
     */
    public void setCurrentIndexName(String name) {
        var info = indexes.stream().filter(indexInfo -> indexInfo.getIndex() == currentIndex).findFirst();
        info.ifPresent(indexInformation -> indexInformation.name = name);
    }

    /**
     * Returns DocumentCache for @index or null.
     * @param index desired index
     * @return DocumentCache of the index
     */
    public DocumentCache getDocumentCacheForIndex(Indexer index) {
        return this.indexes.stream().filter(indexInfo -> indexInfo.getIndex() == index)
                .findFirst()
                .map(IndexInformation::getDocCache).orElse(null);
    }

    public IndexInformation getCurrentIndexInformation() {
        return this.indexes.stream().filter(indexInfo -> indexInfo.getIndex() == currentIndex)
                .findFirst().orElse(null);
    }
}
