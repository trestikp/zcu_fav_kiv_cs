package cz.pte;

import com.fasterxml.jackson.databind.ObjectMapper;
import cz.pte.data.DataCollector;
import cz.pte.data.Record;
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

import java.io.File;
import java.time.Duration;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static final String USER = "elastic";
    public static final String PSSWD = "kivpte";
    public static final String END_POINT = "/bench/_create/";

    public static void main(String[] args) {
        // runs the benchmark with Mode.Throughput
        var records_1 = DataCollector.runThroughputBenchmark();
        if (records_1 == null || records_1.isEmpty()) {
            System.err.println("Failed to run throughput benchmark.");
            return;
        }

        List<Record> allRecords = new ArrayList<>(records_1);

        // runs the benchmark with Mode.AverageTime
        var records_2 = DataCollector.runAverageTimeBenchmark();
        if (records_2 == null || records_2.isEmpty()) {
            System.err.println("Failed to run throughput benchmark.");
            return;
        }

        allRecords.addAll(records_2);

        // finally writes data to elasticsearch
        try {

            writeToElastic(allRecords);
            System.out.println("INFO: Finished uploading data to elastic.");
        } catch (Exception ex) {
            System.err.println("Failed to write records to elastic!");
            ex.printStackTrace();
        }

        // clean after myself - remove jmh-result.json
        File garbage = new File("jmh-result.json");
        if (garbage.exists())
            if (!garbage.delete())
                System.err.println("ERR: Failed to clean after myself.");
    }

    static void writeToElastic(List<cz.pte.data.Record> records) throws Exception {
        RestClient restClient = createLowLevelClient(USER, PSSWD);
        ObjectMapper mapper = new ObjectMapper();
        ZonedDateTime z = ZonedDateTime.of(2000, 1, 1, 0, 0, 0, 0, ZoneId.of("+01:00"));
        ZonedDateTime ldt = ZonedDateTime.now();
        // duration is used to seperate IDs of different test runs (time wise)
        Duration d = Duration.between(z, ldt);

        for (int i = 0; i < records.size(); i++) {
            // NOTE: id for elastic is some constant dependent on current time and then + index. This should hopefully
            // provide some order to the data, because JMH does NOT generate any timestamps
            Long fakeTimestamp = d.toMillis() + i;
            records.get(i).setFakeTimestamp(fakeTimestamp);
            String idForElastic = "" + fakeTimestamp;
            String endPoint = END_POINT + idForElastic;
            Request request = new Request("POST", endPoint);
            String requestBody = mapper.writeValueAsString(records.get(i));
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
