package uis_cv.data;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

public class LogFile {
  public static List<Record> getRecords(String logSoubor) {
    List<String> radky = nactiVstup(logSoubor);
    radky = odstranInfoRadky(radky);
    List<Record> records = zpracujZaznamy(radky);
//    System.out.println(records.size());
//    System.out.println("{\n" + records + "\n}\n");
    return records;
  }

  static List<String> nactiVstup(String logSoubor) {
    List<String> radky = null;
    try {
      radky = Files.readAllLines(Paths.get(logSoubor));
    } catch (IOException e) {
      e.printStackTrace();
    }
    return radky;
  }

  static List<String> odstranInfoRadky(List<String> radky) {
    List<String> nove = new ArrayList<>();
    for (String radka : radky) {
      if (radka.contains("===") == false) {
        nove.add(radka);
      }
    }
    return nove;
  }

  static List<Record> zpracujZaznamy(List<String> radky) {
    List<Record> zaznamy = new ArrayList<>();
    Record record = null;
    for (String radka : radky) {
      if (radka.contains("time\":")) {
        zaznamy.add(record);
        record = new Record();
        record.setTsName(radka);
        record.setTsDesc(radka);
        record.setTcName(radka);
        record.setTcDesc(radka);
        record.setTempName(radka);
        record.setTempDesc(radka);
        record.setTimestamp(radka);
        record.setSeverity(radka);
        record.setTestGroup(radka);
        record.setTestSubgroup(radka);
        record.setTestType(radka);
      } else if (radka.contains("result\":")) {
        record.setResult(radka);
        record.setDuration(radka);
      } else {
        record.setErrorMessage(radka);
      }
    }
    zaznamy.remove(0);
    zaznamy.add(record);
    return zaznamy;
  }

  public static String getId(String timestamp) {
    ZonedDateTime z = ZonedDateTime.of(2000, 1, 1, 0, 0, 0, 0, ZoneId.of("+02:00"));
    ZonedDateTime ldt = ZonedDateTime.parse(timestamp);
    Duration d = Duration.between(z, ldt);
    return "" + d.toMillis();
  }


}