package cz.pte.benchmarks;

import cz.pte.sorts.SortAlgorithm;
import org.openjdk.jmh.annotations.*;

import java.util.Arrays;
import java.util.Random;
import java.util.concurrent.TimeUnit;

public class SortingBenchmark {

    @Fork(1)
    @State(Scope.Thread)
    public static abstract class Sorter {
        int sortedArray[]           = null;
        int sortedReverseArray[]    = null;
        int randomArray[]           = null;
        int randomOnceArray[]       = null;
        int randomOnceArrayBackup[] = null;

//        @Param({"10000", "100000", "1000000"}) // NOTE: 100000+ are too large and will run "forever"
        @Param({"100", "1000", "10000"})
        int SIZE;

        @Setup(Level.Trial)
        public void setup() {
            sortedArray         = new int[SIZE];
            sortedReverseArray  = new int[SIZE];
            randomArray         = new int[SIZE];
            randomOnceArray     = new int[SIZE];
            Random r = new Random();

            for (int i = 0; i < SIZE; i++) {
                sortedArray[i] = i;
                sortedReverseArray[i] = SIZE - i - 1;
                randomArray[i] = r.nextInt();
            }

            // backup is only init when run for the first time or size is changed
            // in other words: uses the same "random" array for all benchmarks until
            if (randomOnceArrayBackup == null || randomOnceArrayBackup.length != SIZE) {


                for (int i = 0; i < SIZE; i++) {
                    randomOnceArray[i] = r.nextInt();
                }

                randomOnceArrayBackup = randomOnceArray.clone();
            } else {
                randomOnceArray = randomOnceArrayBackup.clone();
            }
        }

        @Benchmark
        @BenchmarkMode({Mode.Throughput, Mode.AverageTime})
        @Warmup(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        @Measurement(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        public boolean sortSorted() {
            return true;
        }

        @Benchmark
        @BenchmarkMode({Mode.Throughput, Mode.AverageTime})
        @Warmup(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        @Measurement(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        public boolean sortSortedReverse() {
            return true;
        }

        @Benchmark
        @BenchmarkMode({Mode.Throughput, Mode.AverageTime})
        @Warmup(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        @Measurement(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        public boolean sortRandom() {
            return true;
        }

        @Benchmark
        @BenchmarkMode({Mode.Throughput, Mode.AverageTime})
        @Warmup(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        @Measurement(iterations = 5, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        public boolean sortRandomOnce() {
            return true;
        }
    }

    public static class BubbleBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            SortAlgorithm.bubbleSort(sortedArray);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            SortAlgorithm.bubbleSort(sortedReverseArray);
            return true;
        }

        @Override
        public boolean sortRandom() {
            SortAlgorithm.bubbleSort(randomArray);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            SortAlgorithm.bubbleSort(randomOnceArray);
            return true;
        }
    }

    public static class InsertionBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            SortAlgorithm.insertionSort(sortedArray);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            SortAlgorithm.insertionSort(sortedReverseArray);
            return true;
        }

        @Override
        public boolean sortRandom() {
            SortAlgorithm.insertionSort(randomArray);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            SortAlgorithm.insertionSort(randomOnceArray);
            return true;
        }
    }

    public static class SelectionBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            SortAlgorithm.selectionSort(sortedArray);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            SortAlgorithm.selectionSort(sortedReverseArray);
            return true;
        }

        @Override
        public boolean sortRandom() {
            SortAlgorithm.selectionSort(randomArray);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            SortAlgorithm.selectionSort(randomOnceArray);
            return true;
        }
    }

    public static class MergeBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            SortAlgorithm.mergeSort(sortedArray, 0, sortedArray.length - 1);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            SortAlgorithm.mergeSort(sortedReverseArray, 0, sortedReverseArray.length - 1);
            return true;
        }

        @Override
        public boolean sortRandom() {
            SortAlgorithm.mergeSort(randomArray, 0, randomArray.length - 1);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            SortAlgorithm.mergeSort(randomOnceArray, 0, randomOnceArray.length - 1);
            return true;
        }
    }

    public static class HeapBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            SortAlgorithm.heapSort(sortedArray);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            SortAlgorithm.heapSort(sortedReverseArray);
            return true;
        }

        @Override
        public boolean sortRandom() {
            SortAlgorithm.heapSort(randomArray);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            SortAlgorithm.heapSort(randomOnceArray);
            return true;
        }
    }

    public static class QuickBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            SortAlgorithm.quickSort(sortedArray, 0, sortedArray.length - 1);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            SortAlgorithm.quickSort(sortedReverseArray, 0, sortedReverseArray.length - 1);
            return true;
        }

        @Override
        public boolean sortRandom() {
            SortAlgorithm.quickSort(randomArray, 0, randomArray.length - 1);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            SortAlgorithm.quickSort(randomOnceArray, 0, randomOnceArray.length - 1);
            return true;
        }
    }

    public static class NativeBenchmark extends Sorter {

        @Override
        public boolean sortSorted() {
            Arrays.sort(sortedArray);
            return true;
        }

        @Override
        public boolean sortSortedReverse() {
            Arrays.sort(sortedReverseArray);
            return true;
        }

        @Override
        public boolean sortRandom() {
            Arrays.sort(randomArray);
            return true;
        }

        @Override
        public boolean sortRandomOnce() {
            Arrays.sort(randomOnceArray);
            return true;
        }
    }
}
