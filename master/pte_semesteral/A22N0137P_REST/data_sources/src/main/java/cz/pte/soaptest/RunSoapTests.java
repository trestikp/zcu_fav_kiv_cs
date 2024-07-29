package cz.pte.soaptest;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class RunSoapTests {
    // method for running all Test Suites and test cases in the project
    // renamed from getTestSuite - single running all tests to runTests
    public static List<Record> runTests() {
        List<Record> records = new ArrayList<>();

        // unsorted run "head"
//        Constants.testMap.forEach((k, v) -> {
//            for (String testCase : v) {

        // running tests sorted by test suite and then test case because some test cases might depend on previous TCs
        Constants.testMap.keySet().stream().sorted().forEach(k -> {
            Arrays.stream(Constants.testMap.get(k)).sorted().forEach(testCase -> {
                try {
                    String cmd = Constants.CURRENT_DIR + File.separator + Constants.RUN_SOAPUI_SCRIPT;

                    ProcessBuilder pb = new ProcessBuilder(cmd, testCase);
                    Process process = pb.start();

                    StringBuilder output = new StringBuilder();
                    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

                    String line;
                    while ((line = reader.readLine()) != null) {
                        output.append(line + "\n");
                    }

                    int exitVal = process.waitFor();
                    if (exitVal == 0) {
                        System.out.println("Finished running: " + k + " - " + testCase);
//                        System.out.println(output.toString());

                        var caseRecords = DataCollector.loadTestCaseRunLogReportXML();
                        caseRecords.forEach(record -> {
                            record.setProperty("testSuite", k);
                            record.setProperty("testCase", testCase);
                        });
                        records.addAll(caseRecords);

                    } else {
                        System.err.println("Failed to execute test case. Is run_soapui.sh correct?");
//                        System.out.println(output.toString());
                    }
                } catch (IOException | InterruptedException e) {
                    e.printStackTrace();
                }
            });
        });

        return records;

        // following code is running all test at once (requires run_soapui.sh modification)
        // while it is much faster to run all tests at once
        // for more run information it is necessary to run them one by one (or get "pro" soapUI version)

//        try {
//            Process process = Runtime.getRuntime().exec(Constants.CURRENT_DIR + File.separator +
//                                                        Constants.RUN_SOAPUI_SCRIPT);
//
//            StringBuilder output = new StringBuilder();
//            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
//
//            String line;
//            while ((line = reader.readLine()) != null) {
//                output.append(line + "\n");
//            }
//
//            int exitVal = process.waitFor();
//            if (exitVal == 0) {
//                return output.toString();
//            }
//        } catch (IOException | InterruptedException e) {
//            e.printStackTrace();
//        }
//
//        return null;
    }
}
