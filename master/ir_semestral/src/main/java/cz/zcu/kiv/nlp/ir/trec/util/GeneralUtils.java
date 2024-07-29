package cz.zcu.kiv.nlp.ir.trec.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import cz.zcu.kiv.nlp.ir.trec.cli.ConsoleInterface;
import cz.zcu.kiv.nlp.ir.trec.core.AppWorkspace;
import cz.zcu.kiv.nlp.ir.trec.data.Document;
import cz.zcu.kiv.nlp.ir.trec.data.DocumentNew;
import cz.zcu.kiv.nlp.ir.trec.indexing.Indexer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Class for methods that can be generally helpful anywhere and can be accessed from anywhere.
 */
public class GeneralUtils {
    static Logger LOGGER = LoggerFactory.getLogger(ConsoleInterface.class);

    /**
     * Counts term frequency in given tokens. Given tokens must already be preprocessed.
     *
     * @param term to search in tokens
     * @param tokens preprocessed tokenized text
     * @return number of occurrences of term in the tokens
     */
    public static long countTfFromTokens(String term, String[] tokens) {
        return Arrays.stream(tokens).filter(token -> token.equals(term)).count();
    }

    /**
     * Creates a map of term and their frequency (term -> frequency)
     * @param tokens Tokens for which frequency is calculated
     * @return Map<String, Integer> with term - TF mapping
     */
    public static HashMap<String, Integer> createTfDict(String[] tokens) {
        HashMap<String, Integer> dict = new HashMap<>();

        Arrays.stream(tokens).forEach(token -> dict.merge(token, 1, Integer::sum));

        return dict;
    }

    /**
     * Loads document/s with .json suffix and tries to parse them in expected format.
     * @param path directory or json file. If it's a directory, all .json files are loaded (non-recursively).
     * @return List<Document> - loaded documents from file/s.
     */
    public static List<Document> loadJSONDocuments(String path) {
        ArrayList<File> jsonFiles = new ArrayList<>();
        List<Document> documents = new LinkedList<>();
        AtomicInteger loadedFileCounter = new AtomicInteger();
        File f = new File(path);

        if (!f.exists()) {
            return null;
        }

        if (f.isDirectory()) {
            var jsonList = f.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    // theoretically should check if the file is a dir, but we assume .json are files for simplicity
                    return name.endsWith(".json");
                }
            });

            if (jsonList == null || jsonList.length == 0) {
                LOGGER.error("Failed to load JSON files from directory: " + path);
                return documents;
            }

            jsonFiles.addAll(List.of(jsonList));
        } else {
            jsonFiles.add(f);
        }

        long timeStart = System.nanoTime();
        jsonFiles.forEach(jsonFile -> {
            var loadedDocs = loadDocumentJSON(jsonFile);
            if (!loadedDocs.isEmpty()) {
                loadedFileCounter.getAndIncrement();
                documents.addAll(loadedDocs);
            }
        });
        long timeEnd = System.nanoTime();
        System.out.println("Loaded " + loadedFileCounter + "/" + jsonFiles.size() + " documents in " +
                           ((timeEnd - timeStart) / 1000000) + "ms");
        if (loadedFileCounter.get() < jsonFiles.size()) {
            System.out.println("Some files failed to load. See logs for more information.");
        }

        return documents;
    }

    /**
     * Deserializes JSON file received through parameter.
     * @param jsonFile JSON file
     * @return List of Document which are created by deserialization
     */
    private static List<Document> loadDocumentJSON(File jsonFile) {
        List<Document> res = new LinkedList<>();
        ObjectMapper mapper = new ObjectMapper();
        var type = mapper.getTypeFactory().constructMapType(HashMap.class, String.class, DocumentNew.class);

        try {
//            long timeStart = System.nanoTime();
            HashMap<String, DocumentNew> docMap = mapper.readValue(jsonFile, type);
            docMap.forEach((url, doc) -> doc.setId(url)); // this cannot be done in deserializer, because its in parent

            res.addAll(docMap.values()); // transform map to list -> url is now stored in id

//            long timeEnd = System.nanoTime();
//            System.out.println("Loaded JSON file (" + jsonFile.getName() + ") in " +
//                    ((timeEnd - timeStart) / 1000000) + "ms");
        } catch (IOException e) {
            LOGGER.error("Failed to deserialize JSON (" + jsonFile.getName() + "). Exception: \n" + e.getMessage());
            System.out.println("Error loading JSON document (" + jsonFile.getName() + "). " +
                    "Please make sure you entered correct path.");
        }

        return res;
    }

    /**
     * Retrieves a Document for specific index. Must access DocumentCache of specified index.
     * NOTE: this is where lazy loading would be implemented (at least partly)
     * @param index which contains desired document
     * @param docId desired document ID
     * @return Document
     */
    public static Document getDocFromIndexCache(Indexer index, String docId) {
        Document d = AppWorkspace.getInstance().getDocumentCacheForIndex(index).getDocuments().stream()
                .filter(doc -> doc.getId().equals(docId))
                .findFirst()
                .orElse(null);

        if (d == null) {
        }

        return d;
    }
}
