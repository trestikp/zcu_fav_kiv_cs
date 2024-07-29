/* OOperation.java - trida popisujici operace
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

/** Trida OOPeration nabizi konstanty operaci provadenych virtualnim
  * procesorem PL/0 
  */
public class OOperation {     /*JV: operatory precislovany*/

	protected static final int NEG = 1;
	protected static final int ADD = 2;
	protected static final int SUB = 3;
	protected static final int MUL = 4;
	protected static final int DI = 5;
	protected static final int MOD = 6;
	protected static final int ODD = 7;
	protected static final int EQ = 8;
	protected static final int NE = 9;
	protected static final int LT = 10;
	protected static final int GE = 11;
	protected static final int GT = 12;
	protected static final int LE = 13;

	/*
	  neg  :negace hodnoty na vrcholu zasobniku
	  add  :soucet dvou hodnot na vrcholu zasobniku
	  sub  :rozdil dvou hodnot na vrcholu zasobniku
	  mul  :soucin dvou hodnot na vrcholu zasobniku
	  di   :deleni dvou hodnot na vrcholu zasobniku
	  mod  :modulo dvou hodnot na vrcholu zasobniku
	  odd  :test lichosti hodnot na vrcholu zasobniku
	  eq   :test rovnost dvou hodnot na vrcholu zasobniku
	  ne   :test nerovnost dvou hodnot na vrcholu zasobniku
	  lt   :mensi
	  ge   :vetsi nebo rovno
	  gt   :vetsi
	  le   :mensi nebo rovno
	*/

}
