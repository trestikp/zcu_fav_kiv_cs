/* ErrorsException.java - vyjimka generovana kompilatorem
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Tato trida je pouzivana jako vyjimka, jez se generuje pri 
  * prekroceni maximalniho poctu chyb v programu.
  */
public class ErrorsException extends RuntimeException {

	protected ErrorsException() {
		super("Prilis mnoho chyb v programu");
	}

}
