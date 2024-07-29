/* SymbolT.java - zapouzdruje tabulku symbolu.
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

import java.io.*;

/** Trida SymbolT implementuje tabulku symbolu pouzivanou prekladacem
  * a interpretem jazyka PL/0.
  */
public class SymbolT{

	/** Maximalni pocet identifikatoru v tabulce
	  */
	private final int TX_MAX = 5000; 
	/* Nasledujici radky rusim, protoze konstanta neni nikde vyuzivana   // HL
	   podle uvedeneho komentare */                                      // HL
	// /** Nejvyssi mozna adesa                                          // HL
	//   */                                                              // HL
	/* private final int A_MAX = 2048; */                                // HL
	/** Tabulka identifikatoru
	  */
	private Identifier[] table = new Identifier[TX_MAX];
	/** Index ukazujici na nasleduji volny prvek
	  */
	private int tableIndex = 0;

	/* Nasledujici funkce musi byt uplne prepsana a doplnena o jeden     // HL
	   parametr, aby se symboly vyhledavaly jen ve "z daneho mista       // HL
	   vidilene" casti (a ne v cele tabulce symbolu) */                  // HL
	// /** Vyhleda symbol v tabulce symbolu                              // HL
	//   * @param id  jmeno symbolu,                                     // HL
	//   * @return  -1: symbol nenalezen, >=0 : adresa symbolu.          // HL
	//   */                                                              // HL
	/* protected int position(String id) {                               // HL
		int i;                                                           // HL
		table[0].name = new String(id);                                  // HL
		i = tableIndex;                                                  // HL
		while (table[i].name.compareTo(id) != 0)                         // HL
			i--;                                                         // HL
		return i;                                                        // HL
	} */                                                                 // HL
	/* Nasledujici radky se samodokumentujicim komentarem nejsou         // HL
	   okomentovany na konci radku, aby nebyl komentar narusen */        // HL
	/** Vyhleda symbol v tabulce symbolu
	  * @param id     jmeno symbolu,
	  * @param level  aktualni uroven zanoreni,
	  * @return  0: symbol nenalezen, >0 : adresa symbolu.
	  */                                                                 // HL
	protected int position(String id, int level) {                       // HL
		/* Prochazeni tabulky symbolu od konce */                        // HL
		for (int i = tableIndex; i > 0; i--) {                           // HL
			/* Kontrola urovne zanoreni */                               // HL
			if (table[i].level > level)                                  // HL
				continue;  // To je moc vnorene, to nevidime             // HL
			if (table[i].level < level)                                  // HL
				level = table[i].level;  // Vynorujeme se                // HL
			/* Porovnani symbolu */                                      // HL
			if (table[i].name.compareTo(id) == 0)                        // HL
				return (i);  // Nalezeno                                 // HL
		}                                                                // HL
		return (0);                                                      // HL
	}                                                                    // HL

	/** Vlozeni konstanty do tabulky symbolu.
	  * @param identifier  identifikator konstanty,
	  * @param level       uroven zanoreni,
	  * @param value       hodnota konstanty,
	  */
	/* Nasledujici funkce doplenena o parametr level */                  // HL
	protected void enterConstant(String identifier, int level,           // HL
	                             int value) {                            // HL
	    /* Doplnena kontrola preteceni tabulky symbolu */                // HL
		if (tableIndex >= (TX_MAX-1)) {                                  // HL
			System.out.println("Pocet symbolu je prilis velky!");        // HL
			System.exit(1);                                              // HL
		}                                                                // HL
		tableIndex++;
		table[tableIndex] = new Constant(identifier, level, value);      // HL
	}

	/** Vlozeni promenne do tabulky symbolu.
	  * @param identifier  identifikator promenne,
	  * @param address     adresa,
	  * @param level       uroven zanoreni promenne.
	  */
	protected void enterVariable(String identifier, int address, int level) {
	    /* Doplnena kontrola preteceni tabulky symbolu */                // HL
		if (tableIndex >= (TX_MAX-1)) {                                  // HL
			System.out.println("Pocet symbolu je prilis velky!");        // HL
			System.exit(1);                                              // HL
		}                                                                // HL
		tableIndex++;
		table[tableIndex] = new Variable(identifier, address, level);
	}

	/** Vlozeni procedury do tabulky symbolu 
	  * @param identifier  identifikator procedury,
	  * @param level       uroven zanoreni procedury,
	  */
	protected void enterProcedure(String identifier, int level) {
	    /* Doplnena kontrola preteceni tabulky symbolu */                // HL
		if (tableIndex >= (TX_MAX-1)) {                                  // HL
			System.out.println("Pocet symbolu je prilis velky!");        // HL
			System.exit(1);                                              // HL
		}                                                                // HL
		tableIndex++;
		table[tableIndex] = new Procedure(identifier, level);
	}

	/** Nastaveni adresy symbolu.
	  * @param tx  offset symbolu v tabulce,
	  * @param cx  nova hodnota adresy.
	  */
	protected void setAddr(int tx, int cx) {
		if (table[tx] == null) {
			table[tx] = new Variable("", cx, 0);
		} else if (table[tx] instanceof Locatable) {
			((Locatable) table[tx]).setAddress(cx);
		}
	}

	/** Ziskani prislusneho identifikatoru z tabulky identifikatoru 
 	  * @param i  offset symbolu.
	  * @return  vraceny symbol.
	  */
	protected Identifier getIdentifier(int i) {
		return table[i];
	}

	/** Vraci index mista, kde je ulozen posledni vlozeny identifikator.
	  * @return  index posledniho identifikatoru.
	  */
	protected int getTableIndex() {
		return tableIndex;
	}

	/** Metoda pro vypis kon. tvaru tabulky symbolu do souboru; generuje 
	  * vyjimku IOException.
	  * @param path  soubor, kam ma byt vypis tabulky symbolu ulozen.
	  */
	public void list(String path) throws IOException {
		try {
			FileWriter file = new FileWriter(path);
			BufferedWriter out = new BufferedWriter(file);
			out.write("\n\nTabulka symbolu:\n");
			out.write("***************\n");
			for (int i = 1; i <= tableIndex; i++) {
				out.write(i + " ");
				out.write(table[i].toString());
				out.newLine();
			}
			out.close();
		} catch (IOException e) {
			System.out.println("File " + path + " couldn't be created.");
			throw e;
		}
	}

}
