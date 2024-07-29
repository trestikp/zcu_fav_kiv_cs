/* Block.java - trida zapouzdrujici kompilaci celeho bloku
 *
 * Michal Beran, berny@students.zcu.cz
 * 4.1.2001
 */
 
package pl0prog;

public class Block {

	/** Pouzivany lexikalni analyzator
	  */
	private static LexicalA lexicalA;
	/** Tabulka symbolu
	  */
	private static SymbolT symbol;
	/** Tabulka generovaneho kodu
	  */
	private static CodeGen code;
	/** Spravce chyb
	  */
	private static BugBox bug = new BugBox();

	/** Maximalni pocet urovni zanoreni
	  */
	private static final int LEVEL_MAX = 3;
	/* Nasledujici radky rusim, protoze konstanta neni nikde vyuzivana   // HL
	   podle uvedeneho komentare */                                      // HL
	// /** Nejvyssi adresa                                               // HL
	//   */                                                              // HL
	/* private static final int A_MAX = 2047; */                         // HL 
	/** Index pridelovani pameti pro udaje
	  */
	private int dataIndex = 3;  // ulozeno DU,AN, SU
	/** Aktualni uroven zanoreni
	  */
	private int level;
	/** Index na konec tabulky symbolu
	  */
	private int tx;
	/** Akceptovatelne symboly
	  */
	private SetSym fsys;
	/** Adresa zacatku kodu generovaneho timto blokem
	  */
	private int codeOffsetBegin;

	/** Metoda zpravovajici vyskyt chyby 
	  * @param ErrorType  cislo chyby.
	  */
	private void error(int ErrorType) {
		lexicalA.writeError(ErrorType);
		bug.error(ErrorType);
	}

	/** Nastaveni BugBoxu pro blok 
	  * @param bugbox  nastavovany BugBox.
	  */
	protected void setBugBox(BugBox bugbox) {
		bug = bugbox;
	}

	/** Vraceni BugBox pouzivaneho blokem 
	  * @return  pouzivany blok.
	  */
	protected BugBox getBugBox() {
		return bug;
	}

	/* Konstuktoru bloku 
	 * @param plevel  uroven zanoreni bloku,
	 * @param ptx     aktualni index na konec tabulky symbolu,
	 * @param pfsys   akceptovatelne znaky.
	 */
	protected Block(int plevel, int ptx, SetSym pfsys) {
		fsys = pfsys;
		tx = ptx;
		level = plevel;
	}

	/** Spusteni prekladu nejvyssiho bloku v hierarchii
	  * @param lex  pouzity lexikalni analyzator,
	  * @param sym  akceptovatelna mnozina symbolu,
	  * @param gen  pouzity generator kodu.
	  */
	protected void run(LexicalA lex, SymbolT sym, CodeGen gen) {
		lexicalA = lex;
		symbol = sym;
		code = gen;
		block();
	}

	/** Zpracova deklarace konstanty ve tvaru: ident=hodnota.	
	  */
	private void constDeclaration() {
		if (lexicalA.getCurrentSymbol() == SetSym.IDENT) {
			lexicalA.getNextSymbol();
			if ( (lexicalA.getCurrentSymbol() == SetSym.EQL) ||
			     (lexicalA.getCurrentSymbol() == SetSym.BECOMES) ) {
				if (lexicalA.getCurrentSymbol() == SetSym.BECOMES)
					error(BugBox.BAD_BECOMES);
				lexicalA.getNextSymbol();
				if (lexicalA.getCurrentSymbol() == SetSym.NUMBER) {
					/* Nasledujici radky jsou odstraneny, protoze        // HL
					   nema smysl shora omezovat velikost ciselne        // HL
					   konstanty ve zdrojovem souboru maximalni          // HL
					   adresou */                                        // HL
					/* if (lexicalA.getCurrentNumber() > A_MAX) {        // HL
					 	error(BugBox.TOO_BIG_NUMBER);                    // HL
						lexicalA.zeroNumber();                           // HL
					} */                                                 // HL
					/* Kontrola velikosti cisla */                       // HL
					if (lexicalA.isLastNumberTooBig())                   // HL
						error(BugBox.TOO_BIG_NUMBER);                    // HL
					/* Nasledujici funkce doplnena o jeden parametr */   // HL
					symbol.enterConstant(lexicalA.getCurrentIdentifier(),// HL
					                     level,                          // HL
					                     lexicalA.getCurrentNumber());   // HL
					// identifikator je zachovan z minuleho getNextSymbol()
					lexicalA.getNextSymbol();
				} else {
					error(BugBox.NUM_REQ);
				}
			} else {
				error(BugBox.EQUALS_REQ);
			}
		} else {
			error(BugBox.ID_REQ);
		}
	}

