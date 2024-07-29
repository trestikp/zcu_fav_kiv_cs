/**
 * Copyright (c) 2014, Michal Konkol
 * All rights reserved.
 *
 */
package cz.zcu.kiv.nlp.ir.trec.preprocessing;

import cz.zcu.kiv.nlp.ir.trec.indexing.IndexSetting;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Michal Konkol
 */
public class AdvancedTokenizer implements Tokenizer {
    /** regex used for tokenizing. Using this regex its possible to extract URLs, dates, numbers, chars/ digits, html, punctuation */
    public static final String tokenizerRegex = "(https?|ftp|file)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]|(\\d+.\\d+.(\\d+)?)|(\\d+[.,](\\d+)?)|([\\p{L}\\d\\*]+)|(<.*?>)|([\\p{Punct}])";

    private static final String DEFAULT_STOPWORDS_FILE = "stopwords-en.txt";
    /** Loaded stopwords. Empty list when none are loaded */
    private static List<String> stopwords = new ArrayList<>();

    static Logger LOGGER = LoggerFactory.getLogger(AdvancedTokenizer.class);


    static {
        InputStream stopwordsStream = AdvancedTokenizer.class.getClassLoader().getResourceAsStream(DEFAULT_STOPWORDS_FILE);

        if (stopwordsStream != null) {
            try {
                BufferedReader br = new BufferedReader(new InputStreamReader(stopwordsStream));
                String line;

                while ((line = br.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        stopwords.add(line.trim());
                    }
                }
                br.close();
            } catch (IOException | NullPointerException e) {
                LOGGER.error("Failed to read stopwords file. Exception: " + e.getMessage());
            }
        }
    }

    /**
     * Tokenize @text using matching with @regex. Stopwords are applied on the tokens if IndexSetting.REMOVE_STOPWORDS
     * is true
     * @param text string to be tokenized
     * @param regex regex used for matching
     * @return array of String = tokens
     */
    public static String[] tokenize(String text, String regex) {
        Pattern pattern = Pattern.compile(regex);

        List<String> tokens = new ArrayList<>();

        Matcher matcher = pattern.matcher(text);
        while (matcher.find()) {
            int start = matcher.start();
            int end = matcher.end();

            tokens.add(text.substring(start, end));
        }

        for (int i = 0; i < tokens.size(); i++) {
            tokens.set(i, tokens.get(i).trim().toLowerCase());
        }

        if (IndexSetting.REMOVE_STOPWORDS) {
            tokens.removeAll(stopwords);
        }

        tokens.removeAll(List.of(""));

        String[] ws = new String[tokens.size()];
        ws = tokens.toArray(ws);

        return ws;
    }

    /**
     * Tokenize @text using matching with default @regex. Stopwords are applied on the tokens if
     * IndexSetting.REMOVE_STOPWORDS is true.
     * @param text string to be tokenized
     * @return array of String = tokens
     */
    @Override
    public String[] tokenize(String text) {
        return tokenize(text, tokenizerRegex);
    }
}
