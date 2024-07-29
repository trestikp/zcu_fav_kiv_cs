package support;

/**
 * Utility class
 *
 * @author Pavel Herout
 * @version 2022-08-23
 */

public class Const {
  public static final String BASE_URL = "http://oks.kiv.zcu.cz/OsobniCislo/";

  public static final String URL = BASE_URL + "Generovani";

  public static final int TIMEOUT = 5; // sec

  public static final Drivers.Browsers WEB_BROWSER_TYPE =
                                      Drivers.Browsers.FIREFOX;

  public static final String CHROME_DRIVER_URI =
          "C:/Program Files/Java/selenium/chromedriver-104.exe";

  public static final String OPERA_DRIVER_URI =
          "C:/Program Files/Java/selenium/operadriver-103.exe";

  public static final String FIREFOX_DRIVER_URI =
          "/home/cf/ZCU/PTE/practical/ex5/geckodriver/geckodriver";

  public static final String EDGE_DRIVER_URI =
          "C:/Program Files/Java/selenium/msedgedriver-101.exe";

}
