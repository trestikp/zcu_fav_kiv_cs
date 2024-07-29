Tomáš Linhart - A22N0055P

Spuštěním souboru compile.sh dojde k přeložení a spuštění Flex souboru.
Tento program slouží k odstranění řádkových a obecných komentářů.

Řádkové komentáře, které začínají v obecném komentáři jsou ignorovány.

Pokud se uživatel pokusí uzavřít již uzavřený komentář, pak je tento znak přepsán jako klasický text 
například -> /* test */ text */ komentar 
se přepíše na -> text */ komentar