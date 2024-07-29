/* LexicalA.java - lexikalni analyzator
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

import java.util.*;
import java.io.*;

/** Trida LexicalA provadi lexikalni analyzu predlozeneho souboru spolu se
  * zajistenim I/O operacich.
  */
public class LexicalA {

	/** Naposledy nacteny symbol
	  */
	private int currentSymbol;
	/** Naposledy nactene cislo
	  */
	private int currentNumber;
	/** Indikace prilis velkeho posledniho nacteneho cisla               // HL
	  */                                                                 // HL
	private boolean lastNumberTooBig;                                    // HL
	/** Pouzity spravce souboru
	  */
	private SourceReader source;
	/** Naposledy nacteny identifikator
	  */
	private StringBuffer currentIdentifier = new StringBuffer();
	/** Naposledy nacteny znak
	  */
	private char currentChar = ' ';
	/** Hashtabulka pro jednomistne symbolu
	  */
	private Hashtable singleSymbols = new Hashtable();
	/** Hashtabulka pro vicemistne symboly
	  */
	private Hashtable keyWords = new Hashtable();

	/** Ziskani nacteneho symbolu.
	  * @return  nacteny symbol
	  */
	protected int getCurrentSymbol() {
		return currentSymbol;
	};

	/** Ziskani nacteneho cisla.
	  * @return  nacteny cisla
	  */
	protected int getCurrentNumber() {
		return currentNumber;
	};

	/** Zjisteni, zda bylo posledni cislo prilis velke.                  // HL
	  * @return  indikace prilisne velikosti predchoziho cisla           // HL
	  */                                                                 // HL
	protected boolean isLastNumberTooBig() {                             // HL
		return lastNumberTooBig;                                         // HL
	};                                                                   // HL

	/** Ziskani nacteneho znaku.
	  * @return  nacteny znak.
	  */
	protected char getCurrentChar() {
		return currentChar;
	};	

	/** Ziskani nacteneho identifikatoru.
	  * @return  nacteny identifikator
	  */
	protected String getCurrentIdentifier() {
		return currentIdentifier.toString();
	};

	/** Zobrazi cislo a popis chyby na miste v radku,
	  * kde se tato chyba vyskytla 
	  * @param errorType  cislo chyby.
	  */
	protected void writeError(int errorType) {
		for (int i = 0; i < source.currentIndex-2; i++)
			System.out.print(" ");
		System.out.println("^ " + errorType + " - " +
		                   BugBox.getErrorText(errorType));
	}

	/* Konstruktor lexikalniho analyzatoru, zpusobuje IOException.
	 * @param path  jmeno souboru se zdrojovym textem programu.
	 */
	protected LexicalA(String path) throws IOException {
		source = new SourceReader(path);

		singleSymbols.put(new Character('+'), new Integer(SetSym.PLUS));
		singleSymbols.put(new Character('-'), new Integer(SetSym.MINUS));
		singleSymbols.put(new Character('*'), new Integer(SetSym.TIMES));
		singleSymbols.put(new Character('/'), new Integer(SetSym.SLASH));
		singleSymbols.put(new Character('%'), new Integer(SetSym.MODULO));
		singleSymbols.put(new Character('('), new Integer(SetSym.LPAREN));
		singleSymbols.put(new Character(')'), new Integer(SetSym.RPAREN));
		singleSymbols.put(new Character('='), new Integer(SetSym.EQL));
		singleSymbols.put(new Character(','), new Integer(SetSym.COMMA));
		singleSymbols.put(new Character('.'), new Integer(SetSym.PERIOD));
		singleSymbols.put(new Character('#'), new Integer(SetSym.NEQ));
		singleSymbols.put(new Character('<'), new Integer(SetSym.LSS));
		singleSymbols.put(new Character('>'), new Integer(SetSym.GTR));
		singleSymbols.put(new Character(';'), new Integer(SetSym.SEMICOLON));

		keyWords.put(new String("begin"), new Integer(SetSym.BEGINSYM));
		keyWords.put(new String("call"), new Integer(SetSym.CALLSYM));
		keyWords.put(new String("const"), new Integer(SetSym.CONSTSYM));
		keyWords.put(new String("do"), new Integer(SetSym.DOSYM));
		keyWords.put(new String("end"), new Integer(SetSym.ENDSYM));
		keyWords.put(new String("if"), new Integer(SetSym.IFSYM));
		keyWords.put(new String("odd"), new Integer(SetSym.ODDSYM));
		keyWords.put(new String("procedure"), new Integer(SetSym.PROCSYM));
		keyWords.put(new String("then"), new Integer(SetSym.THENSYM));
		keyWords.put(new String("var"), new Integer(SetSym.VARSYM));
		keyWords.put(new String("while"), new Integer(SetSym.WHILESYM));

		getNextSymbol();  // automaticke nacteni prvniho znaku
	}

