package cz.pte;

import cz.pte.soaptest.Record;
import cz.pte.soaptest.RunSoapTests;
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
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static final String USER = "elastic";
    public static final String PSSWD = "kivpte";
    public static final String END_POINT = "/restapi/_create/";

    public static void main(String[] args) {
        // create soap_res dir if it doesn't exist
        if (!createSoapRes())
            return;

        // clear previous run results
        wipeSoapRes();

        System.out.println("Program will now start running tests and upload them to ES. This may take 1-2 minutes" +
                " (tests are run 1 by 1 making the run long, but it allows for more useful data)");

        List<Record> allRecords = new ArrayList<>();

        // run tests five times to have more data for visualization
        for (int i = 0; i < 5; i++) {
            // runs tests one by one - this takes 5-10x longer than running all at once, but gives more detailed results
            var records = RunSoapTests.runTests();
            if (records == null || records.size() <= 0) {
                System.err.println("Failed to run SoapUI tests.");
                return;
            }

            // loaded results have timestamp in format 'yyyy-MM-dd HH:mm:ss', this converts it to ISO-8601
            records.forEach(Record::fixTimestampFormat);

            // put records together to 1 collection
            allRecords.addAll(records);
        }

        // finally write data to elasticsearch
        try {
            writeToElastic(allRecords);
        } catch (Exception ex) {
            System.err.println("Failed to write records to elastic!");
            ex.printStackTrace();
        }
    }

    static boolean deleteDirectory(File directoryToBeDeleted) {
        File[] allContents = directoryToBeDeleted.listFiles();
        if (allContents != null) {
            for (File file : allContents) {
                deleteDirectory(file);
            }
        }
        return directoryToBeDeleted.delete();
    }

    static boolean createSoapRes() {
        try {
            Files.createDirectories(Paths.get("soap_res"));
            return true;
        } catch (IOException e) {
            System.out.println("Failed to create soap_res dir.");
            return false;
        }
    }
    static void wipeSoapRes() {
        File f = new File("soap_res");
        if (f.listFiles() != null && f.listFiles().length > 0)
            Arrays.stream(f.listFiles()).forEach(sub -> {
                if (sub.isDirectory())
                    deleteDirectory(sub);
                else
                    sub.delete();
            });
    }


    static void writeToElastic(List<cz.pte.soaptest.Record> records) throws Exception {
        RestClient restClient = createLowLevelClient(USER, PSSWD);

        for (var rec : records) {
            String idForElastic = rec.getElasticID();
            String endPoint = END_POINT + idForElastic;
            Request request = new Request("POST", endPoint);
            String requestBody = rec.toJSONObjectString();
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
