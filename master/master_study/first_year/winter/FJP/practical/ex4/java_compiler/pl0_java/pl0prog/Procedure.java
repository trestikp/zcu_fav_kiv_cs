/* Procedure.java - reprezentace procedury jazyka PL/0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Trida reprezentujici proceduru
  */
public class Procedure extends Locatable {

	/** Konstruktor procedury.
	  * @param iden  identifikator procedury,
	  * @param lev   uroven zanoreni procedury.
	  */
	protected Procedure(final String iden, int lev) {
		name = iden;
		level = lev;
	}

	/** Metoda vracejici charakteristicky retezec popisujici tridu Procedure.
	  * @return  informacni retezec.
	  */
	public String toString() {
		return new String ("Procedure Name = " + name +
		                   ", Level = " + level +
		                   ", Address = " + address);
	}

}
