package com.honey.medovka.model;

import androidx.annotation.NonNull;

import org.w3c.dom.Attr;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Attribute implements Serializable {
//    private final AttributeType type;
    private final int id;
    private final int type;
    private final String attName;
    private final String attUnits;
    private String attValue;
    private List<String> enumValues = null;

    //0 = add, 1 = remove, 2 = update - used for product edit
    public int dbAction = 0;

    /**
     * Attribute constructor for attributes with one value e.g.: weight=80
     * @param type value type
     * @param attName attribute name
     * @param attValue attribute value
     */
    public Attribute(int id, int type, String attName, String attValue) {
        this.id = id;
        this.type = type;
        this.attName = attName;
        this.attValue = attValue;
        this.attUnits = null;
    }

    /**
     * Attribute constructor for attributes with one value e.g.: weight=80
     * @param id int
     * @param type int
     * @param attName String
     * @param attValue String
     * @param attUnits String
     */
    public Attribute(int id, int type, String attName, String attValue, String attUnits) {
        this.id = id;
        this.type = type;
        this.attName = attName;
        this.attValue = attValue;
        this.attUnits = attUnits;
    }

    public String getAttName() {
        return attName;
    }

    public String getAttValue() {
        return attValue;
    }

    public void setAttValue(String attValue) {
        this.attValue = attValue;
    }

    public List<String> getEnumValues() {
        return enumValues;
    }

    public void setEnumValues(List<String> enumValues) {
        this.enumValues = enumValues;
    }

    public int getId() {
        return id;
    }

    public int getType() {
        return type;
    }

    public void initEmptyEnumValues() {
        enumValues = new ArrayList<>();
    }

    public boolean hasUnits() {
        return attUnits != null && !attUnits.equals("");
    }

    public String getAttUnits() {
        return attUnits;
    }

    @NonNull
    @Override
    public Attribute clone() throws CloneNotSupportedException {
        Attribute a = new Attribute(id, type, attName, attValue);

        if(type == AttributeType.ENUM.index) {
            a.setEnumValues(enumValues);
        }

        return a;
    }
}
