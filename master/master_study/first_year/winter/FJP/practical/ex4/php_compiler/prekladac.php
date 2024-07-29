<!--
pùvodní kód Tomáš Rieger
opravy Jiøí Vavrejn
opravy Petr Sládek 
-->
<?php

/* PS: Následující øádka zpùsobuje naètení textu z webové stránky
* ze vstupního pole do promìnné. Pokud máte server nastavený podobnì
* jako já (tak jak se doporuèuje z bezpeènostního hlediska), budete
* to potøebovat. Na serveru KIVu to ale není nutné.
* Pokud s tím nesouhlasíte, následující øádku zakomentujte. */
$text = $_POST["text"];

define("NSYM", 35);		         /* pocet rozponatelnych symbol u*/
define("NORW", 11);              /* pocet klicovych slov */
define("TMAX", 100);            /* velikost tabulky identifikatoru */
define("AL", 10);                /* delka identifikatoru */
define("NMAX", 5);               /* maximalni pocet cislic v cisle */
define("CHSETSIZE", 128);        /* pocet znaku v mnozine */
define("MAXERR", 30);            /* maximalni pocet chyb */
define("LEVMAX", 3);             /* maximalni hloubka vnoreni */
define("AMAX", 2048);            /* nejvyssi adresa */
define("CXMAX", 200);            /* velikost prostoru pro kod */
define("STACKSIZE", 500);


// SYMBOL
define("Knull", 0);
define("Kident", 1);
define("Knumber", 2);
define("Kplus", 3);
define("Kminus", 4);
define("Ktimes", 5);
define("Kslash", 6);
define("Kmodulo", 7);
define("Koddsym", 8);
define("Keql", 9);
define("Kneq", 10);
define("Klss", 11);
define("Kleq", 12);
define("Kgtr", 13);
define("Kgeq", 14);
define("Klparen", 15);
define("Krparen", 16);
define("Kcomma", 17);
define("Ksemicolon", 18);
define("Kperiod", 19);
define("Kbecomes", 20);
define("Kbeginsym", 21);
define("Kendsym", 22);
define("Kifsym", 23);
define("Kthensym", 24);
define("Kwhilesym", 25);
define("Kdosym", 26);
define("Kcallsym", 27);
define("Kconstsym", 28);
define("Kvarsym", 29);
define("Kprocsym", 30);



//OOBJECT
define("Kconstant", 0);
define("Kvariable", 1);
define("Kprocedure", 2);



//FCT
define("Klit", 0);  //lit 0,A        :uloz konstantu A do zasobniku
define("Kopr", 1);  //opr 0,A        :proved instrukci A
define("Klod", 2);  //lod L,A        :uloz promenne L, A na vrchol zasobniku
define("Ksto", 3);  //sto L,A        :zapis promennou L z vrcholu zasobniku do pameti
define("Kcal", 4);  //cal L,A        :volej proceduru A z urovne L
define("Kret", 5);  //ret 0,0        :return
define("King", 6);  //int 0,A        :zvys obsah T-registru o hodnotu A
define("Kjmp", 7);  //jmp 0,A        :proved skok na adresu A
define("Kjpc", 8);  //jpc 0,A        :proved podmineny skok na adresu A

//OPERATION
define("Kzeroindex", 0); 
define("Kneg", 1); //negace hodnoty na vrcholu zasobniku
define("Kadd", 2); //soucet dvou hodnot na vrcholu zasobniku
define("Ksub", 3); //rozdil dvou hodnot na vrcholu zasobniku
define("Kmul", 4); //soucin dvou hodnot na vrcholu zasobniku
define("Kdi", 5);  //deleni dvou hodnot na vrcholu zasobniku 
define("Kmod", 6); //modulo dvou hodnot na vrcholu zasobniku
define("Kodd", 7); //test lichosti hodnot na vrcholu zasobniku 
define("Keq", 8);  //test rovnost dvou hodnot na vrcholu zasobniku 
define("Kne", 9);  //test nerovnost dvou hodnot na vrcholu zasobniku 
define("Klt", 10); //mensi
define("Kge", 11); //vetsi nebo rovno
define("Kgt", 12); //vetsi
define("Kle", 13); //mensi nebo rovno


