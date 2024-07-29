package model;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.StandardXYItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.category.*;
import org.jfree.chart.renderer.xy.StandardXYBarPainter;
import org.jfree.chart.renderer.xy.XYBarRenderer;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.data.statistics.DefaultBoxAndWhiskerCategoryDataset;
import org.jfree.data.statistics.HistogramDataset;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Class that saves PGM image data and other data, that are important/ visualized and gives access to them
 *
 * @author Pavel Trestik - A17B0380P
 */
public class UPGImage {
    /** Initially loaded data of the image */
    private final int initialWidth, initialHeight, maxGreyValue;
    private final int[] rasterArray; // can be final?
    private int[] sortedRasterArray = null;
    private final String type;
    private String IMG_NAME;

    private BufferedImage initialImage;
    private final int imgType = BufferedImage.TYPE_INT_RGB;

    /** Calculated values */
    private int min;
    private int minIndex;

    private int max;
    private int maxIndex;

    private int diff;
    private int diffIndex;

    private int median;
    private int lowerQ;
    private int upperQ;
    private int average;

    /** Visualization image */
    private BufferedImage actualImage;

    private int actualImageWidth;
    private int actualImageHeight;

    /** 2nd part */
    private int[] heightColors;
    private final int CONTOUR_HEIGHT = 50;

    private boolean alreadyCreated = false;


    /**
     * Creates instance of this class, however @rasterArray data isn't loaded yet
     * @param width image width
     * @param height image height
     * @param maxGreyValue maximum grey in the image
     * @param type pgm magic number
     */
    public UPGImage(int width, int height, int maxGreyValue, String type) {
        this.initialWidth = width;
        this.initialHeight = height;
        this.maxGreyValue = maxGreyValue;
        this.type = type;

        rasterArray = new int[height * width];
    }

    /**
     * Creates BufferedImage from loaded data to @initialImage and finds important points in the image
     */
    public void createImage() {
        BufferedImage bi = new BufferedImage(initialWidth, initialHeight, imgType);

        initContourColors();

        for(int i = 0; i < rasterArray.length; i++) {
            bi.setRGB(i % initialWidth, i / initialWidth, getRGB_fromGrey(rasterArray[i]));
        }

        initialImage = bi;

        findPoints();

        sortRasterArray();

        alreadyCreated = true;
    }

    /**
     * Finds important points in image
     */
    private void findPoints() {
        max = Integer.MIN_VALUE;
        min = Integer.MAX_VALUE;

        for(int i = 0; i < rasterArray.length; i++) {
            if(rasterArray[i] > max) {
                max = rasterArray[i];
                maxIndex = i;
            }

            if(rasterArray[i] < min) {
                min = rasterArray[i];
                minIndex = i;
            }
        }

        findDiff();
    }

    /**
     * Finds biggest difference between pixel and his adjacent neighbors
     */
    private void findDiff() {
        diff = Integer.MIN_VALUE;

        // looks for biggest diff in the body of the image (edge rows are not included)
        // checks for each pixels top and right neighbor, this should do difference for each neighbor (south, north,
        // west, east) while having as little overlapping as possible
        for(int i = 1; i < initialHeight; i++) {
            for(int j = 0; j < (initialWidth - 1); j++) {
                int diffSouth = Math.abs(rasterArray[i * initialWidth + j] - rasterArray[(i - 1) * initialWidth + j]);
                int diffEast = Math.abs(rasterArray[i * initialWidth + j] - rasterArray[i * initialWidth + (j + 1)]);

                if(diffSouth > diff) {
                    diff = diffSouth;
                    diffIndex = i * initialWidth + j;
                }

                if(diffEast > diff) {
                    diff = diffEast;
                    diffIndex = i * initialWidth + j;
                }
            }
        }

        // check east neighbors of south (top) row of the image
        for(int i = 0; i < (initialWidth - 1); i++) {
            int diffEast = Math.abs(rasterArray[i] - rasterArray[i + 1]);

            if(diffEast > diff) {
                diff = diffEast;
                diffIndex = i;
            }
        }

        // check north neighbors of east (right) column of the image
        for(int i = 0; i < (initialHeight - 1); i++) {

            int diffNorth = Math.abs(rasterArray[i * initialWidth + (initialWidth - 1)] -
                    rasterArray[(i + 1) * initialWidth + (initialWidth - 1)]);

            if(diffNorth > diff) {
                diff = diffNorth;
                diffIndex = i * initialWidth + (initialWidth - 1);
            }
        }
    }

