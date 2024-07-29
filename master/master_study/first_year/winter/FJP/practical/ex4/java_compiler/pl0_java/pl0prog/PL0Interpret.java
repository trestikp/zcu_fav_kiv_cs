/* PL0Interpret.java - interpretace generovanych kodu jazyka PL0
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */

package pl0prog;

import java.io.*;

public class PL0Interpret {

	/** Maximalni velikost zasobniku
	  */
	private static final int STACK_SIZE = 500;
	/** Pouzivana tabulka instrukci
	  */
	private CodeGen code;
	/** Pouzivana tabulka symbolu
	  */
	private SymbolT symbol;
	/** Zasobnik
	  */
	private int[] stack = new int[STACK_SIZE];
	/** Aktualni uroven zanoreni
	  */
	private int currentLevel;

	/** Vytvari novy interpret PL0.
	  * @param sym   vygenerovana tabulka symbolu
	  * @param code  vygenerovana tabulka instrukci
	  */
	public PL0Interpret(SymbolT sym, CodeGen code) {
		this.code = code;
		this.symbol = sym;
	}

	/** Metoda pro zjisteni pocatecni adresy na urovni, ktera je 
	  * o l vyssi nez soucasna uroven, ve ktere je prave vykonan program.
	  * @param l  rozdil pozadovane a aktualni urovne,
	  * @return  adresa pocatecni urovne.
	  */
	private int base(int l) {
		int baseLevel = currentLevel;
		while (l > 0) {
			baseLevel = stack[baseLevel];
			l--;
		}
		return baseLevel;
	}

	/** Metoda spusteni interpretu.
	  */
	public void run() {
		int p;  // Citac instrukci
		int t;  // Ukazatel na vrchol zasobniku
		GenInstruction i;

		System.out.println("START PL/0\n");
		t = p = stack[1] = stack[2] = stack[3] = 0;  currentLevel=1;
		do {
			i = code.getInstruction(p++);
			switch (i.functionCode) {
			case Fct.LIT:
				stack[++t] = i.operand;
				break;
			case Fct.OPR:
				switch (i.operand) {
				case OOperation.NEG:
					stack[t] =- stack[t];
					break;
				case OOperation.ADD:
					t--;
					stack[t] += stack[t+1];
					break;
				case OOperation.SUB:
					t--;
					stack[t] -= stack[t+1];
					break;
				case OOperation.MUL:
					t--;
					stack[t] *= stack[t+1];
					break;
				case OOperation.DI:
					t--;
					stack[t] /= stack[t+1];
					break;
				case OOperation.MOD:
					t--;
					stack[t] = stack[t] % stack[t+1];
					break;
				case OOperation.ODD:
					stack[t] = stack[t] % 2;
					break;
				case OOperation.EQ:
					t--;
					stack[t] = (stack[t] == stack[t+1]) ? 1 : 0;
					break;
				case OOperation.NE:
					t--;
					stack[t] = (stack[t] != stack[t+1]) ? 1 : 0;
					break;
				case OOperation.LT:
					t--;
					stack[t] = (stack[t] < stack[t+1]) ? 1 : 0;
					break;
				case OOperation.GE:
					t--;
					stack[t] = (stack[t] >= stack[t+1]) ? 1 : 0;
					break;
				case OOperation.GT:
					t--;
					stack[t] = (stack[t] > stack[t+1]) ? 1 : 0;
					break;
				case OOperation.LE:
					t--;
					stack[t] = (stack[t] <= stack[t+1]) ? 1 : 0;
					break;
				}
				break;
			case Fct.LOD:
				t++;
				stack[t] = stack[base(i.level)+i.operand];
				break;
			case Fct.STO:
				stack[base(i.level)+i.operand] = stack[t];
				System.out.println(stack[t--]);
				break;
			case Fct.CAL:
				stack[t+1] = base(i.level);
				stack[t+2] = currentLevel;
				stack[t+3] = p;
				currentLevel = t+1;
				p = i.operand;
				break;
			case Fct.RET:
				t = currentLevel-1;
				p = stack[t+3];
				currentLevel = stack[t+2];
				break;
			case Fct.ING:
				t += i.operand;
				break;
			case Fct.JMP:
				p = i.operand;
				break;
			case Fct.JPC:
				if (stack[t] == 0)
					p = i.operand;
				t--;
				break;
			}
			/* Nasledujici radek je zakomentovan, aby nebyla             // HL
			   vypisovana aktualni hodnota citace adres (to              // HL
			   vetsinou pouze mate uzivatele) */                         // HL
			/* System.out.println(p); */                                 // HL
		} while (p != 0);

		try {
			code.list("LIST.TAB");
			symbol.list("SYMBOL.TAB");
		} catch (IOException e) {
			System.out.println("Chyba pri zapisu do pomocnych souboru\n");
			e.printStackTrace();
		}
		System.out.println(" END PL/0\n");
	}

}
