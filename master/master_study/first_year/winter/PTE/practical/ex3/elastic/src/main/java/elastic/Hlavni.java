package elastic;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.nio.client.HttpAsyncClientBuilder;
import org.elasticsearch.client.*;

import java.util.List;

public class Hlavni {
  public static final String USER = "elastic";
  public static final String PSSWD = "kivpte";
  public static final String END_POINT = "/testviz/_create/";

  public static void main(String[] args) throws Exception {
    RestClient restClient = createLowLevelClient(USER, PSSWD);

    List<TestResultLog> results = GenerateResults.generate(200);
    for (TestResultLog trl : results) {
      String idForElastic = GenerateResults.getId(trl.getTimestamp());
      String endPoint = END_POINT + idForElastic;
      Request request = new Request("POST", endPoint);
      String requestBody = trl.toJsonString();
      request.setJsonEntity(requestBody);
      Response response = restClient.performRequest(request);
      if (response.hasWarnings() == true) {
        System.err.println(response);
      }
    }

    restClient.close();
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