    /**
     * Initializes @contourColors attribute array with colors of a linear gradient ranging from dark (dim) blue to
     * relatively bright red (through yellow)
     */
    private void initContourColors() {
        final int COLOR_CNT = maxGreyValue / CONTOUR_HEIGHT;

        // +1 because
        heightColors = new int[COLOR_CNT + 1];

        Color c1 = new Color(0x00, 0x00, 0x99);
        Color c2 = new Color(0xF5, 0xF5, 0x00);
        Color c3 = new Color(0xCC, 0x00, 0x00);

        for(int i = 0; i < heightColors.length / 2; i++) {
            heightColors[i] = calculateGradient(c1, c2, i / (heightColors.length / 2d));
        }

        for(int i = heightColors.length / 2; i < heightColors.length; i++) {
            heightColors[i] = calculateGradient(c2, c3, (i - heightColors.length / 2d) /
                                                (heightColors.length - (heightColors.length / 2d)));
        }
    }

    /**
     * Calculate linear gradient between two colors on % (0-1)
     * @param from Starting color
     * @param to Target color
     * @param where Percent of linear
     * @return int of RGB color
     */
    private int calculateGradient(Color from, Color to, double where) {
        int rDiff = to.getRed() - from.getRed();
        int gDiff = to.getGreen() - from.getGreen();
        int bDiff = to.getBlue() - from.getBlue();

        return new Color(from.getRed() + (int) (rDiff * where),
                         from.getGreen() + (int) (gDiff * where),
                         from.getBlue() + (int) (bDiff * where)).getRGB();
    }

    /**
     * Gets RGB color from array with colors based on gray value
     * @param value base value
     * @return int of RGB color from array @heightColors
     */
    private int getRGB_fromGrey(int value) {
        return heightColors[value / CONTOUR_HEIGHT];
    }

    /**
     * Resizes @initialImage by the scale given in parameter and stores resized image in @actualImage
     * @param scale multiplier
     */
    public void scaleImage(double scale) {
        actualImageWidth = (int) (initialWidth * scale);
        actualImageHeight = (int) (initialHeight * scale);

        actualImage = new BufferedImage(actualImageWidth, actualImageHeight, imgType);
        Graphics2D imgG = (Graphics2D) actualImage.getGraphics();

        imgG.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);

