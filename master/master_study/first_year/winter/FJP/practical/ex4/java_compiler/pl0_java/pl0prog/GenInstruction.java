/* GenInstruction.java - zakladni jednotka tabulky instrukci CodeGen.
 * 
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001  
 */

package pl0prog;

/** Trida jednotky tabulky instrukci
  */
public class GenInstruction {

	/** Kod funkce
	  */
	int functionCode;
	/** Uroven
	  */
	int level;
	/** cast adresy nebo kod operace
	  */
	int operand;

	/** Konstruktor - vytvari novou instrukci.
	  * @param f  kod funkce,
	  * @param l  uroven zanoreni,
	  * @param a  adresa nebo kod operace.
	  */
	protected GenInstruction(int f, int l, int a) {
		functionCode = f;
		level = l;
		operand = a;
	}

}
