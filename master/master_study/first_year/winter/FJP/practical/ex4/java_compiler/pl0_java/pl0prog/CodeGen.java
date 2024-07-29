/* CodeGen.java - generator kodu jazyka PL/0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

import java.io.*;
import java.text.*;

/** Trida CodeGen ma funkci tabulky generovaneho kodu (tabulky instrukci). 
  */
public class CodeGen {

	/** Maximalni pocet instukci v programu.
	  */
	private final int MAX_INSTRUCTION = 1000;
	/** Jmena instrukci
	  */
	private final String[] MNEMONIC = {"LIT  ","OPR  ","LOD  ","STO  ","CAL  ",
	                                   "RET  ","INT  ","JMP  ","JMC  "};

	/** Vlastni tabulka instrukci
	  */
	private GenInstruction[] genCode = new GenInstruction[MAX_INSTRUCTION];
	/** Citac adres
	  */
	private int addressCounter = 0;

	/* Nastaveni adresy/operandu 
	 * @param where  poradovy index instukce,
	 * @param what   nova hodnota adresy/operandu.
	 */
	protected void setAddressAt(int where, int what) {
		genCode[where].operand = what;
	}

	/* Ziskani adresy/operandu 
	 * @param where  poradovy index instukce,
	 * @return  pozadovana adresa/operand
	 */
	protected int getAdress(int where) {
		if (genCode[where] != null) {
			return genCode[where].operand;
		} else {
			return 0;
		}
	}

	protected int getAddressCounter() {
		return addressCounter;
	}

	/**Generovani instrukci do pole generovanych kodu
	  * @param x  kod funkce,
	  * @param y  uroven instrukce,
	  * @param z  adresni cast v instrukci.
	  */
	public void gen(int x, int y, int z) {
		if (addressCounter >= MAX_INSTRUCTION) {
			System.out.println("Program je prilis dlouhy!");
			System.exit(1);
		}
		genCode[addressCounter++] = new GenInstruction(x, y, z); 
	}

	/** Pomocna fce pro vypis generovaneho kodu.
	  * @param path  jmeno (cesta) souboru, kam se ma vysledny kod ulozit.
	  */
	protected void list(String path) {
		FileWriter file;
		BufferedWriter out;
		try {
			file = new FileWriter(path);
			out = new BufferedWriter(file);
			out.write("\nGenerovany kod:\n");
			out.write("**************\n");
			for (int i = 0; i <= (addressCounter-1); i++) {
				Object[] arguments= { new Integer(i),
				                      MNEMONIC[genCode[i].functionCode],
				                      new Integer(genCode[i].level),
				                      new Integer(genCode[i].operand) };
				// objekty pro formatovani vystupniho retezce
				String text = MessageFormat.format("{0, number, integer} " +
				                                   "{1} " +
				                                   "{2, number, integer}, " +
				                                   "{3, number, integer}",
				                                   arguments);
				out.write(text);
				out.newLine();
			}
			out.close();
		}
		catch (IOException e) {
			System.out.println("Chyba pri zapisovani do souboru" + path);
			e.printStackTrace();
		}
	}

	/** Vypis specifickych casti generovanych kodu prelozeneho bloku.
	  * @param from  pocatecni index
	  * @param to    konecny index
	  */
	protected void listCode(int from, int to) {
		for (int i = from; i <= (addressCounter-1); i++) {
			Object[] arguments= { new Integer(i),
			                      MNEMONIC[genCode[i].functionCode],
			                      new Integer(genCode[i].level),
			                      new Integer(genCode[i].operand) };
			// objekty pro formatovani vystupniho retezce
			String text = MessageFormat.format("{0, number, integer} " +
			                                   "{1} " +
			                                   "{2, number, integer}, " +
			                                   "{3, number, integer}",
			                                   arguments);
			System.out.println(text);
		}
	}

	/** Ziskani instrukce z tabulky instukci.
	  * @param i  index instrukce
	  * @return  pozadovana instrukce
	  */
	protected GenInstruction getInstruction(int i) {
		return genCode[i];
	}

}
