package graphics;

import logic.PGMLoader;
import model.UPGImage;
import org.jfree.chart.ChartPanel;
import org.jfree.svg.SVGGraphics2D;

import javax.swing.*;
import java.awt.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


/**
 * Class handling GUI elements
 *
 * @author Pavel Trestik - A17B0380P
 */
public class UserInterface {
    /** UPGImage instance */
    static UPGImage img;
    /** Drawing canvas */
    static DrawingPane dp;


    private static JFrame frame = new JFrame();
    private static JScrollPane legend;
    private static JTabbedPane pane = new JTabbedPane();


    /**
     * Main... do I need to explain? :D
     * @param args program arguments
     */
    public static void main(String[] args) {
        if(args.length != 1) {
            System.err.println("Program needs exactly one argument.");
            return;
        }

        File f = new File(args[0]);

        if(!f.exists()) {
            System.err.println("File doesn't exist. Terminating...");
            return;
        }

        if(f.length() > 50_000_000) {
            System.err.println("File exceeds maximum allowed size (50MB). Terminating...");
            return;
        }

        img = PGMLoader.loadPGMFileThroughMemory(f);

        if(img == null) {
            System.err.println("Failed to load image from argument");
            return;
        }

        createGUI();
    }

    /**
     * Creates GUI window
     */
    private static void createGUI() {

        frame.setTitle("UPG SP - Pavel Trestik - A17B0380P");
        frame.setSize(1280, 720);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);

        createMenu(frame);

        frame.add(createTabPane(), BorderLayout.CENTER);

        legend = createLegend();
        frame.add(legend, BorderLayout.SOUTH);

