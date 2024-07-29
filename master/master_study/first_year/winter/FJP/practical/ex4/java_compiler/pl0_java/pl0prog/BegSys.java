/* BegSys.java - pomocna trida pro praci s mnozinami.
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;
  
/** Trida Begsys obsahuje preddefinovane sablony mnozin
  * pouzivane prekladacem jazyka PL/0.
  */
public class BegSys {

	/** Mnozina symbolu pro prikaz (statement)
	  */
	protected static final SetSym statBegSys = new SetSym();
	/** Mnozina symbolu pro deklaraci
	  */
	protected static final SetSym declBegSys = new SetSym();
	/** Mnozina symbolu pro faktor
	  */
	protected static final SetSym facBegSys = new SetSym();

	static {
		statBegSys.set(SetSym.BEGINSYM);
		statBegSys.set(SetSym.CALLSYM);
		statBegSys.set(SetSym.IFSYM);
		statBegSys.set(SetSym.WHILESYM);
		declBegSys.set(SetSym.CONSTSYM);
		declBegSys.set(SetSym.VARSYM);
		declBegSys.set(SetSym.PROCSYM);
		facBegSys.set(SetSym.IDENT);
		facBegSys.set(SetSym.NUMBER);
		facBegSys.set(SetSym.LPAREN);
	}

}
