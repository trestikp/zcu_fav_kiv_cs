Feature: test generovani osobniho cisla

  Background:
    Given je otevrena stranka generovani
    #And vymaz formular

  @negativni
  Scenario: prazdny formular
    When zmackni generovani
    Then vyhozena celkova chyba

  Scenario Outline: generovani os cisla ze spravneho formulare
    When zadam fakulu <fakulta>
    And zadam rok <rok>
    And zadam typ <typ>
    And zadam poradi <poradi>
    And zadam formu <forma>
    And zmackni generovani
    Then dostanu <vysledek>

    @spravne
    Examples:
      | fakulta | rok | typ         | poradi | forma       | vysledek  |
      | FAV     | 22  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 00  | bakalářský  | 0123   | prezenční   | A00B0123P |
      | FAV     | 22  | bakalářský  | 1      | prezenční   | A22B0001P |
      | FAV     | 22  | bakalářský  | 0123   | distanční   | A22B0123D |
      | FAV     | 22  | navazující  | 0123   | prezenční   | A22N0123P |
      | FAV     | 22  | navazující  | 0123   | distanční   | A22N0123D |
      | FAV     | 22  | doktorský   | 0123   | prezenční   | A22P0123P |
      | FAV     | 22  | doktorský   | 0123   | distanční   | A22P0123D |
      | FAV     | 22  | magisterský | 0123   | prezenční   | A22M0123P |
      | FAV     | 22  | magisterský | 0123   | distanční   | A22M0123D |
      | FDU     | 22  | bakalářský  | 0123   | prezenční   | D22B0123P |
      | FEL     | 22  | bakalářský  | 0123   | prezenční   | E22B0123P |
      | FF      | 22  | bakalářský  | 0123   | prezenční   | F22B0123P |
      | FPE     | 22  | bakalářský  | 0123   | prezenční   | P22B0123P |
      | FST     | 22  | bakalářský  | 0123   | prezenční   | S22B0123P |
      | FZS     | 22  | bakalářský  | 0123   | prezenční   | Z22B0123P |

    @zname_chyby
    Examples:
      | fakulta | rok | typ         | poradi | forma       | vysledek  |
      | FEK     | 15  | bakalářský  | 0123   | prezenční   | K15B0123P |
      | FPR     | 15  | bakalářský  | 0123   | prezenční   | R15B0123P |
      | FAV     | 99  | bakalářský  | 9876   | kombinovaná | A99B9876K |
      | FZS     | 20  | bakalářský  | 0101   | kombinovaná | Z20B0101K |

  Scenario Outline: testovani chybnych vstupu
    When zadam fakulu <fakulta>
    And zadam rok <rok>
    And zadam typ <typ>
    And zadam poradi <poradi>
    And zadam formu <forma>
    And zmackni generovani
    Then vyhozena celkova chyba

    @negative_inputs
    Examples:
      | fakulta | rok | typ         | poradi | forma       | vysledek  |
      # faculty errors
      | " "     | 22  | bakalářský  | 0123   | prezenční   | A22B0123P |
      # year errors
      | FAV     | " "  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 1    | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 111  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | ahoj | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | -12  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | +12  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 1,2  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 1.2  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 1E2  | bakalářský  | 0123   | prezenční   | A22B0123P |
      | FAV     | 1E-4 | bakalářský  | 0123   | prezenční   | A22B0123P |
      # type errors (can't have invalid value)
      # number errors
      | FAV     | 22  | bakalářský  | " "   | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 0     | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 00    | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 000   | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 0000  | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 12345 | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | ahoj  | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | +1234 | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | -1234 | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 12.34 | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 12,34 | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 1E2   | prezenční   | A22B0123P |
      | FAV     | 22  | bakalářský  | 1E-4  | prezenční   | A22B0123P |
      # form errors
      | FAV     | 22  | bakalářský  | 0123   | " "   | A22B0123P |

  @zahranicni
  @zname_chyby
  Scenario: zahranicni student
    When zadam fakulu FAV
    And zadam rok 22
    And zadam typ bakalářský
    And zadam poradi 1839
    And zadam formu kombinovaná
    And zvolim zahranicniho studenta
    And zmackni generovani
    Then dostanu A22B1839KI