class INSTRUCTION {
	var $f; //kod funkce
	var $l; //uroven
	var $a; //cast adresy nebo kod operace
}

class PrvekTabulky{
	var $name;
	var $kind;
	var $val;
	var $level;
	var $adr;
	var $size;
}


/*********************************************************************
**********************************************************************
*********************************************************************/
//sjednoti 2 mnoziny symbolu
function sjednot(&$s1, $s2)
{
	for ($i = 0; $i < NSYM; $i++)
	{
		$s1[$i] = $s1[$i] || $s2[$i];
	}
}

function nuluj()
{
	for ($i = 0; $i < NSYM; $i++)
	{
		$pom[$i] = 0;
	}
	return $pom;
}

//vypis chyby
function error($n) {
	global $cc;
	global $err;

/* PS: Výpis èísla øádky. */
	global $lineno;

    switch($n)	
    {
      case 1 : echo 'pouzito "=" misto ":="';
        break;
      case 2 : echo 'za "=" musi nasledovat cislo';
        break;
      case 3 : echo 'za identifikatorem ma nasledovat "="';
        break;
      case 4 : echo 'za "const", "var", "procedure" musi nasledovat identifikator';
        break;
      case 5 : echo 'chybi strednik nebo carka';
        break;
      case 6 : echo 'nespravny symbol po deklaraci procedury';
        break;
      case 7 : echo 'je ocekavan prikaz';
        break;
      case 8 : echo 'neocekavany symbol za prikazovou casti bloku';
        break;
      case 9 : echo 'ocekavam tecku';
        break;
      case 10 : echo 'nespravny symbol v prikazu';
        break;
      case 11	: echo 'nedeklarovany identifikator';
        break;
      case 12	: echo 'prirazeni konstante a procedure neni dovoleno';
        break;
      case 13	: echo 'operator prirazeni je ":="';
        break;
      case 14	: echo 'za "call" musi nasledovat identifikator';
        break;
      case 15	: echo 'volani konstanty nebo promenne neni dovoleno';
        break;
      case 16	: echo 'ocekavano "then"';
        break;
      case 17	: echo 'ocekavano "end" nebo ";"';
        break;
      case 18	: echo 'ocekavano "do"';
        break;
      case 19	: echo 'nespravne pouzity symbol za prikazem';
        break;
      case 20	: echo 'ocekavam relaci';
        break;
      case 21	: echo 'jmeno procedury nelze pouzit ve vyrazu';
        break;
      case 22	: echo 'chybi uzaviraci zavorka';
        break;
      case 23	: echo 'faktor nesmi koncit timto symbolem';
        break;
      case 24	: echo 'vyraz nesmi zacinat timto symbolem';
        break;
      case 30	: echo 'prilis velke cislo';
        break;
      case 32	: echo 'prilis velke zanoreni';
        break;
    }
/* PS: Výpis èísla øádky. */
    echo "\ncislo radky: $lineno\n";
    if (++$err > MAXERR)
    	konec();

}

//vraci 1 znak z parametru text stranky 
function getch()
{
	global $ch;
	global $text;
	global $pozice;
	
/* PS: Poèítání èísla øádky. */
	global $lineno;

	if ($pozice == strlen($text))
	{
		echo "nekompletni program";
		konec();
	}
	$ch = $text[$pozice++];
/* PS: Poèítání èísla øádky. */
	if ($ch == "\n") $lineno++;
}

