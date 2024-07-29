/* BugBox.java - trida zapouzdrujici spravce chyb jazyka PL0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Trida BugBox je pouzivana je pouzivana spravu chyb prekladace
  * jazyka PL0. V teto verzi zatim neobsahuje metody pro registraci
  * chyb. */
public class BugBox {

	/** Pocet chyb v programu 
	  */
	private int errors = 0;
	/** Maximalni pocet chyb v programu - pri prekroceni se generuje
	  * vyjimka ErrorsException */	 
	private int maxErrors = 30;

	protected static final int BAD_BECOMES = 1;
	protected static final int NUM_REQ = 2;
	protected static final int EQUALS_REQ = 3;
	protected static final int ID_REQ = 4;
	protected static final int SEMI_COMO_REQ = 5;
	protected static final int BAD_PAST_PROC = 6;
	protected static final int STATEMENT_REQ = 7;
	protected static final int BAD_PAST_STATEMENT = 8;
	protected static final int DOT_REQ = 9;
	protected static final int BAD_SYMB = 10;
	protected static final int UNDECLARED_ID = 11;
	protected static final int WRONG_BECOMES = 12;
	protected static final int BECOMES = 13;
	protected static final int ID_PAS_CALL = 14;
	protected static final int INVALID_CALL = 15;
	protected static final int THEN_REQ = 16;
	protected static final int END_BLOCK_REQ = 17;
	protected static final int DO_REQ = 18;
	protected static final int INVALID_SYMB = 19;
	protected static final int RELATION_REQ = 20;
	protected static final int INVALID_PROC_USE = 21;
	protected static final int RPARENT_REQ = 22;
	protected static final int INVALID_FACTOR_END = 23;
	protected static final int INVALID_EXPRESS_BEG = 24;
	protected static final int TOO_BIG_NUMBER = 30;
	protected static final int TOO_BIG_LEVEL = 32;

	protected void error(int errorCode) {
		errors++;
		if (errors > maxErrors)
			throw new ErrorsException();
	}

	/** Vraci pocet celkovy pocet chyb v programu.
	  * @return  celkovy pocet chyb v programu
	  */
	public int getErrorsCount() {
		return errors;
	}

	/** Nastaveni maximalniho poctu chyb v programu. Pokud je pocet chyb
	  * v programu vetsi nez nastavovane mnozstvi, generuje se vyjimka
	  * ErrorsException.
	  * @param max  maximalne akceptovatelny pocet chyb v programu.
	  */
	public void setMaxErrors(int max) {
		maxErrors = max;
		if (errors > maxErrors)
			throw new ErrorsException();
	}

	/** Ziskani maximalniho poctu chyb v programu
	  * @return  Vraci nastaveni maximalniho poctu chyb v programu 
	  */
	public int getMaxErrors() {
		return maxErrors;
	}

	/** Chybovy text odpovidajici kodu chyby
	  * @param errorCode  cislo chyby,
	  * @return  Popis chyby.
	  */
	public static String getErrorText(int errorCode) {
		switch (errorCode) {
		case BAD_BECOMES:
			return("Pouzito \"=\" misto \":=\"");
		case NUM_REQ:
			return ("Za \"=\" musi nasledovat cislo");
		case EQUALS_REQ:
			return("Za identifikatorem ma nasledovat \"=\"");
		case ID_REQ:
			return("Za \"const\", \"var\", \"procedure\" " +
			       "musi nasledovat identifikator");
		case SEMI_COMO_REQ:
			return ("Chybi strednik nebo carka");
		case BAD_PAST_PROC:
			return("Nespravny symbol po deklaraci procedury");
		case STATEMENT_REQ:
			return("Je ocekavan prikaz");
		case BAD_PAST_STATEMENT:
			return("Neocekavany symbol za prikazovou casti bloku");
		case DOT_REQ:
			return("Ocekavam tecku");
		case BAD_SYMB:
			return("Nespravny symbol v prikazu");
		case UNDECLARED_ID:
			return("Nedeklarovany identifikator");
		case WRONG_BECOMES:
			return("Prirazeni konstante a procedure neni dovoleno");
		case BECOMES:
			return("Operator prirazeni je \":=\"");
		case ID_PAS_CALL:
			return("Za \"call\" musi nasledovat identifikator");
		case INVALID_CALL:
			return("Volani konstanty nebo promenne neni dovoleno");
		case THEN_REQ:
			return("Ocekavano \"then\"");
		case END_BLOCK_REQ:
			return("Ocekavano \"end\" nebo \";\"");
		case DO_REQ:
			return("Ocekavano \"do\"");
		case INVALID_SYMB:
			return("Nespravne pouzity symbol za prikazem");
		case RELATION_REQ:
			return("Ocekavam relaci");
		case INVALID_PROC_USE:
			return("Jmeno procedury nelze pouzit ve vyrazu");
		case RPARENT_REQ:
			return("Chybi uzaviraci zavorka");
		case INVALID_FACTOR_END:
			return("Faktor nesmi koncit timto symbolem");
		case INVALID_EXPRESS_BEG:
			return("Vyraz nesmi zacinat timto symbolem");
		case TOO_BIG_NUMBER:
			return("Prilis velke cislo");
		case TOO_BIG_LEVEL:
			return("Prilis velke zanoreni");
		}
		return ("Neznama chyba");
	}

}
