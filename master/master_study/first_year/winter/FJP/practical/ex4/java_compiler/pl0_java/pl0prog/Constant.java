/* Constant.java - trida reprezentujici konstantu pouzivana prekladacem
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001  
 */

package pl0prog;

public class Constant extends Identifier {

	/** Hodnota konstanty
	  */
	private int val; 

	/** Konstruktor konstanty,
	  * @param name   identifikator konstanty,
	  * @param value  hodnota konstanty.
	  */
	/* Kostruktor je doplnen o parametr level */                         // HL
	protected Constant(String name, int level, int value) {              // HL
		this.name = name;
		this.level = level;                                              // HL
		this.val = value;
	};

	/** Vraci hodnotu konstanty.
	  * @return  hodnota konstanty.
	  */
	protected int getValue() {
		return val;
	};

	/** Metoda vracejici charakteristicky retezec popisujici tridu Constant 
	  * @return  informacni retezec.
	  */
	public String toString() {
		/* Vypis doplnen o uroven zanoreni */                            // HL
		return new String("Constant Name = " + name + ", " +             // HL
		                  "Level = " + level + ", Value = " + val);      // HL
	}

}
