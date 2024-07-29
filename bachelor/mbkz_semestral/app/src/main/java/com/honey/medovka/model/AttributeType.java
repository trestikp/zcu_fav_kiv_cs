package com.honey.medovka.model;

/**
 * Get type of attribute (determines which input is used).
 */
public enum AttributeType {
    NUMBER(0), TEXT(1), ENUM(2);

    public final int index;
    AttributeType(int index) {
        this.index = index;
    }
}