	/** Zpracova deklarace promenne ve tvaru: ident.	
	  * @param level  definuje uroven zanoreni
	  */
	private void varDeclaration(int level) {
		if (lexicalA.getCurrentSymbol() == SetSym.IDENT) {
			symbol.enterVariable(lexicalA.getCurrentIdentifier(),
			                     dataIndex, level);
			lexicalA.getNextSymbol();
			dataIndex++;
		} else {
			error(BugBox.ID_REQ);
		}
	}

	/** Metoda zapocinajici compilaci bloku.
	  */
	private void block() {
		int tx0;
		SetSym pom = new SetSym();
		/* reference na zanoreny blok */
		Block subblock;

		tx0=tx;
		symbol.setAddr(tx, code.getAddressCounter());
		code.gen(Fct.JMP, 0, 0);
		if (level > LEVEL_MAX)
			error(BugBox.TOO_BIG_LEVEL);
		do {
			if (lexicalA.getCurrentSymbol() == SetSym.CONSTSYM) {
				/* deklaracni cast konstant */
				lexicalA.getNextSymbol();	
				do {
					constDeclaration();
					while (lexicalA.getCurrentSymbol() == SetSym.COMMA) {
						lexicalA.getNextSymbol();
						constDeclaration();
					}
					if (lexicalA.getCurrentSymbol() == SetSym.SEMICOLON) {
						lexicalA.getNextSymbol();
					} else {
						error(BugBox.SEMI_COMO_REQ);
					}
				} while (lexicalA.getCurrentSymbol() == SetSym.IDENT);
			}
			if (lexicalA.getCurrentSymbol() == SetSym.VARSYM) {
				/* deklaracni cast promennych */
				lexicalA.getNextSymbol();
				varDeclaration(level);
				while (lexicalA.getCurrentSymbol() == SetSym.COMMA) {
					lexicalA.getNextSymbol();
					varDeclaration(level);
				}
				if (lexicalA.getCurrentSymbol() == SetSym.SEMICOLON) {
					lexicalA.getNextSymbol();
				} else {
					error(BugBox.SEMI_COMO_REQ);
				}
			}
			while (lexicalA.getCurrentSymbol() == SetSym.PROCSYM) {
				/* definice podprogramu */
				lexicalA.getNextSymbol();
				if (lexicalA.getCurrentSymbol() == SetSym.IDENT) {
					symbol.enterProcedure(lexicalA.getCurrentIdentifier(), 
					                      level);
					lexicalA.getNextSymbol();
				} else {
					error(BugBox.ID_REQ);
				}
				if (lexicalA.getCurrentSymbol() == SetSym.SEMICOLON) {
					lexicalA.getNextSymbol();
				} else {
					error(BugBox.SEMI_COMO_REQ);
				}
				pom = pom.or(fsys);
				pom.set(SetSym.SEMICOLON);
				subblock = new Block(level+1, symbol.getTableIndex(), pom);
				subblock.block();
				if (lexicalA.getCurrentSymbol() == SetSym.SEMICOLON) {
					lexicalA.getNextSymbol();
					pom = new SetSym();
					pom = pom.or(BegSys.statBegSys);
					pom.set(SetSym.IDENT);
					pom.set(SetSym.PROCSYM);
					test(pom, fsys, 6);
				} else {
					error(BugBox.SEMI_COMO_REQ);
				}
			}
			pom = new SetSym();
			pom = pom.or(BegSys.statBegSys);
			pom.set(SetSym.IDENT);
			test(pom, BegSys.declBegSys, 7);
		} while (BegSys.declBegSys.get(lexicalA.getCurrentSymbol()));
		code.setAddressAt(((Locatable) symbol.getIdentifier(tx0)).getAddress(),
		                  code.getAddressCounter());
		symbol.setAddr(tx0, code.getAddressCounter());
		codeOffsetBegin = code.getAddressCounter();
		code.gen(Fct.ING, 0, dataIndex);
	 	pom = new SetSym();
		pom = pom.or(fsys);
		pom.set(SetSym.SEMICOLON);
		pom.set(SetSym.ENDSYM);
		statement(pom, tx, level);
		code.gen(Fct.RET, 0, 0);
		test(fsys, pom, 8);
		code.listCode(codeOffsetBegin, code.getAddressCounter());
	}