//nacte 1 symbol
function getsym()
{
	global $ch;
	global $iva;
	global $zdroj;
	global $txpom;
	global $sym;
	global $id;
	global $num;
	global $cc;
	global $ll;
	global $kk;
	global $err;
	global $cx;
	global $a;
	global $code;
	global $word;
	global $wsym;
	global $ssym;
	global $mnemonic;
	global $declbegsys;
	global $statbegsys;
	global $facbegsys;
	global $cx0;
	global $b;
	global $s;
	
/* PS: Tato funkce nepracuje s globální promìnnou $pom. */
/*	global $pom;*/
	
	$a = "";

	while ($ch <= ' ') getch();
    if (($ch >= 'a') && ($ch <= 'z'))
    {   /* identifier or reserved word */
        $k = 0;
        do {
            if ($k < AL)
            {
            	$a = $a."".$ch;
            	$k++;
            }
            getch();
        } while ((($ch >= 'a') && ($ch <= 'z')) || (($ch >= '0') && ($ch <= '9')));

        $id = $a;//strcpy($id, $a);
        $i = 0;
        $j = NORW - 1;

        do {
            $k = (int) (($i + $j) / 2);
            if (strcmp($id, $word[$k]) <= 0) $j = $k - 1;
            if (strcmp($id, $word[$k]) >= 0) $i = $k + 1;
        } while ($i <= $j);

        if (($i - 1) > $j) 
        {
        	$sym = $wsym[$k];
        }
        else 
        {
        	$sym = Kident;
        }
    }
    else
    {
        if (($ch >= '0') && ($ch <= '9')) {   /* number */
            $k = $num = 0;
            $sym = Knumber;

            do {
                $num = 10 * $num + ($ch - '0');
                $k++;
                getch();
            } while (($ch >= '0') && ($ch <= '9'));
            if ($k > NMAX) error(30);
        }
        else
        {
            if ($ch == ':') {
                getch();
                if ($ch == '=') {
                    $sym = Kbecomes;
                    getch();
                }
                else $sym = Knull;
            }
            else
            {
                if ($ch == '<') {
                    getch();
                    if ($ch == '=') {
                        $sym = Kleq;
                        getch();
                    }
                    else
                        if ($ch == '>') {
                            $sym = Kneq;
                            getch();
                        }
                        else
                            $sym = Klss;
                }
                else
                {
                    if ($ch == '>') {
                        getch();
                        if ($ch == '=') {    /* JV : pridan znak $*/
                            $sym = Kgeq;
                            getch();
                        }
                        else $sym = Kgtr;
                    }
                    else {
                        $sym = $ssym[ord($ch)];
                        getch();
                    }
                }
            }
        }
    }
} 

//generovani instrukce do pole kodu
function gen($x, $y, $z)
{
	global $cx;
	global $code;
	
	if ($cx > CXMAX)
	{
		echo "program je prilis dlouhy\n";
		konec();
	}

	$code[$cx]->f = $x;
	$code[$cx]->l = $y;
	$code[$cx++]->a = $z;
}

// testovat zda nacteny symbol je v mnozine symbolu 's1'.
// Pokud neni generuje chybu a nacita opakovane ze vstupu
// dokud neni nacten pristupny symbol v mnozina 's1' a 's2'
function test($s1,$s2,$n) {
	
	global $sym;
/* PS: Jedná se IMHO o bug, protože $pom nemá pracovat s globální promìnnou. */
/*	global $pom;*/

    if ($s1[$sym] == 0) {
        error($n);
        $pom = nuluj();
        sjednot($pom,$s1);
        sjednot($pom,$s2);

        while ($pom[$sym] == 0)
          getsym();
    }
}

//vlozi object do tabulky symbolu
function enter($k, &$tx, $lev, &$dx) {
	
	global $num;
	global $txpom;
	global $TABLE;
	global $id;

    $tx++;
    $txpom = $tx; /* OR -- bast aby fungovala TS */
    $TABLE[$tx]->name = $id;
    $TABLE[$tx]->kind = $k;

    switch ($k) {
        case Kconstant: if ($num > AMAX) {
		                     error(31);
		                     $num = 0;
                       }
                       $TABLE[$tx]->val = $num;
                       break;

        case Kvariable: $TABLE[$tx]->level = $lev;
		               $TABLE[$tx]->adr = $dx++;
		               break;

        case Kprocedure: $TABLE[$tx]->level = $lev;
		                break;

    }
}

//vyhleda symbol v tabulce symbolu 
function position($id, $tx)
{
	global $TABLE;
	
	$TABLE[0]->name = $id;
	$i = $tx;
	while(strcmp($TABLE[$i]->name,$id))
    $i--;
	return $i;
}

// zpracova deklarace konstanty
// $tx a $dx musí vracet hodnotu;
function constdeclaration(&$tx, $lev, &$dx)
{
	global $sym;
	global $ch;
	

if ($sym == Kident) {
    getsym();
    if (($sym == Keql) || ($sym == Kbecomes)) {
        if ($sym == Kbecomes) 
        	error(1);
        getsym();
        if ($sym == Knumber) {
            enter(Kconstant,$tx,$lev,$dx);
            getsym();
        } else error(2);
    } else error(3);
} else error(4);

}

