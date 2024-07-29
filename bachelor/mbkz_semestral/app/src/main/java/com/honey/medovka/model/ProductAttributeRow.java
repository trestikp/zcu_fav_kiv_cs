package com.honey.medovka.model;

import android.app.Activity;
import android.view.LayoutInflater;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import com.honey.medovka.R;

import java.util.ArrayList;
import java.util.List;

/**
 * Class that represents product attribute in a table with input value
 */
public class ProductAttributeRow {
    private Attribute attribute;
    private AttributeType type;
    private TableRow rowView;
    private TableLayout table;
    private Activity activity;

    public ProductAttributeRow(Attribute at, Activity activity, TableLayout table) {
        this.attribute = at;
        this.table = table;
        this.activity = activity;

        if(at.getType() == AttributeType.NUMBER.index) this.type = AttributeType.NUMBER;
        else if(at.getType() == AttributeType.ENUM.index) this.type = AttributeType.ENUM;
        else this.type = AttributeType.TEXT;

        setupView();
    }

    /**
     * Inflates correct xml determined by attribute type and sets name and units
     */
    private void setupView() {
        switch (type) {
            case ENUM: rowView = (TableRow) LayoutInflater.from(activity).inflate(
                    R.layout.table_row_spinner, table, false);
                setSpinnerValues();
                break;
            case NUMBER: rowView = (TableRow) LayoutInflater.from(activity).inflate(
                    R.layout.table_row_number, table, false); break;
            case TEXT: rowView = (TableRow) LayoutInflater.from(activity).inflate(
                    R.layout.table_row_text, table, false); break;
        }

        ((TextView) rowView.getChildAt(0)).setText(attribute.getAttName());
        if(attribute.hasUnits()) {
            ((TextView) rowView.getChildAt(2)).setText(attribute.getAttUnits());
        }
    }

    /**
     * If attribute type is spinner, init its values
     */
    private void setSpinnerValues() {
        List<String> enumValues = attribute.getEnumValues();

        if(enumValues == null) return;
        Spinner s = (Spinner) rowView.getChildAt(1);

        String[] values = new String[enumValues.size() + 1];
        values[0] = activity.getString(R.string.not_chosen);
        for(int i = 1; i <= enumValues.size(); i++) {
            values[i] = enumValues.get(i - 1);
        }

        ArrayAdapter<String> adapter = new ArrayAdapter<>(activity,
                android.R.layout.simple_spinner_item, values);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        s.setAdapter(adapter);
    }

    /**
     * Returns created row view
     * @return TableRow
     */
    public TableRow getRowView() {
        return rowView;
    }

    /**
     * Returns entered value as String or null
     * @return String
     */
    public String getRowValue() {
        String out = null;

        switch (type) {
            case ENUM:
                String sel = ((Spinner) rowView.getChildAt(1))
                        .getSelectedItem().toString();
                if(sel == null || sel.equals(activity.getString(R.string.not_chosen))) {
                    out = null;
                } else {
                    out = sel;
                }
                break;
            case NUMBER:
            case TEXT:
                String ext = ((EditText) rowView.getChildAt(1)).getText().toString();
                if(ext == null || ext.equals("")) {
                    out = null;
                } else {
                    out = ext;
                }
                break;
        }

        return out;
    }

    public Attribute getAttribute() {
        return attribute;
    }

    /**
     * Returns attribute with new entered value or null if new value wasn't entered
     * @return updated Attribute
     */
    public Attribute getRowAttribute() {
        if(getRowValue() == null) return null;

        attribute.setAttValue(getRowValue());

        return attribute;
    }

    /**
     * Sets row value
     * @param value String
     */
    public void setRowValue(String value) {
        if(value == null) return;
        if(this.type == AttributeType.TEXT || this.type == AttributeType.NUMBER) {
            //assuming that number is actually a number (not checking for that)
            ((EditText) this.rowView.getChildAt(1)).setText(value);
        } else {
            Spinner s = (Spinner) this.rowView.getChildAt(1);

            //retrieve spinner values
            SpinnerAdapter a = s.getAdapter();
            List<String> values = new ArrayList<>();
            for(int i = 0; i < a.getCount(); i++) {
                values.add((String) a.getItem(i));
            }

            for(int i = 0 ; i < values.size(); i++) {
                if(values.get(i).equals(value)) {
                    s.setSelection(i); //TODO i nebo i+1 ?
                    break;
                }
            }
        }
    }
}