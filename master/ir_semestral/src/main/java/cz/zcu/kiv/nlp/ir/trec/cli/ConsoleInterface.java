package cz.zcu.kiv.nlp.ir.trec.cli;

import cz.zcu.kiv.nlp.ir.trec.Main;
import cz.zcu.kiv.nlp.ir.trec.core.AppWorkspace;
import cz.zcu.kiv.nlp.ir.trec.data.Document;
import cz.zcu.kiv.nlp.ir.trec.data.Result;
import cz.zcu.kiv.nlp.ir.trec.indexing.IndexSetting;
import cz.zcu.kiv.nlp.ir.trec.indexing.IndexingMethod;
import cz.zcu.kiv.nlp.ir.trec.searching.BooleanQuery;
import cz.zcu.kiv.nlp.ir.trec.searching.CosineSimilarity;
import cz.zcu.kiv.nlp.ir.trec.util.GeneralUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * Class for interacting with the user. Should contain minimal logic and delegate to appropriate handlers.
 */
public class ConsoleInterface {
    static Logger LOGGER = LoggerFactory.getLogger(ConsoleInterface.class);

    /** This is a convenience var to hold paths when loading index from file.
     * It is used to load indexed documents to cache
     */
    private final static List<String> indexFilePaths = new ArrayList<>();

    /**
     * Parses user input into following command and performs the command:
     *
     * exit/e
     * print/p [subcommand]
     *      page/p [pageNumber] (default)
     *      indexes/i
     *      doc/d {docIndex}
     * index/i {subcommand}
     *      new/n {path1} {path2} {...}
     *      add/a {path1} {path2} {...}
     *      use/u {indexNumber}
     *      delete/d {indexNumber} [deleteFile: boolean]
     *      save/s {indexNumber} {path} [indexName]
     *      load/l {path}
     *      name/m {name}
     * query/q [subcommand] {text}
     *      cos/c (default)
     *      bool/b
     * set/s {subcommand}
     *      stemming/s {true/false}
     *      stopwords/sw {true/false}
     *      indexing/i {number: 1 = only text, 2 = only titles, 3 = titles + text}
     * help/h
     * @param input string received from the user
     */
    public void processInput(String input) {
        String[] commandAndParams = getFirstWord(input);
        String[] subcommandAndParams = getFirstWord(commandAndParams[1]);

        switch (commandAndParams[0]) {
            case "exit",  "e" -> stopProgram();
            case "print", "p" -> {
                if (subcommandAndParams[0] == null) {
                    printPage(null);
                    return;
                }

                switch (subcommandAndParams[0]) {
                    case "page",    "p" -> printPage(subcommandAndParams[1]);
                    case "indexes", "i" -> printIndexes(subcommandAndParams[1]);
                    case "doc",     "d" -> printDocument(subcommandAndParams[1]);
                    default -> System.out.println("'print' error: unrecognized subcommand");
                }
            }
            case "index", "i" -> {
                if (subcommandAndParams[0] == null) {
                    System.out.println("'index' error: {subcommand} is required");
                    return;
                }

                switch (subcommandAndParams[0]) {
                    case "new",    "n" -> indexNew(subcommandAndParams[1]);
                    case "add",    "a" -> indexAdd(subcommandAndParams[1]);
                    case "use",    "u" -> indexUse(subcommandAndParams[1]);
                    case "delete", "d" -> indexDelete(subcommandAndParams[1]);
                    case "save",   "s" -> indexSave(subcommandAndParams[1]);
                    case "load",   "l" -> indexLoad(subcommandAndParams[1]);
                    case "name",   "m" -> indexName(subcommandAndParams[1]);
                    default -> System.out.println("'index' error: unrecognized subcommand");
                }
            }
            case "query", "q" -> {
                if (subcommandAndParams[0] == null) {
                    System.out.println("'query' error: query mustn't be empty");
                    return;
                }

                switch (subcommandAndParams[0]) {
                    case "cos", "c" -> queryCos(subcommandAndParams[1]);
                    case "bool", "b" -> queryBool(subcommandAndParams[1]);
                    default -> queryCos(commandAndParams[1]);
                }
            }
            case "set", "s" -> {
                if (subcommandAndParams[0] == null) {
                    System.out.println("'set' error: you must specify what you are setting");
                    return;
                }

                switch (subcommandAndParams[0]) {
                    case "stemming", "s" -> setStemming(subcommandAndParams[1]);
                    case "stopwords", "sw" -> setStopwords(subcommandAndParams[1]);
                    case "indexing", "i" -> setIndexingMethod(subcommandAndParams[1]);
                    default -> System.out.println("'set' error: unrecognized setting");
                }
            }
            case "help", "h" -> help();
        }
    }

