package elastic;

public class TestResultLog {
  private String timestamp;
  private String url;
  private String browser;
  private String testName;
  private boolean testResult;
  private int durationMSec;
  private boolean durationPassed;

  public void setTimestamp(String timestamp) {
    this.timestamp = timestamp;
  }

  public String getTimestamp() {
    return this.timestamp;
  }

  public void setUrl(String url) {
    this.url = url;
  }

  public void setBrowser(String browser) {
    this.browser = browser;
  }

  public void setTestName(String testName) {
    this.testName = testName;
  }

  public void setTestResult(boolean testResult) {
    this.testResult = testResult;
  }

  public void setDurationMSec(int durationMSec) {
    this.durationMSec = durationMSec;
  }

  public void setDurationPassed(boolean durationPassed) {
    this.durationPassed = durationPassed;
  }

  public String toJsonString() {
    return "{" +
            "\"timestamp\":\"" + timestamp + "\"," +
            "\"url\":\"" + url + "\"," +
            "\"browser\":\"" + browser + "\"," +
            "\"testName\":\"" + testName + "\"," +
            "\"testResult\":\"" + testResult + "\"," +
            "\"durationMSec\":\"" + durationMSec + "\"," +
            "\"durationPassed\":\"" + durationPassed + "\"" +
            "}";
  }
}
