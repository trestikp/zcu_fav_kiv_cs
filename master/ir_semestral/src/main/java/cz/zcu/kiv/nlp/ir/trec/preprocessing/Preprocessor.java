package cz.zcu.kiv.nlp.ir.trec.preprocessing;

import cz.zcu.kiv.nlp.ir.trec.indexing.IndexSetting;
import cz.zcu.kiv.nlp.ir.trec.preprocessing.RovoMe.EnglishStemmer.PorterStemmer;

import java.util.List;

/**
 * Wrapper class (singleton) for preprocessing. This class holds a tokenizer and stemmer which use global setting
 * from IndexSetting. Preprocessing with this setting is used for indexing and query processing.
 */
public class Preprocessor {
	private static Preprocessor instance;

	private final Tokenizer tokenizer;
	private final Stemmer stemmer;

	public static Preprocessor getInstance() {
		if (instance == null) {
			instance = new Preprocessor();
		}

		return instance;
	}

	private Preprocessor() {
		tokenizer = new AdvancedTokenizer();
		stemmer = new PorterStemmer();
	}

	/**
	 * Processes given text. Whether stopwords, stemming, ... is applied is decided in called methods.
	 * @param text texted to be processed
	 * @return tokens (String array), which can but don't have to be processed
	 */
	public String[] processText(String text) {
		var tokens = tokenizer.tokenize(text);
		return stemTokens(tokens);
	}

	/**
	 * Apply stemming to tokens if IndexSetting.APPLY_STEMMING is true.
	 * @param tokens tokens to be stemmed
	 * @return stemmed tokens
	 */
	public String[] stemTokens(String[] tokens) {
		if (IndexSetting.APPLY_STEMMING) {
			// using index to ensure the old array element is actually replaced
			for (int i = 0; i < tokens.length; i++) {
				tokens[i] = stemmer.stem(tokens[i]);
			}
		}

		return tokens;
	}

	/**
	 * Stems only the tokens that are NOT in the exceptions list.
	 * @param tokens array of String to be stemmed
	 * @param exceptions List of String that are to be excepted from stemming
	 * @return String array = stemmed tokens (if IndexSetting.APPLY_STEMMING is true)
	 */
	public String[] stemTokensWithExceptions(String[] tokens, List<String> exceptions) {
		if (IndexSetting.APPLY_STEMMING) {
			// using index to ensure the old array element is actually replaced
			for (int i = 0; i < tokens.length; i++) {
				String token = tokens[i];
				// only stem when the token isn't an exception
				if (exceptions.stream().noneMatch(t -> t.equals(token))) {
					tokens[i] = stemmer.stem(token);
				}
			}
		}

		return tokens;
	}

	/**
	 * Stem a single token if IndexSetting.APPLY_STEMMING is true
	 * @param token String
	 * @return String (stemmed token)
	 */
	public String stemToken(String token) {
		if (IndexSetting.APPLY_STEMMING) {
			return stemmer.stem(token);
		}

		return token;
	}
}