//zpracova deklarace promenne
//musi vracet hodnotu
function vardeclaration(&$tx,$lev,&$dx) {
	global $sym;

	if ($sym == Kident) {
    	enter(Kvariable,$tx,$lev,$dx);
    	getsym();
	} else error(4);

}
//vypis kodu
function listcode() {
	global $code;
	global $cx0;
	global $cx;
    for ($i=0;$i<=($cx-1);$i++)
    {
    	printf("%3d  ",$i);
    	switch ($code[$i]->f)
    	{
    		case Klit : echo "LIT";
    			break;
    		case Kopr : echo "OPR";
    			break;
    		case Klod : echo "LOD";
    			break;
    		case Ksto : echo "STO";
    			break;
    		case Kcal : echo "CAL";
    			break;
    		case Kret : echo "RET";
    			break;
    		case King : echo "INT";
    			break;
    		case Kjmp : echo "JMP";
    			break;
    		case Kjpc : echo "JMC";
    			break;
    	}

      printf("%10d",$code[$i]->l);
      printf("%10d",$code[$i]->a);
      echo "\n";
    }
}   /* listcode() */


//generovani kodu pro ulozeni hodnoty jednoho faktoru na vrcholu zasobniku,
function factor($fsys, $tx, $lev) {
	global $facbegsys;
	global $sym;
	global $id;
	global $TABLE;
	global $num;
	
    test($facbegsys,$fsys,24);
    while ($facbegsys[$sym]) {
        if ($sym == Kident) {
            $i = position($id,$tx);
            if ($i == 0) error(1);
            else
                switch ($TABLE[$i]->kind) {
	                case Kconstant: gen(Klit,0,$TABLE[$i]->val);
                                   break;

	                case Kvariable: gen(Klod,$lev-$TABLE[$i]->level,$TABLE[$i]->adr);
                                   break;

	                case Kprocedure: error(21);
                                    break;

	            }
            getsym();
        } 
        else
        {
            if ($sym == Knumber) {
                if ($num > AMAX) {
                    error(31);
                    $num = 0;
                }
                gen(Klit,0,$num);
                getsym();
            } 
            else
            {
                if ($sym == Klparen) {
                    getsym();
                    $pom = nuluj();
                    sjednot($pom,$fsys);
                    $pom[Krparen] = 1;
                    expression($pom,$tx,$lev);
                    if ($sym == Krparen) getsym();
                    else error(22);
                }
            }
        }
        $pom = nuluj();
        $pom[Klparen] = 1;
        test($fsys,$pom,23);
    }
}

//generovani kodu pro vypocet jednoho termu
function term($fsys, $tx, $lev) {
	
	global $sym;
    $pom = nuluj();
    sjednot($pom,$fsys);
    $pom[Ktimes] = $pom[Kslash] = $pom[Kmodulo] = 1;
    factor($pom,$tx,$lev);

    while (($sym == Ktimes) || ($sym == Kslash) || ($sym == Kmodulo)) {
        $mulop = $sym;
        getsym();
        sjednot($pom,$fsys);
        $pom[Ktimes] = $pom[Kslash] = $pom[Kmodulo] = 1;
        factor($pom,$tx,$lev);

        switch($mulop) {
            case Ktimes: gen(Kopr,0,Kmul);
                        break;

            case Kslash: gen(Kopr,0,Kdi);
                        break;

            case Kmodulo: gen(Kopr,0,Kmod);
                         break;

        }
    }

}

//generovat kody pro vyhodnoceni aritm. vyrazu
function expression($fsys, $tx, $lev) {
	global $sym;
	
    if (($sym == Kplus) || ($sym == Kminus)) {
        $addop = $sym;
        getsym();
        $pom = nuluj();
        sjednot($pom,$fsys);
        $pom[Kplus] = $pom[Kminus] = 1;
        term($pom,$tx,$lev);
        if ($addop == Kminus) gen(Kopr,0,Kneg);    /* JV: kaddop zneneno na $addop*/
    }
    else {
        $pom = nuluj();
        sjednot($pom,$fsys);
        $pom[Kplus] = $pom[Kminus] = 1;
        term($pom,$tx,$lev);
    }

    while (($sym == Kplus) || ($sym == Kminus)) {
        $addop = $sym;
        getsym();
        $pom = nuluj();
        sjednot($pom,$fsys);
        $pom[Kplus] = $pom[Kminus] = 1;
        term($pom,$tx,$lev);

        if ($addop == Kplus) gen(Kopr,0,Kadd);
        else 
          gen(Kopr,0,Ksub);
    }
}