        imgG.drawImage(initialImage, 0, 0, (int) (initialWidth * scale),
                                                 (int) (initialHeight * scale), null);
    }

    /****************************************************************************************************
     *                                                                                                  *
     *       Graphs and stats                                                                           *
     *                                                                                                  *
     ****************************************************************************************************/

    /**
     * Creates histogram of heights contained in the picture
     * @return Histogram chart
     */
    public JFreeChart createHeightHistogram() {
        final int MAX_NUMBER_OF_COL = 20;
        HistogramDataset dataset = new HistogramDataset();

        double[] data = new double[rasterArray.length];

        for (int i = 0; i < rasterArray.length; i++) {
            data[i] = rasterArray[i];
        }

        dataset.addSeries("Count of height values (averaged for similar values)", data, MAX_NUMBER_OF_COL);

        JFreeChart chart = ChartFactory.createHistogram("Value histogram", "Heights",
                "Count", dataset);

        XYPlot plot = chart.getXYPlot();
        plot.setBackgroundPaint(new Color(0xFD, 0xF4, 0xBB));
        plot.setRangeGridlinePaint(Color.LIGHT_GRAY);
        plot.setRangeGridlinesVisible(true);

        XYItemRenderer renderer = plot.getRenderer();
        renderer.setDefaultItemLabelGenerator(new StandardXYItemLabelGenerator());
        renderer.setDefaultItemLabelFont(new Font("Calibri", Font.PLAIN, 11));
        renderer.setDefaultItemLabelsVisible(true);

        XYBarRenderer barRenderer = (XYBarRenderer) renderer;
        barRenderer.setMargin(0.5);
        barRenderer.setBarPainter(new StandardXYBarPainter());

        return chart;
    }

    /**
     * Creates BoxPlot of important points in image
     * @return BoxAndWhisker chart
     */
    public JFreeChart createHeightBoxPlot() {
        DefaultBoxAndWhiskerCategoryDataset dataset = new DefaultBoxAndWhiskerCategoryDataset();

        List<Integer> list = new ArrayList<>();

        for(Integer i : sortedRasterArray) {
            list.add(i);
        }

        dataset.add(list, "Values", IMG_NAME);

        JFreeChart chart = ChartFactory.createBoxAndWhiskerChart("Boxplot showing important values",
                "Image", "Height values", dataset, true);

        // maybe horizontal?
//        CategoryPlot plot = (CategoryPlot) chart.getPlot();
//        plot.setOrientation(PlotOrientation.HORIZONTAL);

        CategoryPlot plot = chart.getCategoryPlot();
        //									#FDF4BB
        plot.setBackgroundPaint(new Color(0xFD, 0xF4, 0xBB));
        plot.setRangeGridlinePaint(Color.LIGHT_GRAY);
        plot.setRangeGridlinesVisible(true);

        CategoryItemRenderer renderer = plot.getRenderer();
        renderer.setDefaultItemLabelGenerator(new StandardCategoryItemLabelGenerator("{2}%",
                NumberFormat.getIntegerInstance()));
        renderer.setDefaultItemLabelFont(new Font("Calibri", Font.PLAIN, 11));
        renderer.setDefaultItemLabelsVisible(true);

        ((BoxAndWhiskerRenderer) renderer).setMaximumBarWidth(0.1);

        chart.getCategoryPlot().setRenderer(renderer);

        return chart;
    }

    /**
     * Finds median (50% quartile) value
     */
    private void findMedian() {
        int len = sortedRasterArray.length;

        if(len % 2 == 0) {
            // -1 because indices are from 0
            median = (sortedRasterArray[len / 2] + sortedRasterArray[len / 2 - 1]) / 2;
        } else {
            // shouldn't need to ceil index, as index start from 0
            median = sortedRasterArray[len / 2];
        }
    }

    /**
     * Finds 25% and 75% quartile value
     */
    private void findQuartiles() {
        lowerQ = sortedRasterArray[(int) (sortedRasterArray.length * 0.25)];
        upperQ = sortedRasterArray[(int) (sortedRasterArray.length * 0.75)];
    }

    /**
     * Calculates average of all height values
     */
    private void findAverage() {
        int sum = 0;

        for(Integer i : sortedRasterArray) {
            sum += i;
        }

        average = sum / sortedRasterArray.length;
    }

    /**
     * Creates sorted array of height values and finds important points
     */
    public void sortRasterArray() {
        sortedRasterArray = Arrays.copyOf(rasterArray, rasterArray.length);
        Arrays.sort(sortedRasterArray);

        findMedian();
        findAverage();
        findQuartiles();
    }

    /****************************************************************************************************
     *                                                                                                  *
     *       Accessors - Setters and Getters                                                            *
     *                                                                                                  *
     ****************************************************************************************************/


    public String getType() {
        return type;
    }

    public String metaToString() {
        return "File format: " + type + "\nDimensions: " + initialWidth + ", " +
                initialHeight + "\nMax grey value: " + maxGreyValue;
    }

    public int getInitialWidth() {
        return initialWidth;
    }

    public int getInitialHeight() {
        return initialHeight;
    }

    public int getMaxGreyValue() {
        return maxGreyValue;
    }

    public BufferedImage getActualImage() {
        return actualImage;
    }

    public int getMinX() {
        return minIndex % initialWidth;
    }

    public int getMinY() {
        return minIndex / initialWidth;
    }

    public int getMaxX() {
        return maxIndex % initialWidth;
    }

    public int getMaxY() {
        return maxIndex / initialWidth;
    }

    public int getDiffX() {
        return diffIndex % initialWidth;
    }

    public int getDiffY() {
        return diffIndex / initialWidth;
    }

    public int getDiff() {
        return diff;
    }

    public int getDiffIndex() {
        return diffIndex;
    }

    public int[] getRasterArray() {
        return rasterArray;
    }

    public int getCONTOUR_HEIGHT() {
        return CONTOUR_HEIGHT;
    }


    public int getValueAtPosition(int x, int y) {
        int a = (int) ((x / (double) actualImageWidth) * initialWidth);
        int b = (int) ((y / (double) actualImageHeight) * initialHeight);

        return rasterArray[b * initialWidth + a];
    }

    /**
     * Returns index to array heightColors
     * @param value
     * @return
     */
    public int findClosesColorToValue(int value) {
        if(value % CONTOUR_HEIGHT > CONTOUR_HEIGHT / 2)
            return (int) Math.ceil(value / (double) CONTOUR_HEIGHT);
        else
            return value / CONTOUR_HEIGHT;
    }

    public int[] getHeightColors() {
        return heightColors;
    }

    public boolean isAlreadyCreated() {
        return alreadyCreated;
    }

    public int getAverage() {
        return average;
    }

    public int getMin() {
        return min;
    }

    public int getMax() {
        return max;
    }

    public int getMedian() {
        return median;
    }

    public int getLowerQ() {
        return lowerQ;
    }

    public int getUpperQ() {
        return upperQ;
    }

    public String getImgName() {
        return IMG_NAME;
    }

    public void setImgName(String imgName) {
        this.IMG_NAME = imgName;
    }
}
