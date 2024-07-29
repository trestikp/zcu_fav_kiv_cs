/* Variable.java - reprezentace promenne jazyka PL/0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Trida reprezentujici promennou
  */
public class Variable extends Locatable {

	/** Konstruktor  promenne.
	  * @param name  identifikator promenne,
	  * @param adrr  adresa
	  * @param lev   uroven zanoreni promenne.
	  */
	protected Variable(String name, int addr, int lev) {
		this.name = name;
		this.address = addr;
		this.level = lev;
	}

	/** Metoda vracejici charakteristicky retezec popisujici 
	  * tridu Variable.
	  * @return  informacni retezec.
	  */	
	public String toString() {
		return new String("Variable Name = " + name +
		                  ", Level = " + level +
		                  ", Address = " + address);
	}

}
