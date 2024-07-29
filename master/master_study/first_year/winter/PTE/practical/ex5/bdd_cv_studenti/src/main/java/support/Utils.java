package support;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.Wait;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.List;
import java.util.Map;

public class Utils {
  private static Wait<WebDriver> wait;

  static {
    setWait();
  }

  public static final String CELKOVA_CHYBA = "Chybné vstupy - opravte prosím zvýrazněné položky";

  private static final Map<String, String> NAZVY_VYBERU_FAKULTA = Map.of(
          "N", " --- neuvedeno ---",
          "FAV", "FAV - Fakulta aplikovaných věd",
          "FDU", "FDU - Fakulta designu a umění Ladislava Sutnara",
          "FEK", "FEK - Fakulta ekonomická",
          "FEL", "FEL - Fakulta elektrotechnická",
          "FF", "FF - Fakulta filosofická",
          "FPE", "FPE - Fakulta pedagogická",
          "FPR", "FPR - Fakulta právnická",
          "FST", "FST - Fakulta strojní",
          "FZS", "FZS - Fakulta zdravotnických studií"
  );

  // Typ studia
  public static final String TYP_B = "bakalářský";
  public static final String TYP_N = "navazující";
  public static final String TYP_P = "doktorský";
  public static final String TYP_M = "magisterský";

  // Forma studia
  private static final Map<String, String> FORMA_STUDIA = Map.of(
          "prezenční", "forma_prezencni",
          "distanční", "forma_distancni",
          "kombinovaná", "forma_kombinovana"
  );

  /**
   * Otevreni stranky Generovani a cekani na zobrazeni
   */
  public static void otevriStranku() {
    Drivers.getDriver().get(Const.URL);
    wait.until(ExpectedConditions.urlToBe(Const.URL));
  }

  /**
   * Nastaveni fakulty ve vyberovem seznamu
   * pouzije se NAZVY_VYBERU_FAKULTA ze Settings
   *
   * @param zkratkaFakulty tripismenna zkratka fakulty nebo "FF"
   */
  public static void setFakulta(String zkratkaFakulty) {
    String fakulta = NAZVY_VYBERU_FAKULTA.get(zkratkaFakulty);
    WebElement seznam = Drivers.getDriver().findElement(By.id(Id.GEN_SELECT_FAKULTA));
    Select fakultaSelect = new Select(seznam);
    fakultaSelect.selectByVisibleText(fakulta);
  }

  /**
   * Nastaveni roku nastupu
   *
   * @param rok rok nastupu
   */
  public static void setRok(String rok) {
    WebElement rokInput = Drivers.getDriver().findElement(By.id(Id.GEN_INPUT_ROK));
    rokInput.clear();
    rokInput.sendKeys(rok);
  }

  /**
   * Nastaveni typu studia
   *
   * @param typ bude zadan pomoci konstant - TYP_B apod.
   */
  public static void setTyp(String typ) {
    WebElement seznam = Drivers.getDriver().findElement(By.id(Id.GEN_SELECT_TYP));
    Select typSelect = new Select(seznam);
    typSelect.selectByVisibleText(typ);
  }

  /**
   * Nastaveni poradoveho cisla
   *
   * @param poradi poradove cislo
   */
  public static void setPoradi(String poradi) {
    WebElement poradiInput = Drivers.getDriver().findElement(By.id(Id.GEN_INPUT_PORADI));
    poradiInput.clear();
    poradiInput.sendKeys(poradi);
  }

  /**
   * Nastaveni formy studia
   *
   * @param forma bude zadan pomoci konstant - FORMA_P apod.
   */
  public static void setForma(String forma) {
    String id = FORMA_STUDIA.get(forma);
    WebElement formaRB = Drivers.getDriver().findElement(By.id(id));
    if (formaRB.isSelected() == false) {
      formaRB.click();
    }
  }