        frame.pack();
        frame.setVisible(true);
    }

    /**
     * Creates tab pane that allows to switch between drawing canvas, statistic window and histogram window
     * @return JTabbedPane
     */
    private static JTabbedPane createTabPane() {
        dp = new DrawingPane(img);
        dp.setImg(img);

        pane.addTab("Map", null, dp, "View map visualization");

        pane.addTab("Statistics", null, createStatPane(), "View statistics overview");
        pane.addTab("Histogram", null, createHistPane(), "Show histogram graph");

        return pane;
    }

    /**
     * Creates statistics pane
     * @return JPanel with stats chart
     */
    private static JPanel createStatPane() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());

        ChartPanel chartPanel = new ChartPanel(img.createHeightBoxPlot());
        JPanel stats = new JPanel();
        BoxLayout statsBox = new BoxLayout(stats, BoxLayout.Y_AXIS);
        stats.setLayout(statsBox);

        stats.add(new Label("Min height: " + img.getMin()));
        stats.add(new Label("Max height: " + img.getMax()));
        stats.add(new Label("Average height: " + img.getAverage()));
        stats.add(new Label("25% quantile: " + img.getLowerQ()));
        stats.add(new Label("50% quantile: " + img.getMedian()));
        stats.add(new Label("75% quantile: " + img.getUpperQ()));

        panel.add(stats, BorderLayout.WEST);
        panel.add(chartPanel, BorderLayout.EAST);

        return panel;
    }

    /**
     * Creates histogram chart pane
     * @return JPanel with histogram chart
     */
    private static JPanel createHistPane() {
        JPanel panel = new JPanel();

        ChartPanel chartPanel = new ChartPanel(img.createHeightHistogram());

        panel.setLayout(new BorderLayout());
        panel.add(chartPanel, BorderLayout.CENTER);

        return panel;
    }

    /**
     * Creates legend pane, showing color and their intervals
     * @return JSrollPane
     */
    private static JScrollPane createLegend() {
        long start = System.currentTimeMillis();

        JPanel panel = new JPanel();

        for(int i = 0; i < img.getHeightColors().length; i++) {
            JPanel content = new JPanel();
            content.setMaximumSize(new Dimension(100, 40));

            BoxLayout oneL = new BoxLayout(content, BoxLayout.Y_AXIS);
            content.setLayout(oneL);

            Square s = new Square(img.getHeightColors()[i]);
            s.setPreferredSize(new Dimension(20, 20));
            s.setMinimumSize(new Dimension(20, 20));

            content.setBorder(BorderFactory.createLineBorder(Color.BLACK));

            content.add(s, Component.CENTER_ALIGNMENT);
            content.add(new Label(i * img.getCONTOUR_HEIGHT() + " - " + (i + 1) * img.getCONTOUR_HEIGHT()));

            panel.add(content);
        }

        JScrollPane asdf = new JScrollPane(panel);
        asdf.setMinimumSize(new Dimension(500, 50));
        asdf.setPreferredSize(new Dimension(500, 60));

        long end = System.currentTimeMillis();

        System.out.println("TIME: Legend generation took: " + (end - start) + " ms");

        return asdf;
    }


    /**
     * Creates menu in GUI window
     * @param frame GUI window
     */
    private static void createMenu(JFrame frame) {
        JMenuBar menuBar = new JMenuBar();
        JMenu menu = new JMenu("File");
        JMenuItem file = new JMenuItem("Load PGM file");
        JMenuItem exportPNG = new JMenuItem("Export map to PNG");
        JMenuItem exportSVG = new JMenuItem("Export map to SVG");

        file.addActionListener(event -> loadNewPGM(frame));
        exportPNG.addActionListener(event -> {
            ExportDialog d = new ExportDialog(frame, dp);
        });
        exportSVG.addActionListener(event -> {
            exportSVGAction();
        });

        menu.add(file);
        menu.add(exportPNG);
        menu.add(exportSVG);
        menuBar.add(menu);

        frame.add(menuBar, BorderLayout.NORTH);
    }

    /**
     * Event handler for loading new PGM files from GUI->File->"Load PGM file" menu
     * @param frame
     */
    private static void loadNewPGM(JFrame frame) {
        JFileChooser fc = new JFileChooser();

//        fc.setCurrentDirectory(new File("data"));

        fc.showOpenDialog(frame);
        File f = fc.getSelectedFile();

        if(f == null) return;

        img = PGMLoader.loadPGMFileThroughMemory(f);

        if(img == null) {
            System.err.println("Failed to load image");
            return;
        } else {
            img.createImage();
        }

        pane.removeTabAt(1);
        pane.removeTabAt(1);

//        img.manuallyForceSorted(); - not needed anymore, as createImage() is called
        pane.addTab("Statistics", null, createStatPane(), "View statistics overview");
        pane.addTab("Histogram", null, createHistPane(), "Show histogram graph");

        long start = System.currentTimeMillis();
        frame.remove(legend); // THIS TAKES FOREVER SOMETIMES - NOT MY FAULT
        long end = System.currentTimeMillis();
        System.out.println("Legend removal: " + (end - start) + " ms");

        legend = createLegend();
        frame.add(legend, BorderLayout.SOUTH);

        dp.setImg(img);
        dp.repaint();
    }


    /**
     * Menu action that exports the current image to SVG. Exports it to "vector_map.svg" in project root dir
     */
    private static void exportSVGAction() {
        SVGGraphics2D svg = new SVGGraphics2D(img.getActualImage().getWidth(), img.getActualImage().getHeight());
        dp.drawToSVG(svg);
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter("vector_map.svg"));

            bw.write(svg.getSVGElement());

            bw.close();
        } catch (IOException e) {
            System.err.println("IOException while exporting SVG. Msg: " + e.getMessage());
        }
    }
}

/**
 * Colored Square that is showed in legend
 */
class Square extends JPanel {
    private final Color color;

    public Square(int color) {
        this.color = new Color(color);
    }

    public void paint(Graphics g) {
        final int SQUARE_SIZE = 20;

        g.setColor(color);
        g.fillRect(0, 0, SQUARE_SIZE, SQUARE_SIZE);
    }

}
