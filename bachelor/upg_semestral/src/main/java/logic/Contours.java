package logic;

import model.ContourCell;
import model.UPGImage;

import java.util.ArrayList;
import java.util.List;

/**
 * Class used for finding contours
 *
 * @author Pavel Trestik - A17B0380P
 */
public class Contours {
    ContourCell[] arr;

    /**
     * Creates instance of this class and creates and prepares array of ContourCells
     * @param myImg
     */
    public Contours(UPGImage myImg) {
        long start = System.currentTimeMillis();

        arr = getAllCells(myImg);

        for(int i = (int) Math.ceil(myImg.getMaxGreyValue() / (double) myImg.getCONTOUR_HEIGHT()); i >= 0; i--) {
            determineCellTypeAndHeight(arr, i * myImg.getCONTOUR_HEIGHT(), i);
        }

        long end = System.currentTimeMillis();
        System.out.println("TIME: Contour finding: " + (end - start) + " ms");
    }

    /**
     * Returns array of ContourCell, containing all cells for the image
     * @return ContourCell[]
     */
    public ContourCell[] getArr() {
        return arr;
    }

    /**
     *     p0      a      p1
     *      |------|------|
     *      |   /  |  \   |
     *    d |------|------|  b
     *      |   \  |  /   |
     *      |------|------|
     *     p3      c      p2
     *
     * Obsolete way to find contours
     *
     */
    public static List<ContourCell> findContours(UPGImage img, int contourHeight) {
        List<ContourCell> oneLevelContours = new ArrayList<>();

        for(int i = 0; i < img.getActualImage().getHeight() - 1; i++) {
            for(int j = 0; j < img.getActualImage().getWidth() - 1; j++) {
                int square = 0x00;

                int p0 = img.getValueAtPosition(j, i);
                int p1 = img.getValueAtPosition(j + 1, i);
                int p2 = img.getValueAtPosition(j + 1, i + 1);
                int p3 = img.getValueAtPosition(j, i + 1);

                if(p0 >= contourHeight) square |= 0x08;
                if(p1 >= contourHeight) square |= 0x04;
                if(p2 >= contourHeight) square |= 0x02;
                if(p3 >= contourHeight) square |= 0x01;

                double topScale = p0 > p1 ? p1 / (double) p0 : p0 / (double) p1;
                double rightScale = p1 > p2 ? p2 / (double) p1 : p1 / (double) p2;
                double botScale = p2 > p3 ? p3 / (double) p2 : p2 / (double) p3;
                double leftScale = p3 > p0 ? p0 / (double) p3 : p3 / (double) p0;

                if(square != 0 && square != 15) {
                    ContourCell c = new ContourCell(j, i, topScale, rightScale, botScale, leftScale, square);
                    oneLevelContours.add(c);
                }
            }
        }

        return oneLevelContours;
    }

    /**
     * Creates ContourCell[] and fills basic values
     * @param img UPGImage from which cells are found
     * @return ContourCell[]
     */
    private ContourCell[] getAllCells(UPGImage img) {
        ContourCell[] allC = new ContourCell[(img.getActualImage().getWidth() - 1) *
                                             (img.getActualImage().getHeight() - 1)];
        int counter = 0;

        for(int i = 0; i < img.getActualImage().getHeight() - 1; i++) {
            for(int j = 0; j < img.getActualImage().getWidth() - 1; j++) {
                int p0 = img.getValueAtPosition(j, i);
                int p1 = img.getValueAtPosition(j + 1, i);
                int p2 = img.getValueAtPosition(j + 1, i + 1);
                int p3 = img.getValueAtPosition(j, i + 1);

                double topScale = p0 > p1 ? p1 / (double) p0 : p0 / (double) p1;
                double rightScale = p1 > p2 ? p2 / (double) p1 : p1 / (double) p2;
                double botScale = p2 > p3 ? p3 / (double) p2 : p2 / (double) p3;
                double leftScale = p3 > p0 ? p0 / (double) p3 : p3 / (double) p0;

                ContourCell c = new ContourCell(j, i, topScale, rightScale, botScale, leftScale, p0, p1, p2, p3);
                allC[counter] = c;
                counter++;
            }
        }

        return allC;
    }

    /**
     * Fills necessary values to ContourCells, that couldn't be filled during init
     * @param cells ContourCells[]
     * @param contourH Height of target contour
     * @param contourI Index of target contour (is also used for highlighting)
     */
    private void determineCellTypeAndHeight(ContourCell[] cells, int contourH, int contourI) {
        for(int i = 0; i < cells.length; i++) {
            if(cells[i].getContourIndex() != -1) continue;

            if(cells[i].getP0() >= contourH ||
               cells[i].getP1() >= contourH ||
               cells[i].getP2() >= contourH ||
               cells[i].getP3() >= contourH) {

                cells[i].setContourIndex(contourI);

                byte square = 0x00;
                square |= cells[i].getP0() >= contourH ? 0x08 : 0x00;
                square |= cells[i].getP1() >= contourH ? 0x04 : 0x00;
                square |= cells[i].getP2() >= contourH ? 0x02 : 0x00;
                square |= cells[i].getP3() >= contourH ? 0x01 : 0x00;

                cells[i].setType(square);
            }
        }
    }

//    public List<List<ContourCell>> getAllContourLines() {
//        return allContourLines;
//    }
}