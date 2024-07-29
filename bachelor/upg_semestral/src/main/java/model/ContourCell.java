package model;

/**
 * Basically just a holder of information for contour lines
 *
 * @author Pavel Trestik - A17B0380P
 */
public class ContourCell {
    int x, y;
    double topS, rightS, botS, leftS;
    int p0, p1, p2, p3;
    int type;
    int contourIndex = -1;

    /**
     * Obsolete constructor
     * @param x
     * @param y
     * @param topS
     * @param rightS
     * @param botS
     * @param leftS
     * @param type
     */
    public ContourCell(int x, int y, double topS, double rightS, double botS, double leftS, int type) {
        this.x = x;
        this.y = y;
        this.topS = topS;
        this.rightS = rightS;
        this.botS = botS;
        this.leftS = leftS;
        this.type = type;
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
     *  x, y is position in image
     *
     *  double values are ratios for linear interpolation
     */
    public ContourCell(int x, int y, double topS, double rightS, double botS, double leftS,
                       int p0, int p1, int p2, int p3){
        this.x = x;
        this.y = y;
        this.topS = topS;
        this.rightS = rightS;
        this.botS = botS;
        this.leftS = leftS;
        this.p0 = p0;
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
    }

    public double getAX() {
        return lerp(x, x + 1, topS);
    }

    public double getAY() {
        return y;
    }

    public double getBX() {
        return (x + 1);
    }

    public double getBY() {
        return lerp(y, y + 1, rightS);
    }

    public double getCX() {
        return lerp(x, x + 1, botS);
    }

    public double getCY() {
        return y + 1;
    }

    public double getDX() {
        return x;
    }

    public double getDY() {
        return lerp(y, y + 1, leftS);
    }

    public int getType() {
        return type;
    }

    public int getP0() {
        return p0;
    }

    public int getP1() {
        return p1;
    }

    public int getP2() {
        return p2;
    }

    public int getP3() {
        return p3;
    }

    public int getContourIndex() {
        return contourIndex;
    }

    public void setContourIndex(int contourIndex) {
        this.contourIndex = contourIndex;
    }

    public void setType(int type) {
        this.type = type;
    }

    /**
     * Linear interpolation
     * @param v0 value 0
     * @param v1 value 1
     * @param t ratio
     * @return lineary interpolated value
     */
    private double lerp(double v0, double v1, double t) {
        return (1 - t) * v0 + t * v1;
    }
}
