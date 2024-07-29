/* PL0Compiler.java - kompilator jazyka PL/0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

import java.io.*;

public class PL0Compiler {

	/** Pouzivana lexikalni analyzator
	  */
	private LexicalA lexicalA;
	/** Pouzivana tabulka symbolu
	  */
	private SymbolT symbol = new SymbolT();
	/** Pouzivana tabulka instrukci
	  */
	private CodeGen code = new CodeGen();
	/** Spravce chyb
	  */
	private BugBox bug = new BugBox();

	/** Ziskani tabulky symbolu.
	  * @return  vraci tabulku symbolu.
	  */
	public SymbolT getSymbolTable() {
		return symbol;
	};

	/** Ziskani tabulky instrukci.
	  * @return  vraci tabulku instrukci.
	  */
	public CodeGen getCode() {
		return code;
	};

	/** Ziskani spravce chyb.
	  * @return  vraci referenci na spravce chyb.
	  */
	public BugBox getBugBox() {
		return bug;
	};

	/** Metoda spravujici vyskytnutvsise chybu.
	  * @param errorType  kod chyby.
	  */
	protected void error(int errorType) {
		lexicalA.writeError(errorType);
		bug.error(errorType);
	}

	/** Kompilace zdrojoveho textu v jazyce PL/0. Generuje vyjimku IOException
	  * a muze generovat RunTime vyjimku ErrorsException 
	  * @param path  cesta ke zdrojovemu souboru.
	  */
	public void compile(String path) throws IOException {
		lexicalA = new LexicalA(path);  // otevre soubor a nacte prvni symbol
		SetSym pom = new SetSym();
		pom = pom.or(BegSys.declBegSys);
		pom = pom.or(BegSys.statBegSys);
		pom.set(SetSym.PERIOD);
		Block block = new Block(0, 0, pom);
		block.setBugBox(bug);
		block.run(lexicalA, symbol, code);
		if (lexicalA.getCurrentSymbol() != SetSym.PERIOD)
			error(BugBox.DOT_REQ);
	}

}
