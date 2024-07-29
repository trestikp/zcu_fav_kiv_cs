package graphics;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

/**
 * Custom dialog for PNG export
 *
 * @author Pavel Trestik - A17B0380P
 */
public class ExportDialog {
    /** dialogs window */
    JFrame frame;

    /**
     * Creates dialog and show ti
     * @param parent parent of dialog
     * @param drawer drawing canvas for access to drawing method
     */
    public ExportDialog(JFrame parent, DrawingPane drawer) {
        frame = new JFrame();
        frame.setLayout(new BorderLayout());

        JPanel in1 = new JPanel();
        in1.setLayout(new FlowLayout());
        JPanel in2 = new JPanel();
        in2.setLayout(new FlowLayout());
        JPanel btns = new JPanel();
        btns.setLayout(new FlowLayout());

        in1.add(new Label("Width: "));
        JTextField wTF = new JTextField();
        wTF.setPreferredSize(new Dimension(50, 20));
        in1.add(wTF);
        in2.add(new Label("Height: "));
        JTextField hTF = new JTextField();
        hTF.setPreferredSize(new Dimension(50, 20));
        in2.add(hTF);

        JButton cancel = new JButton("Cancel");
        JButton export = new JButton("Export");

        cancel.addActionListener(e -> cancelAction());
        export.addActionListener(e -> exportAction(drawer, wTF, hTF));

        btns.add(cancel);
        btns.add(export);

        frame.add(in1, BorderLayout.NORTH);
        frame.add(in2, BorderLayout.CENTER);
        frame.add(btns, BorderLayout.SOUTH);

        frame.setTitle("Enter export resolution");
        frame.setSize(1280, 720);
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setLocationRelativeTo(parent);
        frame.pack();
        frame.setVisible(true);
    }

    /**
     * Closes the dialog
     */
    private void cancelAction() {
        frame.dispatchEvent(new WindowEvent(frame, WindowEvent.WINDOW_CLOSING));
    }

    /**
     * Draws the image to a file "raster_map.png" in root of the project
     * @param dp drawing canvas
     * @param width  JTextField to get exported image width
     * @param height JTextField to get exported image height
     */
    private void exportAction(DrawingPane dp, JTextField width, JTextField height) {
        int w, h;

        try {
            w = Integer.parseInt(width.getText());
            h = Integer.parseInt(height.getText());
        } catch (NumberFormatException e) {
            return;
        }

        BufferedImage out = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
        dp.drawToImage(out, w, h);

        try {
            ImageIO.write(out, "png", new File("./raster_map.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        frame.dispatchEvent(new WindowEvent(frame, WindowEvent.WINDOW_CLOSING));
    }
}
