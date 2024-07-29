package cz.pte.data;

import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;
import cz.pte.benchmarks.SortingBenchmark;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.results.format.ResultFormatType;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class DataCollector {
    public static List<Record> runThroughputBenchmark() {
        Options opt = new OptionsBuilder()
                .include(SortingBenchmark.class.getSimpleName())
                .mode(Mode.Throughput)
                .timeUnit(TimeUnit.SECONDS)
                .resultFormat(ResultFormatType.JSON)
//                .output("sorting_throughput.txt")
                .build();

        return runBenchmark(opt);
    }

    public static List<Record> runAverageTimeBenchmark() {
        Options opt = new OptionsBuilder()
                .include(SortingBenchmark.class.getSimpleName())
                .mode(Mode.AverageTime)
                .timeUnit(TimeUnit.NANOSECONDS)
                .resultFormat(ResultFormatType.JSON)
//                .output("sorting_avg_time.txt")
                .build();

        return runBenchmark(opt);
    }

    private static List<Record> runBenchmark(Options opt) {
        List<Record> records = new ArrayList<>();

        try {
            new Runner(opt).run();

            ObjectMapper mapper = new ObjectMapper();
            records = Arrays.asList(mapper.readValue(new File("jmh-result.json"), Record[].class));
            for (Record r : records) {
                r.postProcess();
            }
        } catch (RunnerException ex) {
            System.err.println("Failed to execute throughput test.");
            ex.printStackTrace();
        } catch (DatabindException | StreamReadException ex) {
            System.err.println("Failed parse JSON.");
            ex.printStackTrace();
        } catch (IOException ex) {
            System.err.println("Failed to open JSON");
            ex.printStackTrace();
        }

        return records;
    }
}
