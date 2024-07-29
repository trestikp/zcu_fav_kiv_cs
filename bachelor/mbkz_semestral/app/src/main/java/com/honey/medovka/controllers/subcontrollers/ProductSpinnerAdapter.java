package com.honey.medovka.controllers.subcontrollers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.honey.medovka.R;
import com.honey.medovka.model.Product;


import java.util.List;

/**
 * Adapter for spinner typed to Product
 */
public class ProductSpinnerAdapter extends ArrayAdapter<Product> {

    /** Inflater */
    LayoutInflater inflater;
    /** List of products in spinner */
    List<Product> products;
    /** Previously selected item */
    public Product previous;

    /**
     * Constructor initializing attributes
     * @param context Context
     * @param resource int
     * @param objects List<Product>
     */
    public ProductSpinnerAdapter(@NonNull Context context, int resource,
                                 @NonNull List<Product> objects) {
        super(context, resource, objects);
        inflater = LayoutInflater.from(context);
        products = objects;
        previous = products.get(0); //init previous as unselected
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        View row = inflater.inflate(R.layout.spinner_plain_textlayout, null, true);
        Product p = getItem(position);
        TextView tv = row.findViewById(R.id.asdfVal);
        tv.setText(p.getName());

        return row;
    }

    @Override
    public View getDropDownView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        if(convertView == null) {
            convertView = inflater.inflate(R.layout.spinner_plain_textlayout, parent, false);
        }

        Product p = getItem(position);
        TextView tv = convertView.findViewById(R.id.asdfVal);
        tv.setText(p.getName());

        convertView.setPadding(0, 20, 0, 0);

        return convertView;
    }

    /**
     * Access to product attribute
     * @return reference to attribute products (List<Product>)
     */
    public List<Product> getProducts() {
        return products;
    }
}
