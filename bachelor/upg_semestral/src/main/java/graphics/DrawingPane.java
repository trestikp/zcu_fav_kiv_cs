package graphics;

import model.ContourCell;
import logic.Contours;
import model.UPGImage;

import javax.swing.JPanel;
import java.awt.geom.*;
import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;


/**
 * Drawing canvas class
 *
 * @author Pavel Trestik - A17B0380P
 */
public class DrawingPane extends JPanel {
    private final int ARROW_LENGTH = 60;
    private final int ARROW_TIP_LENGTH = 15;
    private final int ARROW_WIDTH = 3;
    private final int ARROW_OUTER_WIDTH = 8;

    /** UPGImage instance used to get image information and building visual image */
    private UPGImage img;

    /** Highlighted point position and value */
    private int hlX;
    private int hlY;
    private int hlVal = -1;
    private int closestContourH = -1;

    private int imgXOff = 0;
    private int imgYOff = 0;

    private int lastImgW = -1;
    private int lastImgH = -1;
    private String lastImgName = "";

    private Contours contours = null;

    /**
     * Constructor creating new canvas with basic settings
     * @param img UPGImage instance
     */
    public DrawingPane(UPGImage img) {
        this.setMinimumSize(new Dimension(800, 600));
        this.setPreferredSize(new Dimension(1280, 720));
        this.setBackground(Color.GRAY);

        this.img = img;

        setupMouseEvent();
    }

    public void paint(Graphics graphics) {
        super.paint(graphics);

        Graphics2D g2 = (Graphics2D) graphics;

        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        drawImageScaled(g2, false, 0);

        if(hlVal >= 0) {
            highlightPoint(g2);
        }
    }

    /**
     * Draws imaged scale to window size and arrows pointing to important points in the image
     * @param g2 graphics
     */
    private void drawImageScaled(Graphics2D g2, boolean exporting, double scale_override) {
        double scale = Math.min(this.getWidth() / (double) img.getInitialWidth(),
                               this.getHeight() / (double) img.getInitialHeight());

        if(exporting) {
            scale = scale_override;
        }

        img.scaleImage(scale);

        //local instance for easier access
        BufferedImage bi = img.getActualImage();

        if(!exporting) {
            imgXOff = this.getWidth() / 2 - bi.getWidth() / 2;
            imgYOff = this.getHeight() / 2 - bi.getHeight() / 2;
        }


        g2.drawImage(bi, imgXOff, imgYOff, null);

        ///////////////// CONTOUR LINES

        g2.setStroke(new BasicStroke(0.8f));


        if(lastImgW != bi.getWidth() || lastImgH != bi.getHeight() || !lastImgName.equals(img.getImgName())) {
            contours = new Contours(img);
        }

        if(contours != null) {
            System.out.println("Drawing contours");
            long start = System.currentTimeMillis();

            ContourCell[] arr = contours.getArr();

            for(ContourCell c : arr) {
                if(c.getContourIndex() == closestContourH) {
                    g2.setColor(Color.BLACK);
                } else {
                    g2.setColor(Color.WHITE);
                }

                drawContourSquare(g2, c);
            }

            long end = System.currentTimeMillis();
            System.out.println("TIME: Done drawing contours: " + (end - start) + " ms");
        }

        lastImgW = bi.getWidth();
        lastImgH = bi.getHeight();
        lastImgName = img.getImgName();

        ///////////////// CONTOUR LINES


        drawArrowWithText(g2, (img.getMinX() * scale) + imgXOff, (img.getMinY() * scale) + imgYOff,
                bi.getWidth(), bi.getHeight(), "Min. prevyseni");

        drawArrowWithText(g2, (img.getMaxX() * scale) + imgXOff, (img.getMaxY() * scale) + imgYOff,
                bi.getWidth(), bi.getHeight(), "Max. prevyseni");

        drawArrowWithText(g2, (img.getDiffX() * scale) + imgXOff, (img.getDiffY() * scale) + imgYOff,
                bi.getWidth(), bi.getHeight(), "Max. stoupani");
    }

    /**
     * Draws and arrow pointing to @x, @y with text @text
     * @param g2 graphics context
     * @param x axis position
     * @param y axis position
     * @param text arrow text
     */
    private void drawArrowWithText(Graphics2D g2, double x, double y, int width, int height, String text) {
        // need to account for the offset, because the offset changes the direction of the arrow
        double xVect = (x - imgXOff) / width;
        double yVect = (y - imgYOff) / height;

        double x1;
        double y1;

        g2.setFont(new Font("Serif", Font.PLAIN, 20));
        FontMetrics fm = g2.getFontMetrics();

        float fontXOffset = fm.stringWidth(text);
        float fontYOffset = (float) fm.getHeight();

        if(yVect < 0.5) {
            yVect = 1 - yVect;
        } else {
            yVect = -yVect;
            fontYOffset = -fontYOffset;
        }

        if(xVect < 0.5) {
            xVect = 1 - xVect;
            fontXOffset = 0;
        } else {
            xVect = -xVect;
            fontXOffset = -fontXOffset;
        }

        double norm = 1 / Math.sqrt(xVect * xVect + yVect * yVect);
        xVect *= norm;
        yVect *= norm;

        x1 = x + xVect * ARROW_LENGTH;
        y1 = y + yVect * ARROW_LENGTH;

        drawArrow(g2, x1, y1, x, y);

        g2.drawString(text, (float) x1 + fontXOffset, (float) y1 + fontYOffset);
    }

