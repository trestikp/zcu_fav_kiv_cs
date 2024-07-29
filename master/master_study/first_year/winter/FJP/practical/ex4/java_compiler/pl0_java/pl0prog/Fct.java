/* Fct.java - trida instrukci
 * 
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Trida poskytuje symbolicka jmena instrukci vygenerovanych
  * prekladacem a zpracovavanych interpretem */
public class Fct {

	protected static final int LIT = 0; 
	protected static final int OPR = 1; 
	protected static final int LOD = 2; 
	protected static final int STO = 3;
	protected static final int CAL = 4;
	protected static final int RET = 5;
	protected static final int ING = 6;  // nahrazuje INT
	protected static final int JMP = 7;
	protected static final int JPC = 8;

	/*
	  lit 0,A  :uloz konstantu A do zasobniku
	  opr 0,A  :proved instrukci A
	  lod L,A  :uloz promenne L, A na vrchol zasobniku
	  sto L,A  :zapis promennou L z vrcholu zasobniku do pameti
	  cal L,A  :volej proceduru A z urovne L
	  int 0,A  :zvys obsah T-registru o hodnotu A	
	  jmp 0,A  :proved skok na adresu A
	  jpc 0,A  :proved podmineny skok na adresu A
	*/

}
