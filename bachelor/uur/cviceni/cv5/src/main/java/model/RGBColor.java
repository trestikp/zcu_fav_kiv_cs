package model;

import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleIntegerProperty;


public class RGBColor {

    private IntegerProperty red = new SimpleIntegerProperty();
    private IntegerProperty green = new SimpleIntegerProperty();
    private IntegerProperty blue = new SimpleIntegerProperty();

    public RGBColor(int r, int g, int b) {
        red.setValue(r);
        green.setValue(g);
        blue.setValue(b);
    }


    /*
        Getters
     */

    public int getRedValue() {
        return red.getValue();
    }

    public int getGreenValue() {
        return green.getValue();
    }

    public int getBlueValue() {
        return blue.getValue();
    }

    public IntegerProperty getRedProperty() {
        return red;
    }

    public IntegerProperty getGreenProperty() {
        return green;
    }

    public IntegerProperty getBlueProperty() {
        return blue;
    }
}