    /**
     * Paints arrow from @x1, @y1 to @x2, @y2
     * @param g2 graphics
     * @param x1 start x
     * @param y1 start y
     * @param x2 end x
     * @param y2 end y
     */
    private void drawArrow(Graphics2D g2, double x1, double y1, double x2, double y2) {
        double xVect = x2 - x1;
        double yVect = y2 - y1;

//        System.out.println("Arrow len: " + Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)));

        g2.setStroke(new BasicStroke(ARROW_OUTER_WIDTH, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL));
        g2.setColor(Color.WHITE);

        g2.draw(new Line2D.Double(x1, y1, x2, y2));

        g2.setStroke(new BasicStroke(ARROW_WIDTH, BasicStroke.CAP_BUTT, BasicStroke.JOIN_BEVEL));
        g2.setColor(Color.BLACK);

        g2.draw(new Line2D.Double(x1, y1, x2, y2));

        drawArrowTip(g2, x2, y2, xVect, yVect);
    }

    /**
     * Draws the arrow tip
     * @param g2 graphics
     * @param x point of breaking
     * @param y point of breaking
     * @param xVect x vector
     * @param yVect y vector
     */
    private void drawArrowTip(Graphics2D g2, double x, double y, double xVect, double yVect) {
        double vectScale = 1 / Math.sqrt(xVect * xVect + yVect * yVect);

        xVect *= vectScale;
        yVect *= vectScale;

        double normVectX = yVect;
        double normVectY = -xVect;

        normVectX *= 0.5 * ARROW_TIP_LENGTH;
        normVectY *= 0.5 * ARROW_TIP_LENGTH;

        double offX = x - xVect * ARROW_TIP_LENGTH;
        double offY = y - yVect * ARROW_TIP_LENGTH;

        double[] Xaxis = {offX + normVectX, x, offX - normVectX};
        double[] Yaxis = {offY + normVectY, y, offY - normVectY};

        Path2D path = new Path2D.Double();

        path.moveTo(Xaxis[0], Yaxis[0]);
        for(int i = 0; i < Xaxis.length; i++) {
            path.lineTo(Xaxis[i], Yaxis[i]);
        }

        g2.setStroke(new BasicStroke(ARROW_OUTER_WIDTH, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER));
        g2.setColor(Color.WHITE);

        g2.draw(path);

        g2.setStroke(new BasicStroke(ARROW_WIDTH, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER));
        g2.setColor(Color.BLACK);

        g2.draw(path);
    }

    /**
     * Creates a highlight at clicked point
     * @param g2 graphics
     */
    private void highlightPoint(Graphics2D g2) {
        g2.setFont(new Font("Serif", Font.PLAIN, 20));

        FontMetrics fm = g2.getFontMetrics();

        double width = fm.stringWidth(hlVal + "") * 1.1;
        double height = fm.getHeight();

        double xOff = ((hlX / (double) img.getActualImage().getWidth()) < 0.5) ? 0.0 : -width;
        double yOff = ((hlY / (double) this.getHeight()) < 0.5) ? (height * hlY / this.getHeight()) :
                                                                  (-height * hlY / this.getHeight());

        g2.setColor(Color.WHITE);

        g2.fill(new Rectangle2D.Double(hlX + xOff, hlY + yOff, width, height));

        g2.setColor(Color.BLACK);

        // small dot on "clicked" location - isn't accurate, because location is rescaled from original data
        final double POINT_HL_R = 5;
        g2.fill(new Ellipse2D.Double(hlX - POINT_HL_R / 2, hlY - POINT_HL_R / 2, POINT_HL_R, POINT_HL_R));

        // wtf, string is drawn on the LEFT BOTTOM corner, not LEFT TOP corner as everything else.....
        g2.drawString(hlVal + "", (float) (hlX + xOff + (width * 0.05)),
                                      (float) (hlY + yOff + (fm.getHeight() * 0.8)));
    }