    /*******************************************************************************************************************
     * Index handlers                                                                                                  *
     ******************************************************************************************************************/

    /**
     * Creates new index. Sets newly created index as currently used. Parses parameters into 1 or more paths.
     * @param params path(s) to documents file or directory (only .json files are loaded)
     */
    private void indexNew(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'index new {path1} {path2} {...}': at least one {path} is required parameter");
            return;
        }

        var documents = indexLoadDocuments(params);
        if (documents.isEmpty()) {
            System.out.println("Cannot create index without any documents. Make sure selected destination contains " +
                    "documents to be indexed");
            return;
        }

        int indexNumber = AppWorkspace.getInstance().createNewIndex(documents);
        if (indexNumber < 0) {
            System.out.println("Failed to create index instance");
        } else {
            AppWorkspace.getInstance().setCurrentIndex(indexNumber - 1);

            var index = AppWorkspace.getInstance().getCurrentIndex();
            indexFilePaths.forEach(index::addDocAbsolutePath);

            System.out.println("Successfully created index with number: " + indexNumber);
        }
    }

    /**
     * Adds files to the CURRENTLY used index. Files are loaded from path(s) received by parameter.
     * @param params path(s) to documents file or directory (only .json files are loaded)
     */
    private void indexAdd(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'index add {path1} {path2} {...}': at least one {path} is required parameter");
            return;
        }

        var documents = indexLoadDocuments(params);
        if (documents.isEmpty()) {
            System.out.println("No documents found. Aborting addition of documents...");
            return;
        }

        if (!AppWorkspace.getInstance().addDocumentsToCurrentIndex(documents)) {
            System.out.println("Cannot add documents, because there is not active index. Use 'index use {indexNumber}");
            return;
        }

        var index = AppWorkspace.getInstance().getCurrentIndex();
        indexFilePaths.forEach(index::addDocAbsolutePath);

        System.out.println("Finished adding documents to current index");
    }

    /**
     * Sets CURRENTLY used index to the desired number.
     * @param params desired index number (not actually list index, -1 is applied to the param).
     */
    private void indexUse(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'index use {indexNumber}': {indexNumber} is required parameter");
            return;
        }
        if (params.matches("\\s+")) {
            System.out.println("'index use {indexNumber}': only 1 parameter is expected");
            return;
        }

        int indexNumber = 0;
        try {
            indexNumber = Integer.parseInt(params);
        } catch (NumberFormatException e) {
            System.out.println("'index use {indexNumber}': parameter must be whole number");
            return;
        }

        if (!AppWorkspace.getInstance().setCurrentIndex(indexNumber - 1)) {
            System.out.println("'index use {indexNumber}': " + indexNumber + " is not a valid index number");
        }
    }

    /**
     * Removes selected index. Index number is required parameter but optionally boolean is supplied to remove file
     * index if it exists.
     * @param params string containing {indexNumber} (must be valid) and [deleteFile: bool] (optional)
     */
    private void indexDelete(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'index delete {indexNumber} [deleteFile]': {indexNumber} is required parameter");
            return;
        }

        String[] pParts = params.split("\\s+");
        if (pParts.length > 2) {
            System.out.println("'index delete {indexNumber} [deleteFile]': maximum of 2 parameters is expected");
            return;
        }

        int indexNumber = 0;
        try {
            indexNumber = Integer.parseInt(pParts[0]);
        } catch (NumberFormatException e) {
            System.out.println("'index delete {indexNumber} [deleteFile]': {indexNumber} must be whole number");
            return;
        }

        boolean removeFile = false;
        if (pParts.length == 2) {
            try {
                removeFile = Boolean.parseBoolean(pParts[1]);
            } catch (NumberFormatException e) {
                System.out.println("'index delete {indexNumber} [deleteFile]': [deleteFile] must be boolean (true/false)");
                return;
            }
        }

        if (!AppWorkspace.getInstance().deleteIndex(indexNumber - 1, removeFile)) {
            System.out.println("'index delete {indexNumber} [deleteFile]': " + indexNumber +
                               " is not a valid index number");
        }
    }

    /**
     * Saves index to a file. Takes 2 required + 1 optional parameters. Parameters must be valid. Parameters are:
     * indexNumber - index that we wish to save, path - target DIRECTORY for the index, indexName - (optional)
     * uses this name to name the index and save the file with this name.
     * @param params string of parameters in this order {indexNumber} {path} [indexName]
     */
    private void indexSave(String params) {
//        {indexNumber} {path} [indexName]
        if (params == null || params.equals("")) {
            System.out.println("'index save {indexNumber} {path} [indexName]': {indexNumber} and {path} are required" +
                    " parameters. {path} must be a directory.");
            return;
        }

        String[] pParts = params.split("\\s+");
        if (pParts.length > 3) {
            System.out.println("'index save {indexNumber} {path} [indexName]': maximum of 3 parameters is expected");
            return;
        }
        if (pParts.length < 2) {
            System.out.println("'index save {indexNumber} {path} [indexName]': minimum of 2 parameters is expected");
            return;
        }


        int indexNumber = 0;
        try {
            indexNumber = Integer.parseInt(pParts[0]);
        } catch (NumberFormatException e) {
            System.out.println("'index delete {indexNumber} [deleteFile]': {indexNumber} must be whole number");
            return;
        }

        if (indexNumber < 1 || indexNumber > AppWorkspace.getInstance().getIndexes().size()) {
            System.out.println("'index use {indexNumber}': {indexNumber} must be between 1 and " +
                    AppWorkspace.getInstance().getIndexes().size());
            return;
        }

        if (pParts.length == 2) {
            AppWorkspace.getInstance().saveIndex(indexNumber - 1, pParts[1]);
        } else {
            AppWorkspace.getInstance().saveIndex(indexNumber - 1, pParts[1], pParts[2]);
        }
    }

    /**
     * Loads index from a file. Requires 1 parameters.
     * @param params string with {path} parameter. {path} must lead to saved index file.
     */
    private void indexLoad(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'index load {path}': {path} is required parameter");
            return;
        }
        if (params.matches("\\s+")) {
            System.out.println("'index load {path}': only 1 parameter expected");
            return;
        }

        int rv = AppWorkspace.getInstance().loadIndex(params);
        if (rv < 0) {
            System.out.println("'index load {path}': failed to load index");
        } else {
            System.out.println("Successfully loaded index from file");
        }
    }

    /**
     * Names CURRENT index. This is just for convenience to be table to tell apart multiple indexes. Also
     * this name is used as default name for saving index to a file (this name is used as the filename!!).
     * @param params string with {name} parameter, that is applied to CURRENT index
     */
    private void indexName(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'index name {name}': {name} is required parameter");
            return;
        }
        if (params.matches("\\s+")) {
            System.out.println("'index name {name}': only 1 parameter expected");
            return;
        }

        AppWorkspace.getInstance().setCurrentIndexName(params);
    }


    /*******************************************************************************************************************
     * Print handlers                                                                                                  *
     ******************************************************************************************************************/

    /**
     * Prints a page of results. Takes one optional parameter. If parameter isn't supplied, then last page is printed.
     * @param params string with [pageNumber] that is to be printed.
     */
    private void printPage(String params) {
        if (AppWorkspace.getInstance().results == null) {
            System.out.println("'print page {pageNumber}': nothing to print. Run a query first");
            return;
        }

        if (params == null) {
            LOGGER.debug("Printing current page");
//            return;
            params = AppWorkspace.getInstance().currentPage.toString();
        }

        if (params.matches("\\s+")) {
            System.out.println("'print page {pageNumber}': expects exactly one parameter - {pageNumber}");
            return;
        }

        try {
            int newPage = Integer.parseInt(params);
            int maxPage = AppWorkspace.getInstance().results.size() / AppWorkspace.PAGE_SIZE + 1;
            if (newPage < 1 || newPage > maxPage) {
                System.out.println("Incorrect page number. Page number must be between 1 and " + maxPage);
                return;
            }

            AppWorkspace.getInstance().currentPage = newPage;
        } catch (NumberFormatException e) {
            System.out.println("'print page {pageNumber}': {pageNumber} must be whole number");
            return;
        }

        int pagesTotal = (int) Math.ceil(AppWorkspace.getInstance().results.size() / (double) AppWorkspace.PAGE_SIZE);
        System.out.println("====== Last query results (page " + AppWorkspace.getInstance().currentPage +
                           "/" + pagesTotal + ") ======");

        if (AppWorkspace.getInstance().results.isEmpty()) {
            System.out.println("No results match the query");
            return;
        }

        final int startIndex = (AppWorkspace.getInstance().currentPage - 1) * AppWorkspace.PAGE_SIZE;
        if (startIndex > AppWorkspace.getInstance().results.size()) {
            System.out.println("Page number is invalid (too high): " + AppWorkspace.getInstance().currentPage);
            AppWorkspace.getInstance().currentPage = 1;
            return;
        }

        final int endIndex = Math.min(AppWorkspace.getInstance().results.size(), (startIndex + AppWorkspace.PAGE_SIZE));
        for (int i = startIndex; i < endIndex; i++) {
            Result r = AppWorkspace.getInstance().results.get(i);
            Document d = GeneralUtils.getDocFromIndexCache(AppWorkspace.getInstance().getCurrentIndex(),
                                                           r.getDocumentID());

            if (d == null) {
                LOGGER.error("Failed to retrieve document from document list. Sought ID: " + r.getDocumentID());
                continue;
            }

            System.out.println(r.getRank() + ". " + d.getTitle() + " (score: " + r.getScore() + ")");
        }
    }

    /**
     * Prints list of current indexes. No parameters
     * @param params string - IGNORED
     */
    private void printIndexes(String params) {
        if (params != null) {
            LOGGER.info("'print indexes': ignoring parameters (" + params + ")");
        }

        if (AppWorkspace.getInstance().getIndexes().isEmpty()) {
            System.out.println("'print indexes': no indexes yet. Create new index or load existing one");
            return;
        }

        var currentIndexInfo = AppWorkspace.getInstance().getCurrentIndexInformation();
        for (int i = 0; i < AppWorkspace.getInstance().getIndexes().size(); i++) {
            String record = (i + 1) + "";

            var indexInfo = AppWorkspace.getInstance().getIndexes().get(i);
            if (currentIndexInfo != null && indexInfo == currentIndexInfo) {
                record += " (current)";
            }

            record += ". " + AppWorkspace.getInstance().getIndexes().get(i).toString();
            System.out.println(record);
        }
    }

    /**
     * Prints a document from result list. Requires one parameter.
     * @param params string with parameter {documentNumber} which is result_index + 1
     */
    private void printDocument(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'print doc {documentNumber}': {documentNumber} is required parameter");
            return;
        }
        if (params.matches("\\s+")) {
            System.out.println("'print doc {documentNumber}': only 1 parameter is expected");
            return;
        }

        var results = AppWorkspace.getInstance().results;
        if (results == null || results.isEmpty()) {
            System.out.println("'print doc {documentNumber}': there are no results. Run a query first");
            return;
        }

        int resultNumber = 1;
        try {
            resultNumber = Integer.parseInt(params);
        } catch (NumberFormatException e) {
            System.out.println("'print doc {documentNumber}': parameter must be whole number");
            return;
        }

        if (resultNumber <= 0 || (resultNumber - 1) > results.size()) {
            System.out.println("'print doc {documentNumber}': {documentNumber} must be between 1 and " +
                    results.size() + ". Please enter valid {documentNumber}");
            return;
        }

        Result r = results.get(resultNumber - 1);
        Document d = GeneralUtils.getDocFromIndexCache(AppWorkspace.getInstance().getCurrentIndex(), r.getDocumentID());

        if (d == null) {
            LOGGER.error("Failed to retrieve document from document list. Sought ID: " + r.getDocumentID());
            System.out.println("Cannot print document. Failed to find it in document cache.");
            return;
        }

        System.out.println("====== Document =======");
        System.out.println("Title: " + d.getTitle());
        System.out.println("Content: " + d.getText());
    }


    /*******************************************************************************************************************
     * Query handlers                                                                                                  *
     ******************************************************************************************************************/

    /**
     * Performs a cosine similarity query on CURRENT index (using tf-idf). Required query text as parameter.
     * @param params query string, it is handed to query executor as it is.
     */
    private void queryCos(String params) {
        if (AppWorkspace.getInstance().getCurrentIndex() == null) {
            System.out.println("'query cos {query}: there is no index. Create an index first");
            return;
        }

        var results = CosineSimilarity.executeQuery(AppWorkspace.getInstance().getCurrentIndex(), params);

        if (results == null) {
            System.out.println("Failed to execute query");
            return;
        }

        AppWorkspace.getInstance().results = results;

        printPage("1");
    }

    /**
     * Performs a boolean query on CURRENT index. Required query text as parameter.
     * @param params query string, it is handed to query executor as it is.
     */
    private void queryBool(String params) {
        if (AppWorkspace.getInstance().getCurrentIndex() == null) {
            System.out.println("'query cos {query}: there is no index. Create an index first");
            return;
        }

        var results = BooleanQuery.executeQuery(AppWorkspace.getInstance().getCurrentIndex(), params);

        if (results == null) {
            System.out.println("Failed to execute query");
            return;
        }

        AppWorkspace.getInstance().results = results;

        printPage("1");
    }

    /*******************************************************************************************************************
     * Help handlers                                                                                                   *
     ******************************************************************************************************************/

    /**
     * Prints help for thi application on how to use which command.
     */
    private void help() {
        System.out.println("Following commands are available:");

        System.out.println("\thelp | h - this menu");

        System.out.println("\texit | e - exits the program");

        System.out.println("\tprint | p [subcommand] - print current page of query results or specify subcommand to " +
                "print other information");
        System.out.println("\t\t page | p [pageNumber] - prints page with [pageNumber] or current page");
        System.out.println("\t\t indexes | i - prints all currently available indexes");
        System.out.println("\t\t doc | d {docNumber} - prints a document from current page with {docNumber}");

        System.out.println("\tindex | i {subcommand} - manipulates indexes. Requires subcommand");
        System.out.println("\t\t new | n {path1} [path2] [...] - creates a new index with documents read from " +
                "'.json' files in target directory or the file {path} points to");
        System.out.println("\t\t add | a {path1} [path2] [...] - adds new document/s to current index (use print i " +
                "to list indexes). Reads '.json' file or all files from directory");
        System.out.println("\t\t use | u {indexNumber} - sets index with {indexNumber} as current index. Use print " +
                "indexes to list all available indexes");
        System.out.println("\t\t delete | d {indexNumber} [deleteFile: true/false] - deletes index with " +
                "{indexNumber} from memory and if its a file index and [deleteFile] is true, also delete index file");
        System.out.println("\t\t save | s {indexNumber} {path} [indexName] - saves index with {indexNumber} to " +
                "{path} (must be a dir) with filename [indexName] - setting the index name");
        System.out.println("\t\t load | l {path} - loads an index from {path} file");
        System.out.println("\t\t name | m {name} - set {name} of current index (this name is used as default when " +
                "saving index to a file)");

        System.out.println("\tquery | q [subcommand] {text} - executes a query on current index. " +
                "Requires query {text}. Use [subcommand] to specify query type");
        System.out.println("\t\t cos | c {text} - uses cosine similarity and tf-idf weights to select results");
        System.out.println("\t\t bool | b {text} - uses boolean operations to select results. Operators AND, OR, NOT " +
                "are available, but the must be in Upper Case");

        System.out.println("\tset | s {subcommand} - allows to manipulate settings for indexing. Only applies to " +
                "newly created index. Same settings are automatically used to process queries. " +
                "Requires {subcommand} to specify what is being set");
        System.out.println("\t\t stemming | s {true/false} - apply stemming to tokens (true is default)");
        System.out.println("\t\t stopwords | sw {true/false} - use stopwords or allow all tokens (false is default)");
        System.out.println("\t\t indexing | i {number = {1, 2, 3}} - specify what is being indexed. {number} is " +
                "an enum");
        System.out.println("\t\t\t 1 - only uses the text from a document (default)");
        System.out.println("\t\t\t 2 - only uses the title from a document");
        System.out.println("\t\t\t 3 - uses 'title text' combination");

    }

    /*******************************************************************************************************************
     * Stop handlers                                                                                                   *
     ******************************************************************************************************************/

    /**
     * Stops the main loop of this program and performs a clean exit (saving current indexes).
     */
    private void stopProgram() {
        System.out.println("Exiting...");
        Main.running = false;

        // save file-based indexes when exiting..
        for (int i = 0; i < AppWorkspace.getInstance().getIndexes().size(); i++) {
            var indexInfo = AppWorkspace.getInstance().getIndexes().get(i);
            if (indexInfo.isFileIndex && indexInfo.indexPath != null && !indexInfo.indexPath.equals("")) {
                System.out.println("Saving file-based index: " + indexInfo.name);
                String indexDir = indexInfo.indexPath.substring(0, indexInfo.indexPath.lastIndexOf(File.separator));
                AppWorkspace.getInstance().saveIndex(i, indexDir);
            }
        }

        System.out.println("Good bye");
    }

    /*******************************************************************************************************************
     * Stop handlers                                                                                                   *
     ******************************************************************************************************************/

    /**
     * Manipulates IndexSetting.APPLY_STEMMING option. Requires 1 parameter.
     * @param params string with {boolean} value for the option
     */
    private void setStemming(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'set stemming {boolean}': requires parameter");
            return;
        }

        IndexSetting.APPLY_STEMMING = Boolean.parseBoolean(params);
    }

    /**
     * Manipulates IndexSetting.REMOVE_STOPWORDS option. Requires 1 parameter.
     * @param params string with {boolean} value for the option
     */
    private void setStopwords(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'set stopwords {boolean}': requires parameter");
            return;
        }

        IndexSetting.REMOVE_STOPWORDS = Boolean.parseBoolean(params);
    }

    /**
     * Manipulates IndexSetting.REMOVE_STOPWORDS option. Requires 1 parameter.
     * @param params string with {integer} value for the option (enum of 1, 2 ,3)
     */
    private void setIndexingMethod(String params) {
        if (params == null || params.equals("")) {
            System.out.println("'set indexing {number {1, 2, 3}}': requires parameter");
            return;
        }

        int option;
        try {
            option = Integer.parseInt(params);
        } catch (NumberFormatException e) {
            System.out.println("'set indexing {number {1, 2, 3}}': parameter must be a number");
            return;
        }

        switch (option) {
            case 1 -> IndexSetting.INDEXING_METHOD = IndexingMethod.TEXT_ONLY;
            case 2 -> IndexSetting.INDEXING_METHOD = IndexingMethod.TITLE_ONLY;
            case 3 -> IndexSetting.INDEXING_METHOD = IndexingMethod.TEXT_AND_TITLE;
            default -> System.out.println(option + " is not a valid number! Please enter a valid number");
        }
    }


    /*******************************************************************************************************************
     * Other                                                                                                           *
     ******************************************************************************************************************/

    /**
     * Returns array with 2 Strings. First String is the first word of @text or @text if it is a single word.
     * Second String is either remainder of the text or null;
     * @param text from which first word is extracted
     * @return Array with 2 Strings
     */
    private String[] getFirstWord(String text) {
        if (text == null || text.equals("")) {
            return new String[] {null, null};
        }

        int spaceIndex = text.indexOf(' ');
        String word;
        String remainingText = null;

        if (spaceIndex <= 0) {
            word = text.trim();
        } else {
            word = text.substring(0, spaceIndex).trim();
            remainingText = text.substring(spaceIndex).trim();
        }

        return new String[]{word, remainingText};
    }

    /**
     * Method for loading documents from path(s). Only .json documents are loaded. Jsons have format of:
     * {
     *     'docId': {
     *         'title': "testTitle",
     *         'content': "testText",
     *         'timestampCrawled': "1.2.1970.." {iso8601}
     *     },
     *     'docId2' {
     *         ...
     *     }
     * }
     * @param paths string with path(s) to a .json file or directory (reads all .json files)
     * @return list of read documents
     */
    private List<Document> indexLoadDocuments(String paths) {
        String[] pParts = paths.split("\\s+");

        // addition, for saving document paths to index
        indexFilePaths.clear();

        List<Document> documents = new LinkedList<>();
        Arrays.stream(pParts).forEach(path -> {
            var docs = GeneralUtils.loadJSONDocuments(path);
            if (docs == null) {
                System.out.println("Failed to load documents from path: " + path);
            } else if (docs.size() == 0) {
                System.out.println("No documents found on/in: " + path);
            } else {
                documents.addAll(docs);
                indexFilePaths.add(path);
            }
        });

        return documents;
    }
}
