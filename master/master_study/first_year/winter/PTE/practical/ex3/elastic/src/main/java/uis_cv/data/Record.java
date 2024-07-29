package uis_cv.data;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Record {

  private String timestamp;
  private String tsName;
  private String tsDesc;
  private String tcName;
  private String tcDesc;
  private String tempName;
  private String tempDesc;
  private String duration;
  private String result;
  private String severity;
  private String testGroup;
  private String testSubgroup;
  private String testType;
  private String errorMessage;

  public Record() {
    this.duration = "\"duration\":0";
    this.result = "\"result\":\"fail\"";
    this.errorMessage = "\"errorMessage\":\"\"";
    this.testSubgroup = "\"testSubgroup\":\"\"";
  }

  private String getElement(String radka, String element) {
    int z = radka.indexOf(element);
    int k = radka.indexOf("\"", z + element.length() + 3);
    if (k >= 0) {
      return radka.substring(z - 1, k + 1);
    } else {
      return radka.substring(z - 1);
    }
  }

  public String getTimestamp() {
    int z = timestamp.indexOf(":") + 2;
    int k = timestamp.length() - 1;
    String ts = timestamp.substring(z, k);
    return ts;
  }

  public void setTsName(String radka) {
    this.tsName = getElement(radka, "suiteName");
  }

  public void setTsDesc(String radka) {
    this.tsDesc = getElement(radka, "suiteDescription");
  }

  public void setTcName(String radka) {
    this.tcName = getElement(radka, "testName");
  }

  public void setTcDesc(String radka) {
    this.tcDesc = getElement(radka, "testDescription");
  }

  public void setTempName(String radka) {
    this.tempName = getElement(radka, "templateName");
  }

  public void setTempDesc(String radka) {
    this.tempDesc = getElement(radka, "templateDescription");
  }

  public void setTimestamp(String radka) {
    this.timestamp = getElement(radka, "time");
    this.timestamp = this.timestamp.replace("time", "timestamp");
    this.timestamp = this.timestamp.replace("__", "T");
    int k = this.timestamp.lastIndexOf("\"");
    this.timestamp = this.timestamp.substring(0, k) + "+02:00\"";
  }

  public void setDuration(String radka) {
    this.duration = getElement(radka, "duration");
    this.duration = this.duration.replace(":\"", ":");
    this.duration = this.duration.substring(0, this.duration.length() - 1);
  }

  public void setResult(String radka) {
    this.result = getElement(radka, "result");
  }

  public void setSeverity(String radka) {
    Set<String> tagy = getTagy(radka);
    String hodnota = "";
    if (tagy.contains("CRITICAL")) {
      hodnota = "critical";
    }
    if (tagy.contains("MAJOR")) {
      hodnota = "major";
    }
    if (tagy.contains("MINOR")) {
      hodnota = "minor";
    }
    this.severity = "\"severity\":\"" + hodnota + "\"";
  }

  public void setTestGroup(String radka) {
    Set<String> tagy = getTagy(radka);
    String hodnota = "";
    if (tagy.contains("PASSIVE") &&
            (tagy.contains("PAGE_CONTENT") || tagy.contains("MODAL_CONTENT") || tagy.contains("LINK")) ) {
      hodnota = "A:static content";
    }
    if (tagy.contains("PASSIVE") &&
            (tagy.contains("DB_PAGE_CONTENT") || tagy.contains("DB_MODAL_CONTENT")) ) {
      hodnota = "B:DB content";
    }
    if (tagy.contains("ONE_CHANGE")) {
      hodnota = "C:single change";
    }
    if (tagy.contains("NEGATIVE")) {
      hodnota = "D:negative";
    }
    this.testGroup = "\"testGroup\":\"" + hodnota + "\"";
  }

  public void setTestSubgroup(String radka) {
    Set<String> tagy = getTagy(radka);
    String hodnota = "";
    if (tagy.contains("PAGE_CONTENT")) {
      hodnota = "page_content";
    }
    if (tagy.contains("MODAL_CONTENT")) {
      hodnota = "modal_content";
    }
    if (tagy.contains("LINK")) {
      hodnota = "link";
    }
    if (tagy.contains("DB_PAGE_CONTENT")) {
      hodnota = "DB_page_content";
    }
    if (tagy.contains("DB_MODAL_CONTENT")) {
      hodnota = "DB_modal_content";
    }
    if (tagy.contains("BOUNDARY")) {
      hodnota = "boundary";
    }
    this.testSubgroup = "\"testSubgroup\":\"" + hodnota + "\"";
  }

  public void setTestType(String radka) {
    Set<String> tagy = getTagy(radka);
    String hodnota = "standard";
    if (tagy.contains("TEMPLATE")) {
      hodnota = "template";
    }
    else if (tagy.contains("PARAMETERIZED")) {
      hodnota = "parameterized";
    }
    this.testType = "\"testType\":\"" + hodnota + "\"";
  }

  public void setErrorMessage(String radka) {
    int z = radka.indexOf("UIS_ERR:");
    String hodnota = radka.substring(z + "UIS_ERR:".length()).trim();
    this.errorMessage = "\"errorMessage\":\"" + hodnota + "\"";
  }

  private Set<String> getTagy(String radka) {
    int z = radka.indexOf("[");
    int k = radka.indexOf("]");
    String[] tagy = radka.substring(z + 1, k).split(", ");
    return new HashSet<>(Arrays.asList(tagy));
  }

  @Override
  public String toString() {
    return "{" + "\n" +
            timestamp + ",\n" +
            tsName + ",\n" +
            tsDesc + ",\n" +
            tcName + ",\n" +
            tcDesc + ",\n" +
            tempName + ",\n" +
            tempDesc + ",\n" +
            duration + ",\n" +
            result + ",\n" +
            severity + ",\n" +
            testGroup + ",\n" +
            testSubgroup + ",\n" +
            testType + ",\n" +
            errorMessage + "\n" +
    "}";
  }

  public String toJsonString() {
    String str = this.toString();
    str = str.replace("\n", " ");
    return str;
  }

}