//generovat kody pro vyhodnoceni logickeho vyrazu
function condition($fsys, $tx, $lev) {
	global $sym;
	
    if ($sym == Koddsym) {
        getsym();
        expression($fsys,$tx,$lev);
        gen(Kopr,0,Kodd);
    }
    else {
        $pom = nuluj();
        sjednot($pom,$fsys);
        $pom[Keql] = $pom[Kneq] = $pom[Klss] = $pom[Kgtr] = $pom[Kleq] = $pom[Kgeq] = 1;
        expression($pom,$tx,$lev);
        if (($sym != Keql) && ($sym != Kneq) && ($sym != Klss) && ($sym != Kgtr) && ($sym != Kleq) && ($sym != Kgeq))
            error(22);
        else {
            $relop = $sym;
            getsym();
            expression($fsys,$tx,$lev);

            switch ($relop) {
                case Keql: gen(Kopr,0,Keq);
                          break;

                case Kneq: gen(Kopr,0,Kne);
                          break;

                case Klss: gen(Kopr,0,Klt);
                          break;

                case Kgeq: gen(Kopr,0,Kge);
                          break;

                case Kgtr: gen(Kopr,0,Kgt);
                          break;

                case Kleq: gen(Kopr,0,Kle);
                          break;

            }
        }
    }

}

//generovani kodu pro statement
function statement($fsys, $tx, $lev) {
	global $sym;
	global $TABLE;
	global $statbegsys;
	global $id;
	global $cx;
	global $code;

    if (($fsys[$sym] == 0) && ($sym != Kident)) {
        error(10);
        do
            getsym();
        while ($fsys[$sym] == 0);
    }
    if ($sym == Kident) { /*nalezen prikaz prirazeni*/
        $i = position($id,$tx);
        if ($i == 0) error(11);
        else
            if ($TABLE[$i]->kind != Kvariable) { /*prirazeni do jineho ident. nez promenna*/
                error(12);
                $i = 0;
            }
        getsym();
        if ($sym == Kbecomes) getsym();
        else error(13);
        expression($fsys,$tx,$lev);
        if ($i) gen(Ksto,$lev-$TABLE[$i]->level,$TABLE[$i]->adr);
    }
    else
        if ($sym == Kcallsym) {/*nalezeno volani podprogramu*/
            getsym();
            if ($sym != Kident) error(14);
	        else {
	            if (($i = position($id,$tx)) == 0) error(11);
	            else {
	                if ($TABLE[$i]->kind == Kprocedure) gen(Kcal,$lev-$TABLE[$i]->level,$TABLE[$i]->adr);
					else error(15);
                }
	            getsym();
	        }
        }
        else
            if ($sym == Kifsym) { /*podmineny prikaz*/
                getsym();
                $pom = nuluj();
                sjednot($pom,$fsys);
/* PS: Je velmi divné, že implementace PL/0 ve všech jazycích registrují
		'do' u 'if', i když je funkèní pouze 'then'. */
                $pom[Kthensym] = $pom[Kdosym] = 1;
                condition($pom,$tx,$lev);

                if ($sym == Kthensym) getsym();
                else error(16);
                $cx1 = $cx;
                gen(Kjpc,0,0);
                statement($fsys,$tx,$lev);
                $code[$cx1]->a = $cx;
            }
            else
            {
                if ($sym == Kbeginsym) { /*zacina novy blok*/
                    getsym();
                    $pom = nuluj();
                    sjednot($pom,$fsys);
                    $pom[Ksemicolon] = $pom[Kendsym] = 1;
                    statement($pom,$tx,$lev);

                    while (($statbegsys[$sym]) || ($sym == Ksemicolon)) {
                        if ($sym == Ksemicolon) getsym();
                        else error(10);
                        sjednot($pom,$fsys);
                        $pom[Ksemicolon] = $pom[Kendsym] = 1;
                        statement($pom,$tx,$lev);
                    }

                    if ($sym == Kendsym) getsym(); /*konci predchozi blok*/
                    else error(17);
                }
                else
                {
                    if ($sym == Kwhilesym) { /*zacina cyklus while*/
                        $cx1 = $cx;
                        getsym();
                        $pom = nuluj();
                        sjednot($pom,$fsys);
                        $pom[Kdosym] = 1;
                        condition($pom,$tx,$lev);
                        $cx2 = $cx;
                        gen(Kjpc,0,0);
                        if ($sym == Kdosym) getsym();
                        else error(18);
                        statement($fsys,$tx,$lev);
                        gen(Kjmp,0,$cx1);
                        $code[$cx2]->a = $cx;
                     }
                 }
              }
    test($fsys,$pom,19); /*test koreknost ukonceni statementu*/

}  

