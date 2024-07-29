package com.honey.medovka.controllers;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;

import android.provider.MediaStore;
import android.text.InputType;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.honey.medovka.R;
import com.honey.medovka.model.Attribute;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Product;

import java.io.IOException;

/**
 * Controller handling Product Detail Fragment
 */
public class ProductDetailFrag extends Fragment {

    private static final String LOG_TAG = "ProductDetailFrag";
    /** This is set when a product is copied, so the view is recreated with updated values */
    private static boolean comingFromEdit = false;
    private static final int PICK_IMAGE = 1;

    /** Image loaded from dialog */
    private Bitmap loadedMap;

    public ProductDetailFrag() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            Log.i(LOG_TAG, "Class got some arguments onCreate!");
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        setHasOptionsMenu(true);
        return inflater.inflate(R.layout.fragment_product_detail, container, false);
    }

    @Override
    public void onCreateOptionsMenu(@NonNull Menu menu, @NonNull MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.prod_edit_menu, menu);

        if(((PmFragActivity) this.getActivity()).getClickedItem().getImage() == null) {
            menu.findItem(R.id.pd_add_product_image).setVisible(true);
            menu.findItem(R.id.pd_delete_product_image).setVisible(false);
        } else {
            menu.findItem(R.id.pd_add_product_image).setVisible(false);
            menu.findItem(R.id.pd_delete_product_image).setVisible(true);
        }
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        Product clicked = ((PmFragActivity) this.getActivity()).getClickedItem();
        MedDatabaseHandler dbWrapper = ((PmFragActivity) this.getActivity()).dbWrapper;

        switch (item.getItemId()) {
            case R.id.pd_delete_product_image:
                dbWrapper.deleteProductImage(clicked.getId());
                clicked.setImage(null);
                recreateFragment();

                return true;
            case R.id.pd_add_product_image:
                chooseImageActivity();

                return true;
            default: return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(requestCode == PICK_IMAGE) {
            Uri img = data.getData();
            try {
                loadedMap = MediaStore.Images.Media
                        .getBitmap(this.getActivity().getContentResolver(), img);

                extractAndSetImage();
            } catch (IOException e) {
                Log.e(LOG_TAG, "Failed to load image from URI.\n" + e.getMessage());
                loadedMap = null;
            }
        }
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final Fragment frag = this;
        final PmFragActivity activity = (PmFragActivity) this.getActivity();

        //fetch product image if it wasn't fetched already
        if(activity.getClickedItem().getImage() == null) {
            Bitmap b = activity.dbWrapper.fetchProductImage(activity.getClickedItem());
            activity.getClickedItem().setImage(b);
        }

        itemClicked(view, activity);

        //fragment title
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.product_detail));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        //button actions
        view.findViewById(R.id.pdRestockProduct).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                restockAction(activity, activity.getClickedItem(), activity.dbWrapper);
            }
        });
        view.findViewById(R.id.pdModifyProduct).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                comingFromEdit = true;
                NavHostFragment.findNavController(frag).navigate(R.id.frag_det_to_edit);
            }
        });
    }

    /**
     * Methods fills values and table of the fragment
     * @param view View
     * @param activity PmFragActivity
     */
    private void itemClicked(final View view, final PmFragActivity activity) {
        if(activity == null || activity.getClickedItem() == null) {
            return;
        }

        Product clicked = activity.getClickedItem();
        ((TextView) view.findViewById(R.id.pdProductName)).setText(clicked.getName());

        //info about product table
        TableLayout table = view.findViewById(R.id.pdAttTable);

        initProductCharacteristics(activity, table, clicked);

        if(clicked.getImage() == null) {
            view.findViewById(R.id.pdImage).setVisibility(View.GONE);
            view.findViewById(R.id.pdImageMissing).setVisibility(View.VISIBLE);
        } else {
            view.findViewById(R.id.pdImageMissing).setVisibility(View.GONE);
            ImageView imgView = view.findViewById(R.id.pdImage);
            imgView.setVisibility(View.VISIBLE);
            imgView.setImageBitmap(clicked.getImage());
        }

        //populate with attributes
        if(clicked.getAttributes().size() == 0) {
            TableRow row = (TableRow) LayoutInflater.from(activity).
                    inflate(R.layout.table_row_two_tf, table, false);
            ((TextView) row.getChildAt(0))
                    .setText(getString(R.string.product_has_no_attributes));
            row.removeViewAt(1); //second textview isn't needed for this
//            ((TextView) row.getChildAt(1)).setHint("");
            table.addView(row);
        } else {
            for(Attribute at : clicked.getAttributes()) {
                TableRow row = (TableRow) LayoutInflater.from(activity).
                        inflate(R.layout.table_row_two_tf, table, false);
                ((TextView) row.getChildAt(0)).setText(at.getAttName());

                if(at.hasUnits()) {
                    ((TextView) row.getChildAt(1))
                            .setText(at.getAttValue() + " "+ at.getAttUnits());
                } else {
                    ((TextView) row.getChildAt(1)).setText(at.getAttValue());
                }

                table.addView(row);
            }
        }
    }

    /**
     * Inits product characteristics that are stores as columns of product
     * @param activity Activity
     * @param table TableLayout
     * @param product Product
     */
    private void initProductCharacteristics(Activity activity, TableLayout table, Product product) {
        //in stock row
        TableRow row0 = (TableRow) LayoutInflater.from(activity).
                inflate(R.layout.table_row_two_tf, table, false);
        ((TextView) row0.getChildAt(0))
                .setText(getString(R.string.price));
        ((TextView) row0.getChildAt(1)).setText(product.getPrice() + " Kč");
        table.addView(row0);

        //in stock row
        TableRow row = (TableRow) LayoutInflater.from(activity).
                inflate(R.layout.table_row_two_tf, table, false);
        ((TextView) row.getChildAt(0))
                .setText(getString(R.string.in_stock));
        ((TextView) row.getChildAt(1)).setText(product.getStored() + "");
        table.addView(row);

        //reserved row
        TableRow row2 = (TableRow) LayoutInflater.from(activity).
                inflate(R.layout.table_row_two_tf, table, false);
        ((TextView) row2.getChildAt(0))
                .setText(getString(R.string.reserved));
        ((TextView) row2.getChildAt(1)).setText(product.getReserved()  + "");
        table.addView(row2);

        //sold row
        TableRow row3 = (TableRow) LayoutInflater.from(activity).
                inflate(R.layout.table_row_two_tf, table, false);
        ((TextView) row3.getChildAt(0))
                .setText(getString(R.string.sold));
        ((TextView) row3.getChildAt(1)).setText(product.getSold()  + "");

        //add margin to bot of this row, so there is gap between parameters and these rows
        TableLayout.LayoutParams pars = (TableLayout.LayoutParams) row3.getLayoutParams();
        pars.bottomMargin = 15;
        row3.setLayoutParams(pars);

        table.addView(row3);
    }

    /**
     * Action that is perform on "naskladnit" (restock) button
     * @param activity Activity
     * @param pr Product
     * @param dbWrapper MedDatabaseHandler
     */
    private void restockAction(final Activity activity, final Product pr,
                               final MedDatabaseHandler dbWrapper) {
        final EditText et = new EditText(activity);
        final Fragment frag = this;

        et.setInputType(InputType.TYPE_CLASS_NUMBER);
        et.setHint(getString(R.string.restock_hint));

        AlertDialog.Builder builder = new AlertDialog.Builder(activity);
        builder.setTitle(getString(R.string.product_restock));
        builder.setView(et);
        builder.setNegativeButton(getString(R.string.cancel), null);
        builder.setPositiveButton(getString(R.string.restock),
                new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                String res = et.getText().toString();

                try {
                    int n = Integer.parseInt(res);
                    pr.addStored(n);
                    boolean rv = dbWrapper.updateProductStored(pr);

                    if(rv) { //recreate fragment to update changes
                        recreateFragment();
                    }
                } catch (NumberFormatException e) {
                    Toast.makeText(activity, getString(R.string.restock_failed_invalid_value),
                            Toast.LENGTH_LONG).show();
                }
            }
        });

        final AlertDialog dialog = builder.create();
        //trick to "force" keyboard during the dialog
        et.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (hasFocus) {
                    dialog.getWindow().setSoftInputMode(
                            WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
                }
            }
        });

        dialog.show();
    }

    /**
     * Recreates fragment view to show updated values
     */
    private void recreateFragment() {
        this.getParentFragmentManager()
                .beginTransaction()
                .detach(ProductDetailFrag.this)
                .attach(ProductDetailFrag.this)
                .commit();
    }

    /**
     * Starts activity for choosing image of a product (from gallery)
     */
    private void chooseImageActivity() {
        Intent intent = new Intent();
        intent.setType("image/*");
        intent.setAction(Intent.ACTION_GET_CONTENT);
        startActivityForResult(Intent.createChooser(intent, "Select Picture"),
                PICK_IMAGE);
    }

    /**
     * Sets image of clicked product and inserts it to DB
     */
    private void extractAndSetImage() {
        ///wanted this in onOptionsItemSelected, but its asynchronous
        Product clicked = ((PmFragActivity) this.getActivity()).getClickedItem();
        MedDatabaseHandler dbWrapper = ((PmFragActivity) this.getActivity()).dbWrapper;

        // 2 ^ 20 = 1 MiB , max allowed img size is 4 MiB -> 4 * 2 ^ 20
        if(loadedMap.getAllocationByteCount() > (Math.pow(2, 20) * 4)) {
            Log.i(LOG_TAG, "Loaded image exceeds maximum allowed size");
            Toast.makeText(this.getActivity(), R.string.max_image_size_exceeded,
                    Toast.LENGTH_SHORT).show();
        }

        if(loadedMap != null) {
            dbWrapper.insertProductImage(clicked.getId(), loadedMap);
            clicked.setImage(loadedMap);
            recreateFragment();
        } else {
            Log.e(LOG_TAG, "Failed to load image from activity");
            Toast.makeText(this.getActivity(), R.string.failed_to_load_image,
                    Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void onResume() {
        super.onResume();

        if(comingFromEdit) {
            Log.i(LOG_TAG, "Recreating fragment (to update values)");
            comingFromEdit = false;
            recreateFragment();
        }
    }
}