  /**
   * Nastaveni / shozeni priznaku zahranicniho studenta
   *
   * @param zahr true - nastavit, false - shodit
   */
  public static void setZahranicni(boolean zahr) {
    WebElement chkb = Drivers.getDriver().findElement(By.id(Id.GEN_CHKBOX_ZAHR));
    if (chkb.isSelected() != zahr) {
      chkb.click();
    }
  }

  /**
   * Generovani vysledneho osobniho cisla tlacitkem Generovani
   */
  public static void stiskniTlacitkoGeneruj() {
    stiskniTlacitkoACekej(Id.GEN_BUTTON_GENEROVANI);
  }

  /**
   * Vrati vygenerovane osobni cislo
   *
   * @return vygenerovane osobni cislo nebo prazdny retezec pri chybe
   */
  public static String getVysledek() {
    if (isVysledekZobrazen() == true) {
      WebElement vystup = Drivers.getDriver().findElement(By.id(Id.GEN_TEXT_VYSLEDEK));
      return vystup.getText();
    }
    else {
      return "";
    }
  }

  /**
   * Vymazani celeho formulare tlacitkem Vymaz
   */
  public static void vymazFormular() {
    stiskniTlacitkoACekej(Id.GEN_BUTTON_MAZANI);
  }

  /**
   * Je zobrazena celkova chyba
   *
   * @return true - chyba je zobrazena, false - neni zobrazena
   */
  public static boolean isZobrazenaChyba() {
    List<WebElement> chyba = Drivers.getDriver().findElements(By.id(Id.GEN_CHYBA_CELKOVA));
    return (chyba.size() == 0) ? false : true;
  }

  /**
   * Vraci text celkove chyby
   *
   * @return text chyby - chyba je zobrazena, prazdny retezec - neni zobrazena
   */
  public static String textChyby() {
    List<WebElement> chyba = Drivers.getDriver().findElements(By.id(Id.GEN_CHYBA_CELKOVA));
    if (chyba.size() == 1) {
      return chyba.get(0).getText();
    }
    else {
      return "";
    }
  }

  public static String chybaVstupu(String idVstupu) {
    List<WebElement> chyba = Drivers.getDriver().findElements(By.id(idVstupu));
    if (chyba.size() == 1) {
      return chyba.get(0).getText();
    }
    else {
      return "";
    }
  }

  //////////////////////////////////////////////////
  /// interni metody
  //////////////////////////////////////////////////

  /**
   * Je zobrazeno generovane osobni cislo
   *
   * @return true - je zobrazeno, false - neni zobrazeno
   */
  private static boolean isVysledekZobrazen() {
    List<WebElement> vysledek = Drivers.getDriver().findElements(By.id(Id.GEN_TEXT_VYSLEDEK));
    return (vysledek.size() == 0) ? false : true;
  }

  /**
   * Je nastaven priznak zahranicniho studenta
   *
   * @return true - je nastaven, false - neni nastaven
   */
  private static boolean isZahranicni() {
    WebElement chkb = Drivers.getDriver().findElement(By.id(Id.GEN_CHKBOX_ZAHR));
    return chkb.isSelected();
  }

  /**
   * Setting of a 'normal' wait
   */
  public static void setWait() {
    wait = new WebDriverWait(Drivers.getDriver(), Duration.ofSeconds(Const.TIMEOUT));
  }

  /**
   * Klik na element a cekani na zobrazeni prislusne stranky
   *
   * @param element element, na ktery se klika
   * @param expectedURL URL pozadovane stranky
   */
  private static void clickAndWaitURL(WebElement element, String expectedURL) {
    element.click();
    wait.until(ExpectedConditions.urlToBe(expectedURL));
  }

  /**
   * Kliknuti na tlacitko a cekani na obnoveni stranky Generovani
   *
   * @param id ID tlacitka
   */
  private static void stiskniTlacitkoACekej(String id) {
    WebElement tlacitko = Drivers.getDriver().findElement(By.id(id));
    Utils.clickAndWaitURL(tlacitko, Const.URL);
  }

}