	/** Generovani kodu pro ulozeni hodnoty jednoho faktoru na vrcholu
	  * zasobniku,
	  * @param fsys   mnozina dostupnych symbolu(tj.faktor muze byt pouze
	  *.              promenna, kontanta,cislo nebo levela zavorka),
	  * @param tx     index na konec tabulky symbolu,
	  * @param level  uroven faktoru.
	  */
	private void factor(SetSym fsys, int tx, int level) {
		// pomocna promenna
		int i;
		// pomocna promenna pouzivana pro vytvareni nove mnoziny symbolu
		SetSym pom;
		// aktualni identifikator
		Identifier ident;

		test(BegSys.facBegSys,fsys,24);
		while (BegSys.facBegSys.get(lexicalA.getCurrentSymbol())) {
			if (lexicalA.getCurrentSymbol() == SetSym.IDENT) {
				/* Doplen parametr funkce na nasledujici radce */        // HL
				i = symbol.position(lexicalA.getCurrentIdentifier(),     // HL
				                    level);                              // HL
				if (i == 0) {
					error(BugBox.UNDECLARED_ID);
				} else {
					ident = symbol.getIdentifier(i);
					if (ident instanceof Constant) {
						code.gen(Fct.LIT, 0, ((Constant)ident).getValue());
					} else if (ident instanceof Variable) {
						code.gen(Fct.LOD,
						         level-((Variable)ident).getLevel(),
						         ((Variable) ident).getAddress());
					} else {
						error(BugBox.INVALID_PROC_USE);
					}
				}
				lexicalA.getNextSymbol();
			} else if (lexicalA.getCurrentSymbol() == SetSym.NUMBER) {
				/* Nasledujici radky jsou odstraneny, protoze            // HL
				   nema smysl shora omezovat velikost ciselne            // HL
				   konstanty ve zdrojovem souboru maximalni              // HL
				   adresou */                                            // HL
				/* if (lexicalA.getCurrentNumber() > A_MAX) {            // HL
					error(BugBox.TOO_BIG_NUMBER);                        // HL
					lexicalA.zeroNumber();  // num = 0                   // HL
				} */                                                     // HL
				/* Kontrola velikosti cisla */                           // HL
				if (lexicalA.isLastNumberTooBig())                       // HL
					error(BugBox.TOO_BIG_NUMBER);                        // HL
				code.gen(Fct.LIT, 0, lexicalA.getCurrentNumber());
				lexicalA.getNextSymbol();
			} else {
				if (lexicalA.getCurrentSymbol() == SetSym.LPAREN) {
					/* Nasledujici radek musi byt nahrazen tim dalsim,   // HL
					   aby se preslo na nasledujici symbol (jinak to     // HL
					   zpusobovalo nekonecnou rekurzi */                 // HL
					/* lexicalA.getCurrentSymbol(); */                   // HL
					lexicalA.getNextSymbol();                            // HL
					pom = new SetSym();
					pom = pom.or(fsys);
					pom.set(SetSym.RPAREN);
					expression(pom,tx,level);
					if (lexicalA.getCurrentSymbol() == SetSym.RPAREN) {
						lexicalA.getNextSymbol();
					} else {
						error(BugBox.RPARENT_REQ);
					}
				}
			}
			pom = new SetSym();
			pom.set(SetSym.LPAREN);
			test(fsys, pom, BugBox.INVALID_FACTOR_END);
		}  // while
	}

