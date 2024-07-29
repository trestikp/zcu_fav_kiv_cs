/* pl0.java - program demonstrujici prekladac a interpret jazyka pl/0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */
 
import pl0prog.*;

import java.util.*;
import java.io.*;

public class PL0 {

	/** maximalni pocet znaku v zadavane ceste
	  */
	private static final int BUFFER_SIZE = 50;

	public static void main(String argv[]) {
		byte[] buffer = new byte[BUFFER_SIZE];
		String fileName;

		if (argv.length > 0) {
			fileName = argv[0];
		} else {
			try {
				System.out.print("Prekladac a interpret jazyka PL/0\n\n");
				System.out.print("Zadejte jmeno souboru: ");
				System.in.read(buffer);
				fileName = new String(buffer).trim();
			} catch (IOException e){
				System.out.println("Chyba pri nacitani jmena souboru!");
				e.printStackTrace();
				return;
			}
		}

		try { 
			PL0Compiler comp = new PL0Compiler();
			comp.compile(fileName);
			if (comp.getBugBox().getErrorsCount() == 0) {
				PL0Interpret interpret =
				  new PL0Interpret(comp.getSymbolTable(), comp.getCode());
				interpret.run();
			}
			System.out.println("Pocet chyb v programu: " +
			  comp.getBugBox().getErrorsCount());
		} catch (IOException e) {
			System.out.println("Chyba pri praci se soubory!");
			e.printStackTrace();
		} catch (ErrorsException e) {
			System.out.println("Prilis mnoho chyb v programu!");
			e.printStackTrace();
		}
	}

}