//generovani kodu pro blok
function block($lev, $tx, $fsys) {

	global $TABLE;
	global $cx;
	global $sym;
	global $pom;
	global $statbegsys;
	global $declbegsys;
	global $code;
	
    $dx = 3;
    $tx0 = $tx;
    $TABLE[$tx]->adr = $cx;
    gen(Kjmp,0,0);
    if ($lev > LEVMAX) error(32);

    do {
        if ($sym == Kconstsym) { /*deklaracni cast konstant*/
            getsym();

            do {
                constdeclaration($tx,$lev,$dx);
                while ($sym == Kcomma) {
                    getsym();
                    constdeclaration($tx,$lev,$dx);
                }
                if ($sym == Ksemicolon) getsym();
                else error(5);
            } while ($sym==Kident);
        }
        if ($sym == Kvarsym) { /*deklaracni cast promennych*/
            getsym();
            vardeclaration($tx,$lev,$dx);

            while ($sym == Kcomma) {
                getsym();
                vardeclaration($tx,$lev,$dx);
            }
            if ($sym == Ksemicolon) getsym();
		    else error(5);
        }
        while ($sym == Kprocsym) { /*definice podprogramu*/
            getsym();
            if ($sym == Kident) {
                enter(Kprocedure,$tx,$lev,$dx);
                getsym();
            } else error(4);
            if ($sym==Ksemicolon) getsym();
            else error(5);
            $pom = nuluj();
            sjednot($pom,$fsys);
            $pom[Ksemicolon] = 1;
            block($lev+1,$tx,$pom);
            if ($sym == Ksemicolon) {
                getsym();
                $pom = nuluj();
                sjednot($pom,$statbegsys);
                $pom[Kident] = $pom[Kprocsym] = 1;
                test($pom,$fsys,6);
            } else error(5);
        }
        $pom = nuluj();
        sjednot($pom,$statbegsys);
        $pom[Kident] = 1;
        test($pom,$declbegsys,7);
    } while ($declbegsys[$sym]);
        
    $xxx = $TABLE[$tx0]->adr;    
    $code[$xxx]->a = $cx;
    $TABLE[$tx0]->adr = $cx;
    $TABLE[$tx0]->size = $dx;
    $cx0 = $cx;
    gen(King,0,$dx);
    $pom = nuluj();
    sjednot($pom,$fsys);
    $pom[Ksemicolon] = $pom[Kendsym] = 1;
    statement($pom,$tx,$lev);
    gen(Kret,0,0);
    test($fsys,$pom,8);

}   /* block() */




/*********************************************************************
**********************************************************************
*********************************************************************/

//$text = "var a; begin a:=1; if a=1 then begin a := 1*2+3*4; end; end. ";
//$text = "var a; begin a:=1; while a<3 do a:=a+1; end. ";
//$text = "var a; procedure pr; var b; begin a:=10; b:=20; end; begin a:=100; call pr; end. ";
//$text = "var a; procedure pr1; var b; procedure pr2; var c; begin c:=11; b:=22; a:=33; end; begin a:=10; b:=20; call pr2; end; begin a:=100; call pr1; end. ";
//$text = "var a; procedure pr1; var b; procedure pr2; var c; begin c:=11; b:=22; a:=33; if 1=2 then call pr1; end; begin a:=10; b:=20; call pr2; end; begin a:=100; call pr1; end. ";
?>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1250" />
<head>
<title>Pøekladaè PL/0 v PHP</title>
</head>
<body>
<link href="styl.css" type="text/css" rel="stylesheet">
<h1>Implementace pøekladaèe PL/0 v PHP</h1>
<b>Vypracoval Tomáš Rieger jako semestrální práci z pøedìmtu KIV/FJP vyuèovaném na ZÈU.</b><p>
<form action="http://www.kiv.zcu.cz/~lobaz/fjp/debug_PL0/index.php?action=Odeslat" method="post" name="action" target="_blank">