	/** Generovani kodu pro vypocet jednoho termu,(tj. pro vyhodnoceni vyrazu
	  * ve tvaru faktor*faktor, faktor/faktor nebo faktor%faktor )
	  * @param fsys   mnozina dostupnych symbolu ve termu,
	  * @param tx     ukazovatko na konec tabulky symbolu,
	  * @param level  uroven termu.
	  */
	private void term(SetSym fsys, int tx, int level) {
		// operator termu
		int mulop;
		// promenna obsahujici aktualni symbol
		int sym;

		SetSym pom = new SetSym();
		pom = pom.or(fsys);
		pom.set(SetSym.TIMES);
		pom.set(SetSym.SLASH);
		pom.set(SetSym.MODULO);
		factor(pom,tx,level);

		sym = lexicalA.getCurrentSymbol();
		while ( (sym == SetSym.TIMES) || (sym == SetSym.SLASH) ||
		        (sym == SetSym.MODULO) ) {
			mulop = sym;
			lexicalA.getNextSymbol();
			pom = pom.or(fsys);
			pom.set(SetSym.TIMES);
			pom.set(SetSym.SLASH);
			pom.set(SetSym.MODULO);
			factor(pom, tx, level);
			switch (mulop) {
			case SetSym.TIMES:
				code.gen(Fct.OPR, 0, OOperation.MUL);
				break;
			case SetSym.SLASH:
				code.gen(Fct.OPR, 0, OOperation.DI);
				break;
			case SetSym.MODULO:
				code.gen(Fct.OPR, 0, OOperation.MOD);
				break;
			}
			sym = lexicalA.getCurrentSymbol();
		}
	}

