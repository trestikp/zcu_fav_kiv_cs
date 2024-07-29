package com.honey.medovka.controllers;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.honey.medovka.R;
import com.honey.medovka.model.Attribute;
import com.honey.medovka.model.AttributeType;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Product;
import com.honey.medovka.model.ProductAttributeRow;

import java.util.ArrayList;
import java.util.List;

/**
 * Controller for Product Addition activity
 */
public class ProductAddition extends AppCompatActivity {

    private static final String LOG_TAG = "ProductAddition";
    /** DB wrapper */
    MedDatabaseHandler dbWrapper;
    /** List of table rows for slecting attributes */
    List<ProductAttributeRow> productAttributeRows = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_product_addition);

        //activity title
        ActionBar ab =  this.getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.product_addition));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        TableLayout table = findViewById(R.id.table);

        dbWrapper = MedDatabaseHandler.getInstance();
        List<Attribute> attributes = dbWrapper.fetchAllAttributes();

        //following attributes are columns in products table, so to work around having them
        // statically, fake attributes are created
        Attribute nameFake = new Attribute(-1, AttributeType.TEXT.index,
                getString(R.string.name) + "*", null);
        Attribute storedFake = new Attribute(-1, AttributeType.NUMBER.index,
                getString(R.string.in_stock), null);
        Attribute priceFake = new Attribute(-1, AttributeType.NUMBER.index,
                getString(R.string.price) + "*", null, "Kč");

        productAttributeRows.add(new ProductAttributeRow(nameFake, this, table));
        productAttributeRows.add(new ProductAttributeRow(priceFake, this, table));
        productAttributeRows.add(new ProductAttributeRow(storedFake, this, table));

        //creating rows for attributes fetched from DB
        if(attributes != null) {
            for(Attribute at : attributes) {
                productAttributeRows.add(new ProductAttributeRow(at, this, table));
            }
        }

        for(ProductAttributeRow r : productAttributeRows) {
            table.addView(r.getRowView());
        }

        //if fetching attributes fails, adds error row
        if(attributes == null || attributes.isEmpty()) {
            TableRow row = (TableRow) LayoutInflater.from(this).
                    inflate(R.layout.table_row_two_tf, table, false);
            ((TextView) row.getChildAt(0))
                    .setText(getString(R.string.attributes_fetch_err_or_empty) + ". " +
                             getString(R.string.product_creation_still_possible));
            ((TextView) row.getChildAt(0)).setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
            row.removeViewAt(1); //second textview isn't needed for this

            table.addView(row);
        }
    }

    /**
     * Finishes activity
     * @param view View
     */
    public void cancelAddition(View view) {
        finish();
    }

    /**
     * Action for button to add product. Extracts value from attribute "form". First two rows are
     * 1) Name, 2) stored and then dynamically generated attributes
     * @param view view
     */
    public void addProduct(View view) {
        String pName = productAttributeRows.get(0).getRowValue();
        if(pName == null || pName.equals("")) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.incorrect_value))
                    .setMessage(R.string.p_name_mustnt_be_empty)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();

            Log.e(LOG_TAG, "Product name is empty/ null");
            return;
        }

        int price = 0;
        try {
            price = Integer.parseInt(productAttributeRows.get(1).getRowValue());
        } catch (NumberFormatException e) {
            Log.e(LOG_TAG, "Failed number conversion for price");
        }

        if(price <= 0) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.incorrect_value))
                    .setMessage(R.string.price_must_be_positive)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();

            Log.e(LOG_TAG, "Price is <= 0");
            return;
        }

        int stored = 0;
        try {
            stored = Integer.parseInt(productAttributeRows.get(2).getRowValue());
        } catch (NumberFormatException e) {
            Log.e(LOG_TAG, "Failed number conversion for stored amount. Assuming 0");
        }

        Product p = new Product(-1, pName, stored, 0, 0, price);

        //starts from 3, because of faked NAME and IN_STOCK, PRICe
        for(int i = 3; i < productAttributeRows.size(); i++) {
            ProductAttributeRow r = productAttributeRows.get(i);

            if(r.getRowValue() == null) continue; //no value = no need to add the attribute

            //getRowAttribute may return null, however only if getRowValue is null, which is checked
            p.addAttribute(r.getRowAttribute());
        }

        dbWrapper.insertNewProduct(p);

        Toast.makeText(this, getString(R.string.product_created_successfully)
                , Toast.LENGTH_LONG).show();
        finish();
    }
}