    /**
     * Draws contour lines based on cell type
     *
     * This maybe should be in ContourCell class
     * @param g2 graphics
     * @param c cell
     */
    private void drawContourSquare(Graphics2D g2, ContourCell c) {
        switch (c.getType()) {
            case 14:
            case 1: // c - d
                g2.draw(new Line2D.Double(c.getCX() + imgXOff, c.getCY() + imgYOff,
                        c.getDX() + imgXOff, c.getDY() + imgYOff));
                break;
            case 13:
            case 2: // c - b
                g2.draw(new Line2D.Double(c.getCX() + imgXOff, c.getCY() + imgYOff,
                        c.getBX() + imgXOff, c.getBY() + imgYOff));
                break;
            case 12:
            case 3: // d - b
                g2.draw(new Line2D.Double(c.getDX() + imgXOff, c.getDY() + imgYOff,
                        c.getBX() + imgXOff, c.getBY() + imgYOff));
                break;
            case 11:
            case 4: // a - b
                g2.draw(new Line2D.Double(c.getAX() + imgXOff, c.getAY() + imgYOff,
                        c.getBX() + imgXOff, c.getBY() + imgYOff));
                break;
            case 5: // a - d    c - b
                g2.draw(new Line2D.Double(c.getAX() + imgXOff, c.getAY() + imgYOff,
                        c.getDX() + imgXOff, c.getDY() + imgYOff));
                g2.draw(new Line2D.Double(c.getCX() + imgXOff, c.getCY() + imgYOff,
                        c.getBX() + imgXOff, c.getBY() + imgYOff));
                break;
            case 9:
            case 6: // a - c
                g2.draw(new Line2D.Double(c.getAX() + imgXOff, c.getAY() + imgYOff,
                        c.getCX() + imgXOff, c.getCY() + imgYOff));
                break;
            case 8:
            case 7: // a - d
                g2.draw(new Line2D.Double(c.getAX() + imgXOff, c.getAY() + imgYOff,
                        c.getDX() + imgXOff, c.getDY() + imgYOff));
                break;
            case 10: // a - b   c - d
                g2.draw(new Line2D.Double(c.getAX() + imgXOff, c.getAY() + imgYOff,
                        c.getBX() + imgXOff, c.getBY() + imgYOff));
                g2.draw(new Line2D.Double(c.getCX() + imgXOff, c.getCY() + imgYOff,
                        c.getDX() + imgXOff, c.getDY() + imgYOff));
                break;
        }
    }

    /**
     * Sets MouseListener for mouse click event
     */
    private void setupMouseEvent() {
        this.addMouseListener(new MouseListener() {
            @Override
            public void mouseClicked(MouseEvent e) {
                hlX = e.getX();
                hlY = e.getY();

                // if click isn't in image, sets hlVal to -1 and repaints (causes current value to disappear)
                if(hlX < imgXOff || hlX > (imgXOff + img.getActualImage().getWidth()) ||
                   hlY < imgYOff || hlY > (imgYOff + img.getActualImage().getHeight())) {

                    hlVal = -1;
                    closestContourH = -1;
                    repaint();

                    return;
                }

                hlVal = img.getValueAtPosition(e.getX() - imgXOff, e.getY() - imgYOff);
                closestContourH = img.findClosesColorToValue(hlVal);

                repaint();

//                System.out.println("Clicked " + e.getX() + ", " + e.getY() + ": " + img.getValueAtPosition(e.getX(), e.getY()));
            }

            @Override
            public void mousePressed(MouseEvent e) {

            }

            @Override
            public void mouseReleased(MouseEvent e) {

            }

            @Override
            public void mouseEntered(MouseEvent e) {

            }

            @Override
            public void mouseExited(MouseEvent e) {

            }
        });
    }

    /**
     * Draws current graphics to and PNG image
     * @param target target image
     * @param w image width
     * @param h image height
     */
    public void drawToImage(BufferedImage target, int w, int h) {
        double scale = Math.min(w / (double) img.getInitialWidth(),
                                h / (double
                                        ) img.getInitialHeight());

        double scaleOrig = Math.min(this.getWidth() / (double) img.getInitialWidth(),
                this.getHeight() / (double) img.getInitialHeight());

        int xOffOrig = imgXOff;
        int yOffOrig = imgYOff;

        //this offset doesn't center it, dunno anymore..
//        imgXOff = w / 2 - img.getActualImage().getWidth() / 2;
//        imgYOff = h / 2 - img.getActualImage().getHeight() / 2;

        imgXOff = 0;
        imgYOff = 0;

        Graphics2D g2 = (Graphics2D) target.getGraphics();

        //this apparently also doesn't work and i'm too lazy to do rectangle
        g2.setBackground(Color.WHITE);

        drawImageScaled(g2, true, scale);

        if(hlVal >= 0) {
            highlightPoint(g2);
        }


        img.scaleImage(scaleOrig);
        imgXOff = xOffOrig;
        imgYOff = yOffOrig;
    }

    /**
     * Draws current graphics to SVG file
     * @param svg target
     */
    public void drawToSVG(Graphics2D svg) {
        paint(svg);
    }

    /****************************************************************************************************
     *                                                                                                  *
     *       Accessors - Setters and Getters                                                            *
     *                                                                                                  *
     ****************************************************************************************************/

    /**
     * Sets image that is drawn, used when loading new image through GUI
     * @param img new image
     */
    public void setImg(UPGImage img) {
        this.img = img;
        hlVal = -1;
        lastImgName = "";
        lastImgH = -1;
        lastImgW = -1;
        closestContourH = -1;

        if(!img.isAlreadyCreated()) {
            this.img.createImage();
        }
    }
}
