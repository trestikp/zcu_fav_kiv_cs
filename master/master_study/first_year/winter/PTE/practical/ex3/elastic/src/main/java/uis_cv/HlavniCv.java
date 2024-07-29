package uis_cv;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.elasticsearch.client.Request;
import org.elasticsearch.client.Response;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import uis_cv.data.LogFile;
import uis_cv.data.Record;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.List;

public class HlavniCv {
  public static final String USER = "elastic";
  public static final String PSSWD = "kivpte";
  public static final String END_POINT = "/uiscv/_create/";

  public static final String LOG_FILE = "PTE-cv-UIS-test-results-log.txt";
  public static final String JSON_FILE = "PTE-cv-UIS-test-results-log.json";

  public static void main(String[] args) throws Exception {
    List<Record> records = LogFile.getRecords(LOG_FILE);
    writeToElastic(records);
//    writeToJsonFile(records);
  }

  static void writeToElastic(List<Record> records) throws Exception {
    RestClient restClient = createLowLevelClient(USER, PSSWD);

    for (Record rec : records) {
      String idForElastic = LogFile.getId(rec.getTimestamp());
      String endPoint = END_POINT + idForElastic;
      Request request = new Request("POST", endPoint);
      String requestBody = rec.toJsonString();
      request.setJsonEntity(requestBody);
      Response response = restClient.performRequest(request);
      if (response.hasWarnings() == true) {
        System.err.println(response);
      }
    }

    restClient.close();
  }

  static void writeToJsonFile(List<Record> records) throws Exception {
    PrintWriter pw = new PrintWriter(
                     new BufferedWriter(
                     new FileWriter(
                     new File(JSON_FILE) ) ) );
    pw.println("{\n  \"records\":[");
    for (int i = 0; i < records.size() - 1; i++) {
      Record rec = records.get(i);
      pw.println("    " + rec.toJsonString() + " ,");
    }
    pw.println("    " + records.get(records.size() - 1).toJsonString());
    pw.println("  ]\n}");
    pw.close();
  }

  static RestClient createLowLevelClient(String user, String psswd) {
    CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
    credentialsProvider.setCredentials(AuthScope.ANY,
            new UsernamePasswordCredentials(user, psswd));

    RestClientBuilder builder = RestClient.builder(
                    new HttpHost("localhost", 9200, "https"))
            .setHttpClientConfigCallback(new RestClientBuilder.HttpClientConfigCallback() {
              @Override
              public HttpAsyncClientBuilder customizeHttpClient(
                      HttpAsyncClientBuilder httpClientBuilder) {
                return httpClientBuilder
                        .setDefaultCredentialsProvider(credentialsProvider);
              }
            });

    return builder.build();
  }
}
