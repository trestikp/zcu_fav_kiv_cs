# PIA-E projekt - bikesharing

## Spuštění projektu

* spuštění je automatizováno a zjednodušeno použitím nástroje **docker** (docker-compose) (resp. **podman** alternativy)
* k buildu a spuštění aplikace stačí v kořenu projektu (kde je soubor `docker-compose.yml`) pustit tento příkaz
```
docker-compose up --build
```

* případně použít `-d` parametr pro spuštění v pozadí
* ukončení aplikace je možné pomocí příkazu
```
docker-compose down
```

* build je v rámci jednotek minut
* nastartování aplikace trvá destíky vteřin až cca minutu, aplikace není plně funkční dokud všechny části nenastratujou
* spuštěná aplikace je přístupná na http://localhost:4200 (pokud je použita výchozí konfigurace)

### Konfigurace buildu a aplikace

* konfigurace buildu je v souboru `docker-compose.yml`
    * např. porty spuštěných aplikací
    * **UPOZORNĚNÍ**: doporučuji zachovat minimálně port frontendu (**4200**), protože aplikace podporuje přihlášení
      přes GitHub OAuth2, který ale vyžaduje nastavení callback URL, která je nastavená na "http://localhost:4200"
        * Toto je samozřejmě možné také nastavit v konfiguračních sobourech, ale bude třeba použít jinou GitHub
          autorizační aplikaci, protože pokud se callback URL neshoduje, tak GitHub jakýkoliv request zamítne -> přihlášení přes GitHub nebude fungovat
* konfigurační soubory aplikací:
    * `frontend/src/environments/environment.ts` - konfigurace vývojářeského prostředí frontendu
    * `frontend/src/environments/environment.prod.ts` - konfigurace produkčního prostředí frontendu (použito v dockeru)
    * `backend/src/main/resources/application.properties` - konfigurace backendu
    * `backend/src/main/resources/application.yaml` - konfigurace backendu (má prioritu proti `application.properties`)

## Použití

* poskytnuti 2 testovací uživatelé
    * username: test (REGULAR), test2 (SERVICEMA)
    * password: test123 (stejné pro oba)
* "About" - přibližně podobný návod použití jako tuto (+obrázky)
* navbar - navigace + tlačítka pro přihlášení, registrace, odhlášení
* hlavní stránka ("Bikesharing") - zobrazuje mapu
    * na této mapě jsou vidět standy (pro všechny) a jízdy jiných uživatelů (pouze pozorování je pro všechny)
    * přihlašený uživatel nad mapou vidí řádku pro pro započetí jízdy
    * jízda se provádí automaticky. Naplánuje se cesta a client po cestě automaticky "jede" markerem. Jízda je také zakončené automaticky.
    * jízda uživatele je zelený marker kola
    * ostatní uživatelé mohou vidět zrovna probíhající jízdu jako šedý marker kola
    * je vhodné spustit 2 okna s aplikací, aby bylo možné vidět jízdu z pohledu pozorovatele a z pohledu uživatele
* "Past rides" - zobrazuje seznam minulých jízd uživatele
* "Due for service" - zobrazuje seznam kol, která jsou potřeba servisovat
    * pouze pokud je uživatel SERVICEMAN

## Architektura letem světem
* backend - monolit (jeden modul), 3 vrstvy (data, business (logic), presentation), oddělený od UI (frontend)
    * Spring Boot 3, Java 17, Maven, Flyway, MySQL, knihovny 3tích stran  
* frontend - generovaná struktura Angularem, ale přibližně odděluje vrstvy na view, service, model
    * Angular 17, rozšíření Angularu (Material pro tabulky), Leaflet - mapy, knihovny rozšiřující Leaflet

## Kde najít zajímavou část implemntace
* jízda je simulovaná klientem pomocí leaflet.animatedmarker knihovny. Ta jede po "polyline", kterou je vykreslená cesta.
* takto aktivní jízda je sledována intervalem (který je možný nastavit) a v každé iteraci je přes WebSocket aktualizována
  pozice kola
* Aktualizace pozice kola vyvolá poslání zprávy z backendu na ActiveMQ topic, který subscribuje klient

## FAQ (potíže)
* při buildu se v jedné konkrétní síti stane, že build se zasekne na "npm install" a vezme sebou celou síť
    * toto je možné obejít zavoláním **npm install** v **bikeshare-ui** před spuštěním buildu
    * na jiných 2 sítích build funguje bez problému. Asi problém konkrétní sitě?
* mapa může mít šedé obdelníčky po okrajích, protože se špatně načítá (zřejmě "vlastnot" leafletu a OpenStreeMap)
* při přerušení spojení, obnovení stránky nebo podobné akce při probíhající jízdě je jízda přerušena
    * přeruší se simulace, kterou simuluje klient
    * jízda tím pádem zůstane "viset" a uživatel nemůže začít další jízdu
    * toto je považováno za validní stav "uživatel nedokončil jízdu", proto to není automaticky opravováno např. při requestu o započetí nové jízdy
    * v konfiguračním souboru klienta je možné zapnout flagu, která dovolí "admin" obrazovku s tlačítkem, který všechny jízdy dokončí, což odblokuje uživatele
        * tato funkčnost je hlavně pro pohodlnější testování