	/** Vynulovani naposledy nacteneho cisla - pouziva se pri prekroceni
	  * povoleneho rozsahu cisel.
	  */
	protected void zeroNumber() {
		currentNumber = 0;
	}

	/** Provede nacteni dalsiho symbolu (ten je mozne ziskat pomoci metody 
	  * getCurrentSymbol() */
	protected void getNextSymbol() {
		while (currentChar <= ' ')
			currentChar = source.getChar(); /* Nacteni jednoho znaku */
		// nacteni identifikatoru do currentIdentifier
		if (Character.isLetter(currentChar)) {
			/* identifier or reserved word */
			currentIdentifier = new StringBuffer();
			do {
				currentIdentifier.append(new Character(currentChar));
				currentChar = source.getChar();  /* Nacteni jednoho znaku */
			} while (Character.isLetterOrDigit(currentChar));
			if (keyWords.containsKey(currentIdentifier.toString()) == true) {
				currentSymbol = ( (Integer) keyWords.get(
				                    currentIdentifier.toString()
				                  ) ).intValue();
			} else {
				currentSymbol = SetSym.IDENT;
			}
		} else if (Character.isDigit(currentChar)) {
			/* number */
			currentSymbol = SetSym.NUMBER;
			currentNumber = 0;
			long cislo = 0;                                              // HL
			  /* cislo je pomocna promenna pro kontrolu, zda nebylo      // HL
			     zadano prilis velke cislo */                            // HL
			lastNumberTooBig = false;                                    // HL
			do {  /* get value */
				cislo = (10*cislo) + (currentChar-'0');
				currentChar = source.getChar();
				/* Kontrola velikosti zadaneho cisla */                  // HL
				if ( (cislo > Integer.MAX_VALUE) ||                      // HL
				     (cislo < Integer.MIN_VALUE) )                       // HL
					lastNumberTooBig = true;                             // HL
			} while (Character.isDigit(currentChar));
			if (!lastNumberTooBig)                                       // HL
				currentNumber = (int) cislo;                             // HL
		} else if (currentChar == ':') {
			/* muze jit o prirazeni */
			currentChar = source.getChar();
			if (currentChar == '=') {
				currentSymbol = SetSym.BECOMES;
				currentChar = source.getChar();
			} else {
				currentSymbol = SetSym.NULL;
			}
		} else if (currentChar == '<') {
			currentChar = source.getChar();
			if (currentChar == '=') {
				currentSymbol = SetSym.LEQ;  /* mensi nebo rovno */
				currentChar = source.getChar();
			} else {
				currentSymbol = SetSym.LSS;  /* mensi nez */
			}
		} else if (currentChar == '>') {
			currentChar = source.getChar();
			if (currentChar == '=') {
				currentSymbol = SetSym.GEQ;  /* vetsi nebo rovno */
				currentChar = source.getChar();
			} else {
				currentSymbol=SetSym.GTR;  /* vetsi nez */
			}
		} else {
			if (singleSymbols.containsKey(new Character(currentChar))) {
				currentSymbol = ( (Integer) singleSymbols.get(
				                    new Character(currentChar)
				                  ) ).intValue();
				currentChar = source.getChar();	
			} else {
				currentSymbol = SetSym.NULL;
				currentChar = source.getChar();
			}
		}
	}

	/** Podtrida zajistujici praci se souborem 
	  */
	private class SourceReader {

		private FileReader fileReader;
		private BufferedReader file;
		/* Aktualni radka programu */
		private String currentLine = "";
		/* Aktualni offset vzhledem k zacatku radky */
		private int currentIndex = 0;

		/** Zavedeni nove instance tridy SourceReader; zpusobuje vyjimku
		  * IOException.
		  * @param fileName  jmeno souboru se zdrojovym textem
		  */
		private SourceReader(String fileName) throws IOException {
			try {
				fileReader = new FileReader(fileName);
				file = new BufferedReader(fileReader);
			} catch (FileNotFoundException e) {
				System.out.println("Soubor " + fileName + " nenalezen.");
				throw e;
			}
		}

		/** Ziskani dalsiho znaku ze souboru 
		  * @return  vraceny znak.
		  */
		private char getChar() {
			if (currentIndex == currentLine.length()) {
				try {
					if ((currentLine = file.readLine()) == null) {
						System.out.println("Program neni kompletni nebo " +
						                   "chybi tecka za koncovym end.");
						throw new ErrorsException();
					} else {
						currentLine = new String(currentLine + " ");
						currentIndex = 0;
						System.out.println(currentLine);
						return currentLine.charAt(currentIndex++);
					}
				} catch (IOException e) {
					System.out.println("Chyba pri cteni ze souboru.");
					e.printStackTrace();
					return 0;
				}
			} else {
				return currentLine.charAt(currentIndex++);
			}
		}

		/* Destruktor tridy */
		protected void finalize() throws Throwable {
			if (fileReader != null)
				fileReader.close();
			super.finalize();
		}
	}  // end of SourceReader

} // end of LexicalA
