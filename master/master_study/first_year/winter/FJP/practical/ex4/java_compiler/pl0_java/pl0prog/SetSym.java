/* SetSym - mnozina symbolu.
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

import java.util.*;

/** Trida SetSym eviduje symboly pouzivane v jazyce PL/0 a umoznuje s 
  * nimi pracovat,
  */
public class SetSym {

	protected static final int NULL = 0;
	protected static final int IDENT = 1;
	protected static final int NUMBER = 2;
	protected static final int PLUS = 3;
	protected static final int MINUS = 4;
	protected static final int TIMES = 5;
	protected static final int SLASH = 6;
	protected static final int MODULO = 7;
	protected static final int ODDSYM = 8;
	protected static final int EQL = 9;
	protected static final int NEQ = 10;
	protected static final int LSS = 11;
	protected static final int LEQ = 12;
	protected static final int GTR = 13;
	protected static final int GEQ = 14;
	protected static final int LPAREN = 15;
	protected static final int RPAREN = 16;
	protected static final int COMMA = 17;
	protected static final int SEMICOLON = 18;
	protected static final int PERIOD = 19;
	protected static final int BECOMES = 20;
	protected static final int BEGINSYM = 21;
	protected static final int ENDSYM = 22;
	protected static final int IFSYM = 23;
	protected static final int THENSYM = 24;
	protected static final int WHILESYM = 25;
	protected static final int DOSYM = 26;
	protected static final int CALLSYM = 27;
	protected static final int CONSTSYM = 28;
	protected static final int VARSYM = 29;
	protected static final int PROCSYM = 30;
	protected static final int SYMBOLS = 31;

	/** Systemova mnozina symbolu
	  */
	private BitSet languageSet = new BitSet(SYMBOLS);

	/** Vloz symbol bit do mnoziny
	  * @param bit  vkladany symbol.
	  */
	protected void set(final int bit) {
		if ( (bit >= 0) && (bit <= SYMBOLS-1) )
			languageSet.set(bit);	
	}

	/** Vyjmi symbol bit z mnoziny
	  * @param bit  vyjimany symbol.
	  */
	protected void clear(final int bit) {
		if ( (bit >= 0) && (bit <= SYMBOLS-1) )
			languageSet.clear(bit);
	}

	/** Urci, zda se prislusny bit nachazi v mnozine
	  * @param bit  zkoumany bit,
	  * @return  vraci TRUE, pokud se bit nachazi v mnozine, jinak FALSE
	  */
	protected boolean get(final int bit) {
		if ( (bit >= 0) && (bit <= SYMBOLS-1) ) {
			return languageSet.get(bit);
		} else {
			return false;
		}
	}

	/** Vytvori novou mnozinu jako prunik teto mnoziny a mnoziny sset 
	  * @param sset  mnozina, jez je pouzivana pri konjunkci s danou mnozinou 
	  * @return  vraci nove vytvorenou mnozinu.
	  */
	protected SetSym and(final SetSym sset) {
		SetSym retvalue = new SetSym();
		retvalue.languageSet.or(languageSet);
		retvalue.languageSet.and(sset.languageSet);
		return retvalue;
	}

	/** Vytvori novou mnozinu jako sjednoceni teto mnoziny a mnoziny sset 
	  * @param sset  mnozina, jez je pouzivana pri disjunkci s danou mnozinou 
	  * @return  vraci nove vytvorenou mnozinu.
	  */
	protected SetSym or(final SetSym sset) {
		SetSym retvalue = new SetSym();
		retvalue.languageSet.or(languageSet);
		retvalue.languageSet.or(sset.languageSet);
		return retvalue;
	}

	/** Vyjmi vsechny prvky z mnoziny
	  */
	protected void zero() {
		languageSet = new BitSet(SYMBOLS);
	}

}
