package elastic;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class GenerateResults {
  private static final String URL_KIV = "https://www.kiv.zcu.cz/";
  private static final String URL_FAV = "https://www.fav.zcu.cz/";

  enum Browser {
    chrome, firefox, opera, edge;
  }

  enum Name {
    login, find, book;
  }

  static Random r = new Random(1L);

  public static String getId(String timestamp) {
    LocalDateTime z = LocalDateTime.of(2000, 1, 1, 0, 0);
    LocalDateTime ldt = LocalDateTime.parse(timestamp);
    Duration d = Duration.between(z, ldt);
    return "" + d.toMillis();
  }

  public static List<TestResultLog> generate(int number) {
    List<TestResultLog> seznam = new ArrayList<>();
    LocalDate ld = LocalDate.now();
    LocalTime lt = LocalTime.MIDNIGHT;
    LocalDateTime ldt = LocalDateTime.of(ld, lt);
    ldt = ldt.minusHours(2); // posun proti CET
    long stepMin = 24 * 60 / (number + 1);
    for (int i = 0; i < number; i++) {
      TestResultLog vt = new TestResultLog();
      ldt = ldt.plusMinutes(stepMin);
      vt.setTimestamp(ldt.format(DateTimeFormatter.ISO_DATE_TIME));
      String url = (r.nextBoolean()) ? URL_KIV : URL_FAV;
      vt.setUrl(url);
      int k = r.nextInt(4);
      vt.setBrowser(Browser.values()[k].name());
      k = r.nextInt(3);
      vt.setTestName(Name.values()[k].name());
      vt.setTestResult(r.nextBoolean());
      int d = r.nextInt(10000) + 3000;
      vt.setDurationMSec(d);
      vt.setDurationPassed(r.nextBoolean());
      seznam.add(vt);
    }
    return seznam;
  }
}