<textarea name="source" rows="30" cols="50">

<?php
/* PS: Opravena podmínka. */
if (!isset($text) || strlen($text) == 0)
{
	echo "CHYBA - neni co prekladat!";
	konec();
}
else
{
	
        $text = $text." ";

	for ($i = 0; $i < CXMAX +1; $i++)
	{
		$code[$i] = new INSTRUCTION();
	}


	for($i = 0; $i < 255; $i++)
	{
		$ssym[$i] = null;
	}




	for ($i = 0; $i < TMAX+1; $i++) {
		$TABLE[$i] = new PrvekTabulky();
	}

	
	for($ch=32; $ch <= 95; $ch++)
		$ssym[$ch] = null; 
		
	$ssym[43] = Kplus;
    $ssym[45] = Kminus;
    $ssym[42] = Ktimes;
    $ssym[47] = Kslash;
    $ssym[37] = Kmodulo;
    $ssym[40] = Klparen;
    $ssym[41] = Krparen;
    $ssym[61] = Keql;
    $ssym[44] = Kcomma;
    $ssym[46] = Kperiod;
    $ssym[35] = Kneq;
    $ssym[60] = Klss;
    $ssym[62] = Kgtr;
    $ssym[59] = Ksemicolon;

	for($i = 0; $i < NSYM; $i++)
	{
		$declbegsys[$i] = 0;
	}
	
		for($i = 0; $i < NSYM; $i++)
	{
		$statbegsys[$i] = 0;
	}

		for($i = 0; $i < NSYM; $i++)
	{
		$facbegsys[$i] = 0;
	}
	
	$word = array("begin", "call", "const", "do", "end", "if", "odd", "procedure", "then", "var", "while");
	$wsym[0] = Kbeginsym;
	$wsym[1] = Kcallsym;
	$wsym[2] = Kconstsym;
	$wsym[3] = Kdosym;
	$wsym[4] = Kendsym;
	$wsym[5] = Kifsym;
	$wsym[6] = Koddsym;
	$wsym[7] = Kprocsym;
	$wsym[8] = Kthensym;
	$wsym[9] = Kvarsym;
	$wsym[10] = Kwhilesym;

        /* PS: oprava komentáøe, který patrnì prošel automatickou náhradou textu */
	/*v deklaracni casti se musi zacinat bud 'const', 'var' nebo 'procedure'*/
   $declbegsys[Kconstsym] = $declbegsys[Kvarsym] = $declbegsys[Kprocsym] = 1;

    /*ve statementu se musi zacinat bud 'begin','call','if','while' nebo ident.*/
    $statbegsys[Kbeginsym] = $statbegsys[Kcallsym] = $statbegsys[Kifsym] = $statbegsys[Kwhilesym] = 1;

    /*faktor muze byt bud ident., cislo nebo leva zavorka*/
    $facbegsys[Kident] = $facbegsys[Knumber] = $facbegsys[Klparen] = 1;
    
    $err = $cc = $cx = $ll = 0;
    $ch = ' ';
    $kk = AL;
/* PS: Poèítání èísla øádky. */
    $lineno = 1;

    getsym();
    
    $pom = nuluj();
    
    sjednot($pom,$declbegsys);
    sjednot($pom,$statbegsys);
    
    $pom[Kperiod] = 1;
    
    block(0,0,$pom);
    
    if($sym != Kperiod)
    {
    	error(9);
    }
    listcode();
    
}
?>
</textarea><p>
Stisknutím tlaèítka Debugger se otevøe nové okno s online debuggerem PL/0.<p>
<input type="submit" action="http://www.kiv.zcu.cz/~lobaz/fjp/debug_PL0/index.php?action=Odeslat" value="Debugger">
</form>
</body>
</html>

<?php

function konec()
{
?>
</textarea>
</form>
</body>
</html>

<?php
exit();
}
?>