	/** Generovani kodu pro vyhodnoceni aritm. vyrazu.
	  * @param fsys   mnozina dostupnych symbolu ve vyrazu,
	  * @param tx     ukazovatko na konec tabulky symbolu,
	  * @param level  uroven vyrazu.
	  */
	private void expression(SetSym fsys, int tx, int level) {
		// pouzity relacni operator
		int addop;
		// promenna obsahujici aktualni symbol
		int sym;
		// pomocna promenna obsahujici kod aktualniho symbolu		
		SetSym pom = new SetSym();

		sym = lexicalA.getCurrentSymbol();
		if ( (sym == SetSym.PLUS) || (sym == SetSym.MINUS) ) {
			addop = sym;
			lexicalA.getNextSymbol();
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.PLUS);
			pom.set(SetSym.MINUS);
			term(pom, tx, level);
			if (addop == SetSym.MINUS) 
				code.gen(Fct.OPR, 0, OOperation.NEG);
		} else {
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.PLUS);
			pom.set(SetSym.MINUS);
			term(pom, tx, level);
		}
		sym = lexicalA.getCurrentSymbol();
		while ( (sym == SetSym.PLUS) || (sym == SetSym.MINUS) ) {
			addop = sym;
			lexicalA.getNextSymbol();
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.PLUS);
			pom.set(SetSym.MINUS);
			term(pom, tx, level);
			if (addop == SetSym.PLUS) {
				code.gen(Fct.OPR, 0, OOperation.ADD);
			} else {
				code.gen(Fct.OPR, 0, OOperation.SUB);
			}
			sym = lexicalA.getCurrentSymbol();
		}
	}

	/** Generovani kodu pro vyhodnoceni logickeho vyrazu
	  * @param fsys   dostupne symoboly v vyrazu
	  * @param tx     ukazovatko na konec tabulky symbolu
	  * @param level  uroven, ve ktere je prelozeny vyraz
	  */
	private void condition(SetSym fsys, int tx, int level) {
		// pouzita relace
		int relop;
		// pomocna promenna	pro vytvareni nove mnoziny symbolu
		SetSym pom;
		// pomocna promenna obsahujici kod aktualniho symbolu
		int sym;

		if (lexicalA.getCurrentSymbol() == SetSym.ODDSYM) {
			lexicalA.getNextSymbol();
			expression(fsys, tx, level);
			code.gen(Fct.OPR, 0, OOperation.ODD);
		} else {
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.EQL);  pom.set(SetSym.NEQ);
			pom.set(SetSym.LSS);  pom.set(SetSym.GTR);
			pom.set(SetSym.LEQ);  pom.set(SetSym.GEQ);
			expression(pom, tx, level);
			sym = lexicalA.getCurrentSymbol();
			if ( (sym != SetSym.EQL) && (sym != SetSym.NEQ) &&
			     (sym != SetSym.LSS) && (sym != SetSym.GTR) &&
			     (sym != SetSym.LEQ) && (sym != SetSym.GEQ) ) {
				error(BugBox.RPARENT_REQ);
			} else {
				relop = sym;
				lexicalA.getNextSymbol();
				expression(fsys,tx,level);
				switch (relop) {
				case SetSym.EQL:
					code.gen(Fct.OPR, 0, OOperation.EQ);
					break;
				case SetSym.NEQ:
					code.gen(Fct.OPR, 0, OOperation.NE);
					break;
				case SetSym.LSS:
					code.gen(Fct.OPR, 0, OOperation.LT);
					break;
				case SetSym.GEQ:
					code.gen(Fct.OPR, 0, OOperation.GE);
					break;
				case SetSym.GTR:
					code.gen(Fct.OPR, 0, OOperation.GT);
					break;
				case SetSym.LEQ:
					code.gen(Fct.OPR, 0, OOperation.LE);
					break;
				}
			}
		}
	}

	/** Generovani kodu pro prikaz
	  * @param fsys  dostupne symboly v statmentu,
	  * @param tx     ukazovatko na konec tabulky symbolu,
	  * @param level  uroven, ve ktere je prelozeny statement.
	  */
	private void statement(SetSym fsys, int tx, int level) {
		// pomocna a promenna a promenne pro praci s indexem
		// do tabulky kodu.
		int i, cx1, cx2;
		// pomocna promenna obsahujici kod aktualniho symbolu
		int sym;

		SetSym pom = new SetSym();
		sym = lexicalA.getCurrentSymbol();
		if ( (!fsys.get(sym)) && (sym != SetSym.IDENT) ) {
			error(BugBox.BAD_SYMB);
			do {
				lexicalA.getNextSymbol();
			} while (!fsys.get(lexicalA.getCurrentSymbol()));
		}
		if (lexicalA.getCurrentSymbol() == SetSym.IDENT) {
			/* nalezen prikaz prirazeni */
			/* Doplen parametr funkce na nasledujici radce */            // HL
			i = symbol.position(lexicalA.getCurrentIdentifier(),         // HL
			                    level);                                  // HL
			if (i <= 0) {
				error(BugBox.UNDECLARED_ID);
			} else if (!(symbol.getIdentifier(i) instanceof Variable)) {
				/* prirazeni do jineho ident. nez promenna */
				error(BugBox.WRONG_BECOMES);
				i = 0;
			}
			lexicalA.getNextSymbol();
			if (lexicalA.getCurrentSymbol() == SetSym.BECOMES) {
				lexicalA.getNextSymbol();
			} else {
				error(BugBox.BECOMES);
			}
			expression(fsys,tx,level);
			sym = lexicalA.getCurrentSymbol();
			if (i != 0) {
				code.gen(Fct.STO,
				         level-((Variable) symbol.getIdentifier(i)).getLevel(),
				         ((Variable) symbol.getIdentifier(i)).getAddress());
			}
		} else if (sym == SetSym.CALLSYM) {
			/* nalezeno volani podprogramu */
			lexicalA.getNextSymbol();
			if (lexicalA.getCurrentSymbol() != SetSym.IDENT) {
				error(BugBox.ID_PAS_CALL);
			} else {
				/* Doplen parametr funkce na nasledujici radce */        // HL
				i = symbol.position(lexicalA.getCurrentIdentifier(),     // HL
				                    level);                              // HL
				if (i == 0) {
						error(BugBox.UNDECLARED_ID);
				} else {
					if (symbol.getIdentifier(i) instanceof Procedure) {
						code.gen(Fct.CAL,
						         level- ((Procedure)
						           symbol.getIdentifier(i)).getLevel(),
						         ((Procedure)
						           symbol.getIdentifier(i)).getAddress());
					} else {
						error(BugBox.INVALID_CALL);
					}
				}
			lexicalA.getNextSymbol();
			}
		} else if (lexicalA.getCurrentSymbol() == SetSym.IFSYM) {
			/* podmineny prikaz */
			lexicalA.getNextSymbol();
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.THENSYM);
			pom.set(SetSym.DOSYM);
			condition(pom,tx,level);
			if (lexicalA.getCurrentSymbol() == SetSym.THENSYM) {
				lexicalA.getNextSymbol();
			} else {
				error(BugBox.THEN_REQ);
			}
			cx1 = code.getAddressCounter();
			code.gen(Fct.JPC, 0, 0);
			statement(fsys, tx, level);
			code.setAddressAt(cx1, code.getAddressCounter());
		} else if (lexicalA.getCurrentSymbol() == SetSym.BEGINSYM) {
			/* zacina novy blok */
			lexicalA.getNextSymbol();
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.SEMICOLON);
			pom.set(SetSym.ENDSYM);
			statement(pom, tx, level);
			sym = lexicalA.getCurrentSymbol();
			while ( (BegSys.statBegSys.get(sym)) || (sym==SetSym.SEMICOLON) ) {
				if (sym == SetSym.SEMICOLON) {
					lexicalA.getNextSymbol();
					sym = lexicalA.getCurrentSymbol();
				} else {
					error(BugBox.BAD_SYMB);
				}
				pom = pom.or(fsys);
				pom.set(SetSym.SEMICOLON);
				pom.set(SetSym.ENDSYM);
				statement(pom, tx, level);
				sym = lexicalA.getCurrentSymbol();
			}
			if (sym == SetSym.ENDSYM) {
				lexicalA.getNextSymbol();
			} else {
				error(BugBox.END_BLOCK_REQ);
			}
		} else if (sym == SetSym.WHILESYM) {
			/* zacina cyklus while */
			cx1 = code.getAddressCounter();
			lexicalA.getNextSymbol();
			pom = new SetSym();
			pom = pom.or(fsys);
			pom.set(SetSym.DOSYM);
			condition(pom, tx, level);
			cx2 = code.getAddressCounter();
			code.gen(Fct.JPC, 0, 0);
			if (lexicalA.getCurrentSymbol() == SetSym.DOSYM) {
				lexicalA.getNextSymbol();
			} else {
				error(BugBox.DO_REQ);
			}
			statement(fsys, tx, level);
			code.gen(Fct.JMP, 0, cx1);
			code.setAddressAt(cx2, code.getAddressCounter());
		}
		test(fsys, pom, 19); /* test koreknost ukonceni statementu */
	}

	/** Testuje zda nacteny symbol je v mnozine symbolu 's1'.
	  * Pokud neni generuje chybu a nacita opakovane ze vstupu
	  * dokud neni nacten pristupny symbol v mnozina 's1' a 's2'
	  * @param s1  predpokladana mnozina znaku,
	  * @param s2  akceptovatelna mnozina znaku.
	  */
	private void test(SetSym s1, SetSym s2, int n) {
		// pomocna referencni promenna na mnozinu znaku.
		SetSym pom = new SetSym();

		if (!s1.get(lexicalA.getCurrentSymbol())) {
			error(n);
			pom = pom.or(s1);
			pom = pom.or(s2);
			while (!pom.get(lexicalA.getCurrentSymbol())) 
				lexicalA.getNextSymbol();
		}
	}

}
