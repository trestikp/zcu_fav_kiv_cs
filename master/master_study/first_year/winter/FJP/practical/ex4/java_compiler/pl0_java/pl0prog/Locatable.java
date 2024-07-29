/* Locatable.java - popisuje adresovatelne objekty.
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog; 

/** Rodicovska abstraktni trida pro identifikatory,
  * jez jsou specifikovany adresou a urovni zanoreni
  */
public abstract class Locatable extends Identifier {

	/** Adresa
	  */
	protected int address;
	/* Nasledujici atribut je presunut do predka Identifier */           // HL
	// /** Uroven zanoreni                                               // HL
	//   */                                                              // HL
	/* protected int level; */                                           // HL

	/** Vraci aktualni adresu 
	  * @return  vracena adresa 
	  */
	protected int getAddress() {
		return address;
	};

	/** Nastav adresu.
	  * @param adr  pozadovana adresa,
	  */
	protected void setAddress(int adr) {
		address = adr;
	};

	/* Nasledujici dve metody jsou presunuty do predka Identifier */     // HL
	// /** Vraci aktualni uroven zanoreni,                               // HL
	//   * @return  vracena uroven zanoreni.                             // HL
	//   */                                                              // HL
	/* protected int getLevel() {                                        // HL
		return level;                                                    // HL
	}; */                                                                // HL
	// /** Nastav uroven zanoreni.                                       // HL
	//   * @param l   vracena uroven zanoreni.                           // HL
	//   */                                                              // HL
	/* protected void setLevel(int l) {                                  // HL
		level = l;                                                       // HL
	}; */                                                                // HL

}
