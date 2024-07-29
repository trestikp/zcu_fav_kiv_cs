package support;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.opera.OperaDriver;
import org.openqa.selenium.opera.OperaOptions;

public class Drivers {
  public enum Browsers {
    CHROME, OPERA, FIREFOX, EDGE;
  }

  private static WebDriver driver;

  public static WebDriver getDriver() {
    return driver;
  }

  private static WebDriver setChromeDriver() {
    System.setProperty("webdriver.chrome.driver", Const.CHROME_DRIVER_URI);
    return new ChromeDriver();
  }


  private static WebDriver setFirefoxDriver() {
    System.setProperty("webdriver.gecko.driver", Const.FIREFOX_DRIVER_URI);
    return new FirefoxDriver();
  }

  private static WebDriver setOperaDriver() {
    System.setProperty("webdriver.opera.driver", Const.OPERA_DRIVER_URI);
    OperaOptions options = new OperaOptions();
    return new OperaDriver(options);
  }

  private static WebDriver setEdgeDriver() {
    System.setProperty("webdriver.edge.driver", Const.EDGE_DRIVER_URI);
    return new EdgeDriver();
  }


  public static void setWebDriver() {
    switch (Const.WEB_BROWSER_TYPE) {
      case CHROME :
        driver = Drivers.setChromeDriver();
        break;

      case OPERA :
        driver = Drivers.setOperaDriver();
        break;

      case FIREFOX :
        driver = Drivers.setFirefoxDriver();
        break;

      case EDGE :
        driver = Drivers.setEdgeDriver();
        break;

      default:
        throw new UnsupportedOperationException("No such browser!");
    }
  }
}
