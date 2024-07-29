package cz.pte.data;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.*;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Record {
    String benchmark;
    String mode;
    int warmupIterations;
    String warmupTime;
    int warmupBatchSize;
    int measurementIterations;
    String measurementTime;
    int measurementBatchSize;
    Map<String, String> params;

    //// Metrics that are deserialized in a method
    Double score;
    Double scoreError;
//    Double[] scoreConfidence;
    List<Double> scoreConfidence;
    Map<String, Double> scorePercentiles;
    String scoreUnit;
    @JsonIgnore
    List<List<Double>> rawData;

    //// post processing properties
    String benchmarkClass;
    String benchmarkType;
    String benchmarkMethod;
    String size;
    List<Double> rawDataSimple;
    @JsonProperty("0.0")
    Double percentile_00_0;
    @JsonProperty("50.0")
    Double percentile_50_0;
    @JsonProperty("90.0")
    Double percentile_90_0;
    @JsonProperty("95.0")
    Double percentile_95_0;
    @JsonProperty("99.0")
    Double percentile_99_0;
    @JsonProperty("99.9")
    Double percentile_99_9;
    @JsonProperty("99.99")
    Double percentile_99_99;
    @JsonProperty("99.999")
    Double percentile_99_999;
    @JsonProperty("99.9999")
    Double percentile_99_9999;
    @JsonProperty("100.0")
    Double percentile_100_0;

    Long fakeTimestamp;


    public Record() {
    }

    @JsonProperty("primaryMetric")
    public void unpackMetrics(Map<String, Object> metrics) {
        this.score = (Double) metrics.get("score");
        this.scoreError = (Double) metrics.get("scoreError");
        this.scoreUnit = (String) metrics.get("scoreUnit");
        this.scoreConfidence = (ArrayList<Double>) metrics.get("scoreConfidence");
        this.scorePercentiles = (LinkedHashMap<String, Double>) metrics.get("scorePercentiles");
        this.rawData = (List<List<Double>>) metrics.get("rawData");
    }

    public void postProcess() {
        // size parameter
        if (params != null && params.containsKey("SIZE"))
            this.size = params.get("SIZE");

        // simplify raw data
        rawDataSimple = new ArrayList<>();
        rawData.forEach(innerList -> rawDataSimple.addAll(innerList));

        // extract percentiles
        if (scorePercentiles != null) {
            if (scorePercentiles.containsKey("0.0"))
                this.percentile_00_0 = scorePercentiles.get("0.0");
            if (scorePercentiles.containsKey("50.0"))
                this.percentile_50_0 = scorePercentiles.get("50.0");
            if (scorePercentiles.containsKey("90.0"))
                this.percentile_90_0 = scorePercentiles.get("90.0");
            if (scorePercentiles.containsKey("95.0"))
                this.percentile_95_0 = scorePercentiles.get("95.0");
            if (scorePercentiles.containsKey("99.0"))
                this.percentile_99_0 = scorePercentiles.get("99.0");
            if (scorePercentiles.containsKey("99.9"))
                this.percentile_99_9 = scorePercentiles.get("99.9");
            if (scorePercentiles.containsKey("99.99"))
                this.percentile_99_99 = scorePercentiles.get("99.99");
            if (scorePercentiles.containsKey("99.999"))
                this.percentile_99_999 = scorePercentiles.get("99.999");
            if (scorePercentiles.containsKey("99.9999"))
                this.percentile_99_9999 = scorePercentiles.get("99.9999");
            if (scorePercentiles.containsKey("100.0"))
                this.percentile_100_0 = scorePercentiles.get("100.0");
        }

        // benchmark information
        if (this.benchmark == null || this.benchmark.isBlank())
            return;

        String[] parts = this.benchmark.split("\\.");
        if (parts.length < 3) {
            System.err.println("Not enough parts to determine benchmark properties");
            return;
        }

        // TODO: this isn't very robust. Works for tests currently in the project
        this.benchmarkMethod    = parts[parts.length - 1];
        this.benchmarkType      = parts[parts.length - 2];
        this.benchmarkClass     = parts[parts.length - 3];
    }

    // unused, but kept just for sure ;)
//    public String getElasticID() {
//        Long id = 0L;
//
//        ZonedDateTime z = ZonedDateTime.of(2000, 1, 1, 0, 0, 0, 0, ZoneId.of("+01:00"));
//        ZonedDateTime ldt = ZonedDateTime.now();
//        // duration is used to seperate IDs of different test runs (time wise)
//        Duration d = Duration.between(z, ldt);
//
//        id += d.toMillis(); // due to second precision need another determining parameters
//
//        // do black magic to generate hopefully unique ID
//        id += this.score.longValue();
//        id += blackMagic(this.score);
//        id += percentile_50_0.longValue();
//        id += blackMagic(this.percentile_00_0);
//
//        return "" + id;
//    }
//
//    private Long blackMagic(Double num) {
//        String numberStr = Double.toString(num);
//        String fractionalStr = numberStr.substring(numberStr.indexOf('.')+1);
//        try {
//            return Long.valueOf(fractionalStr);
//        } catch (NumberFormatException ex) {
//            // added try because double can be in format 1.11E7, which crashes on 'E'
//            Random rng = new Random();
//            return rng.nextLong();
//        }
//    }

    public String getBenchmark() {
        return benchmark;
    }

    public void setBenchmark(String benchmark) {
        this.benchmark = benchmark;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public int getWarmupIterations() {
        return warmupIterations;
    }

    public void setWarmupIterations(int warmupIterations) {
        this.warmupIterations = warmupIterations;
    }

    public String getWarmupTime() {
        return warmupTime;
    }

    public void setWarmupTime(String warmupTime) {
        this.warmupTime = warmupTime;
    }

    public int getWarmupBatchSize() {
        return warmupBatchSize;
    }

    public void setWarmupBatchSize(int warmupBatchSize) {
        this.warmupBatchSize = warmupBatchSize;
    }

    public int getMeasurementIterations() {
        return measurementIterations;
    }

    public void setMeasurementIterations(int measurementIterations) {
        this.measurementIterations = measurementIterations;
    }

    public String getMeasurementTime() {
        return measurementTime;
    }

    public void setMeasurementTime(String measurementTime) {
        this.measurementTime = measurementTime;
    }

    public int getMeasurementBatchSize() {
        return measurementBatchSize;
    }

    public void setMeasurementBatchSize(int measurementBatchSize) {
        this.measurementBatchSize = measurementBatchSize;
    }

    @JsonIgnore
    public Map<String, String> getParams() {
        return params;
    }

    @JsonProperty
    public void setParams(Map<String, String> params) {
        this.params = params;
    }

    public Double getScore() {
        return score;
    }

    public Double getScoreError() {
        return scoreError;
    }

    public List<Double> getScoreConfidence() {
        return scoreConfidence;
    }

    @JsonIgnore
    public Map<String, Double> getScorePercentiles() {
        return scorePercentiles;
    }

    public String getScoreUnit() {
        return scoreUnit;
    }

    public List<List<Double>> getRawData() {
        return rawData;
    }

    public String getBenchmarkClass() {
        return benchmarkClass;
    }

    public String getBenchmarkType() {
        return benchmarkType;
    }

    public String getBenchmarkMethod() {
        return benchmarkMethod;
    }

    public String getSize() {
        return size;
    }

    public Long getFakeTimestamp() {
        return fakeTimestamp;
    }

    public void setFakeTimestamp(Long fakeTimestamp) {
        this.fakeTimestamp = fakeTimestamp;
    }
}
