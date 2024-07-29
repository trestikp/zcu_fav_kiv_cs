package com.honey.medovka.controllers;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import com.honey.medovka.R;
import com.honey.medovka.model.Attribute;
import com.honey.medovka.model.AttributeType;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Product;
import com.honey.medovka.model.ProductAttributeRow;

import java.util.ArrayList;
import java.util.List;


public class ProductEditFrag extends Fragment {

    private static final String LOG_TAG = "ProductEditFrag";
    MedDatabaseHandler dbWrapper;
    List<ProductAttributeRow> productAttributeRows = new ArrayList<>();

    public ProductEditFrag() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {

        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_product_edit, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final PmFragActivity activity = (PmFragActivity) this.getActivity();
        final Fragment frag = this;

        Product p = activity.getClickedItem();

        //fragment title
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.product_edit));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        //create table
        TableLayout table = view.findViewById(R.id.editTable);

        dbWrapper = MedDatabaseHandler.getInstance();
        List<Attribute> attributes = dbWrapper.fetchAllAttributes();

        Attribute nameFake = new Attribute(-1, AttributeType.TEXT.index,
                getString(R.string.name) + "*", null);
        Attribute priceFake = new Attribute(-1, AttributeType.NUMBER.index,
                getString(R.string.price) + "*", null, "Kč");

        productAttributeRows.add(new ProductAttributeRow(nameFake, activity, table));
        productAttributeRows.add(new ProductAttributeRow(priceFake, activity, table));

        if(attributes != null) {
            for(Attribute at : attributes) {
                productAttributeRows.add(new ProductAttributeRow(at, activity, table));
            }
        }

        //adding rows to table + setting their values, if they have one
        //name is outside loop as its always first and is "fake" attribute (has id -1)
        productAttributeRows.get(0).setRowValue(p.getName());
        productAttributeRows.get(0).getAttribute().setAttValue(p.getName());
        productAttributeRows.get(1).setRowValue(String.valueOf(p.getPrice()));
        productAttributeRows.get(1).getAttribute().setAttValue(String.valueOf(p.getPrice()));
        for(ProductAttributeRow r : productAttributeRows) {
            for(Attribute at : p.getAttributes()) {
                if(at.getId() == r.getAttribute().getId()) {
                    r.setRowValue(at.getAttValue());
                    r.getAttribute().setAttValue(at.getAttValue()); //for comparison (value change)
                }
            }
            table.addView(r.getRowView());
        }

        if(attributes == null || attributes.isEmpty()) {
            TableRow row = (TableRow) LayoutInflater.from(activity).
                    inflate(R.layout.table_row_two_tf, table, false);
            ((TextView) row.getChildAt(0))
                    .setText(getString(R.string.attributes_fetch_err_or_empty));
            ((TextView) row.getChildAt(0)).setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
            row.removeViewAt(1); //second textview isn't needed for this

            table.addView(row);
        }

        //button actions
        view.findViewById(R.id.cancel_edit_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                NavHostFragment.findNavController(frag).navigate(R.id.frag_edit_to_det);
            }
        });
        view.findViewById(R.id.confirm_edit_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                editAction();
                //TODO remove print
//                System.out.println((dbWrapper.fetchProductWithID(activity.getClickedItem().getId())).toString());
//                System.out.println((activity.getClickedItem()).toString());
                NavHostFragment.findNavController(frag).navigate(R.id.frag_edit_to_det);
            }
        });
    }

    private void editAction() {
        boolean rv;
        Product pr = ((PmFragActivity) this.getActivity()).getClickedItem();

        String name = productAttributeRows.get(0).getRowValue();
        if(name == null || name.equals("")) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this.getActivity());
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
            AlertDialog.Builder builder = new AlertDialog.Builder(this.getActivity());
            builder.setTitle(getString(R.string.incorrect_value))
                    .setMessage(R.string.price_must_be_positive)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();

            Log.e(LOG_TAG, "Price is <= 0");
            return;
        }

        //update name, because name is a fake attribute
        if(!pr.getName().equals(name)) {
            dbWrapper.updateProductName(pr.getId(), name);
            pr.setName(name);
        }

        if(price != pr.getPrice()) {
            dbWrapper.updateProductPrice(pr.getId(), price);
            pr.setPrice(price);
        }

        //TODO those if may be simplified?
        //starting from 2 becase 0 = NAME, 1 = PRICE
        for(int i = 2; i < productAttributeRows.size(); i++) {
            ProductAttributeRow r = productAttributeRows.get(i);

            String attValue = r.getAttribute().getAttValue();
            String tfValue = r.getRowValue();

            //both values are null/ empty => no action
            if((attValue == null || attValue.equals("")) &&
                    (tfValue == null || tfValue.equals(""))) {
                continue;
            } else

            //original values is null/empty but new  value is not => add new attribute
            if((attValue == null || attValue.equals("")) &&
                    (tfValue != null && !tfValue.equals(""))) {
                rv = dbWrapper.insertProductAttributeBond(pr.getId(),
                        r.getAttribute().getId(), tfValue);
                pr.addAttribute(r.getRowAttribute());
                if(!rv) break;
            } else

            //attribute isn't null/ empty but new value is => delete attribute
            if((attValue != null && !attValue.equals("")) &&
                    (tfValue == null || tfValue.equals(""))) {
                rv = dbWrapper.deleteProductAttributeBond(pr.getId(), r.getAttribute().getId());
                pr.removeAttribute(r.getAttribute());
                if(!rv) break;
            } else

            //neither values is null/ empty => update item or continue
            if((attValue != null && !attValue.equals("")) &&
                    (tfValue != null && !tfValue.equals(""))) {
                //update if values don't equal
                if(!r.getAttribute().getAttValue().equals(r.getRowValue())) {
                    rv = dbWrapper.updateProductAttributeValue(pr.getId(),
                            r.getAttribute().getId(), tfValue);
                    pr.replaceAttribute(r.getRowAttribute());
                    if(!rv) break;
                }
            } else {
                Log.e(LOG_TAG, "Unknown edit combination");
            }
        }
    }
}