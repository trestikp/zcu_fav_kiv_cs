/* Identifier.java - abstraktni trida slouzici ke sprave identifikatoru.
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Rodicovska abstraktni trida pro vsechny identifikatory 
  */
public abstract class Identifier {

	/** Retezec identifikatoru
	  */
	protected String name;
	/* Nasledujici atribut je presunut z potomka Locatable */            // HL
	/** Uroven zanoreni                                                  // HL
	  */                                                                 // HL
	protected int level;                                                 // HL

	/* Nasledujici dve metody jsou presunuty z potomka Locatable */      // HL
	/** Vraci aktualni uroven zanoreni,                                  // HL
	  * @return  vracena uroven zanoreni.                                // HL
	  */                                                                 // HL
	protected int getLevel() {                                           // HL
		return level;                                                    // HL
	};                                                                   // HL
	/** Nastav uroven zanoreni.                                          // HL
	  * @param l   vracena uroven zanoreni.                              // HL
	  */                                                                 // HL
	protected void setLevel(int l) {                                     // HL
		level = l;                                                       // HL
	};                                                                   // HL

}
