package com.honey.medovka.controllers;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.util.MutableBoolean;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.Toast;

import com.honey.medovka.R;
import com.honey.medovka.controllers.subcontrollers.ProductSpinnerAdapter;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Order;
import com.honey.medovka.model.Product;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Controller for OrderCreation activity
 */
public class OrderCreation extends AppCompatActivity {

    private static final String LOG_TAG = "OrderAddition";
    private TableLayout pTable;
    /** List of available products fetched from DB */
    private List<Product> fetchedP;
    /** List of already selected products */
    private List<Product> selectedP = new ArrayList<>();

    // "flags"
    private View contItem;
    private int errorRow;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

         fetchedP = MedDatabaseHandler.getInstance().fetchAvailableProducts();

        if(fetchedP == null || fetchedP.isEmpty()) {
            setContentView(R.layout.activity_order_creation_impossible);
            findViewById(R.id.oc_err_btn).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    finish();
                }
            });
            return;
        } else {
            setContentView(R.layout.activity_order_creation);
            fetchedP.add(0, new Product(-1, getString(R.string.not_chosen),
                    -1, -1, -1));
        }

        final OrderCreation inst = this;

        //activity title
        ActionBar ab =  this.getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.order_addition));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        //init product table
        pTable = findViewById(R.id.oc_product_table);
        tableAddButton();

        //init button functions
        findViewById(R.id.oc_cancel).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        findViewById(R.id.oc_create).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                creationAction(inst);
            }
        });
    }

    /**
     * Action of button to create new order. Extracts values from GUI and does basic validation.
     * On invalid value raises AlertDialogs and returns (finishes)
     * @param v Activity
     */
    private void creationAction(Activity v) {
        //extract String values and validate if they are not empty
        final String name = ((EditText) v.findViewById(R.id.oc_name_input)).getText().toString();
        final String city = ((EditText) v.findViewById(R.id.oc_city_input)).getText().toString();
        final String street = ((EditText) v.findViewById(R.id.oc_street_input))
                .getText().toString();
        //check if any string value is null/ empty
        if(name == null || name.equals("") ||
           city == null || city.equals("") ||
           street == null || street.equals("")) {
            String msg = getString(R.string.field_must_contain_value) + ": ";
            if(name == null || name.equals("")) msg += getString(R.string.name) + ", ";
            if(city == null || city.equals("")) msg += getString(R.string.city) + ", ";
            if(street == null || street.equals("")) msg += getString(R.string.street) + ", ";
            msg = msg.substring(0, msg.length() - 2);


            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.empty_value))
                    .setMessage(msg)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();
            return;
        }

        //validate that post code is 5 numbers number and only contains 0-9
        String psc = ((EditText) v.findViewById(R.id.oc_post_input)).getText().toString();
        if(psc.length() != 5 || !psc.matches("^[0-9]*$")) { // ^[0-9]*$ matches 0-x numbers
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.incorrect_value))
                .setMessage(R.string.incorrect_post)
                .setCancelable(false)
                .setPositiveButton(R.string.understand, null);
            builder.create().show();
            return;
        }
        //validate that housenumber only contains 0-9
        String houseN = ((EditText) v.findViewById(R.id.oc_hn_input)).getText().toString();
        if(!houseN.matches("^[0-9]+$")) { // ^[0-9]+$ matches 1-x numbers
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.incorrect_value))
                    .setMessage(R.string.incorrect_hn)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();
            return;
        }
        //validate that post code doesn't start with 0
        if(psc.charAt(0) == '0') {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.incorrect_value))
                    .setMessage(R.string.post_mustnt_begin_with_0)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();
            return;
        }
        //validate that house number doesn't start with 0
        if(houseN.charAt(0) == '0') {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.incorrect_value))
                .setMessage(R.string.housen_mustnt_begin_with_0)
                .setCancelable(false)
                .setPositiveButton(R.string.understand, null);
            builder.create().show();
            return;
        }

        //parse isn't in try, because regex should ensure these are numbers
        final int pscN = Integer.parseInt(psc);
        final int houseNumber = Integer.parseInt(houseN);

        //check if there is atleast one "product" row in table
        int firstRowElCount = ((TableRow) pTable.getChildAt(0)).getChildCount();
        if(pTable.getChildCount() < 1 && firstRowElCount > 1) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(getString(R.string.missing_products))
                    .setMessage(R.string.table_must_contain_at_least_one_row)
                    .setCancelable(false)
                    .setPositiveButton(R.string.understand, null);
            builder.create().show();
            return;
        }

        MutableBoolean hasZero = new MutableBoolean(false);
        final List<Product> prods = extractProductsFromTable(hasZero);
        //if list of products has 0
        if(prods != null && hasZero.value) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle(R.string.product_zero_ordered)
                    .setMessage(R.string.product_list_with_zero)
                    .setPositiveButton(R.string.continuee, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            finishCreation(name, city, street, houseNumber, pscN, prods);
                        }
                    })
                    .setNegativeButton(R.string.cancel, null);
            builder.show();
        } else {
            //if list of products doesn't have zero
            if(prods == null) {
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle(R.string.missing_products)
                        .setMessage(getString(R.string.table_must_contain_at_least_one_row) + ". " +
                                getString(R.string.make_sure_products_are_correct))
                        .setCancelable(false)
                        .setPositiveButton(R.string.understand, null);
                builder.show();
                return;
            }

            finishCreation(name, city, street, houseNumber, pscN, prods);
        }
    }

    /**
     * Finishes product creation. Creates instance of Order which is inserted into DB
     * @param name name of person on order - String
     * @param city city in order - String
     * @param street street in order - String
     * @param houseN  house number in order - int
     * @param post post code in order - int
     * @param ordered ordered product list - List<Product>
     */
    private void finishCreation(String name, String city, String street,
                                int houseN, int post, List<Product> ordered) {
        for(Product p : ordered) {
            p.orderSuccessAction();
        }

        Order o = new Order(-1, name, city, street, houseN,
                post, true, new Date(), null, ordered);

        MedDatabaseHandler.getInstance().insertOrder(o);

        Toast.makeText(this, R.string.order_creation_success, Toast.LENGTH_SHORT).show();
        finish();
    }

    /**
     * Adds "+" button to table for choosing products
     */
    private void tableAddButton() {
        final Context con = this;

        TableRow tr = (TableRow) LayoutInflater.from(this)
                .inflate(R.layout.table_row_oc_btn, pTable, false);
        ImageButton addition = (ImageButton) tr.getChildAt(0); //not sure if check for its existence?
        addition.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(pTable.getChildCount() > 1) {
                    TableRow previous = (TableRow) pTable.getChildAt(
                                        pTable.getChildCount() - 2);
                    Spinner ps = (Spinner) previous.getChildAt(0);
                    Product selected = ((Product) ps.getSelectedItem());

                    if(selected.getId() == -1) {
                        Toast.makeText(con,
                                getString(R.string.previous_row_must_have_selected_product),
                                Toast.LENGTH_SHORT).show();
                        return;
                    }
                }

                addChooserRow();
            }
        });
        pTable.addView(tr);
    }

    /**
     * Adds row which has spinner and EditText which serves to add product to order
     * This method first removes "+" row and after adding chooser row, adds "+" row again
     */
    private void addChooserRow() {
        View addRow = pTable.getChildAt(pTable.getChildCount() - 1);
        pTable.removeViewAt(pTable.getChildCount() - 1);
        final TableRow tr = (TableRow) LayoutInflater.from(this)
                .inflate(R.layout.table_row_oc, pTable, false);

        final Spinner s = (Spinner) tr.getChildAt(0);
        final ProductSpinnerAdapter adapter =
                new ProductSpinnerAdapter(this, -1, initSpinnerList());
        s.setAdapter(adapter);

        s.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            Product current = (Product) s.getSelectedItem();

            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                Product newP = (Product) parent.getItemAtPosition(position);
                ((ProductSpinnerAdapter) s.getAdapter()).previous = current;
//                System.out.println(current.getId());

                if(current.getId() != -1) {
                    selectedP.remove(current);

                    addProductToSpinners(current);
                }

                if(newP.getId() != -1) { //extra assurance check, but probably unnecessary
                    if(current.getId() == -1) { //remove "Nevybrano"
                        ((ProductSpinnerAdapter) s.getAdapter()).getProducts().remove(0);
                        s.setSelection(s.getSelectedItemPosition() - 1); //hack it
                    }

                    selectedP.add(newP);
                    ((EditText) tr.getChildAt(1)).setHint("0-" + newP.getStored());

                    removeProductFromSpinners(newP);
                }

                current = newP;
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        registerForContextMenu(tr);

        pTable.addView(tr);
        if(pTable.getChildCount() < (fetchedP.size() - 1)) {
            pTable.addView(addRow);
        }
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        menu.add(0, 1, 0, getString(R.string.delete_row));
        contItem = v;
    }

    @Override
    public boolean onContextItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();

        if (id == 1) {
            Spinner s = (Spinner) ((TableRow) contItem).getChildAt(0);
            Product p = (Product) s.getSelectedItem();
            selectedP.remove(p);
            addProductToSpinners(p);

            //if there is "add row" button remove it
            if(pTable.getChildCount() < (fetchedP.size() - 1)) {
                pTable.removeViewAt(pTable.getChildCount() - 1);
            }
            //them remove selected row and add new "add row" button
            pTable.removeView(contItem);
            tableAddButton();

            return true;
        }

        return false;
    }

    /**
     * Extract products from table for adding
     * @param hasZero Check if there is a product which has 0 as its ordered count
     * @return List<Product> of valid ordered products (ordered count > 0, and selected product)
     */
    private List<Product> extractProductsFromTable(MutableBoolean hasZero) {
        List<Product> out = new ArrayList<>();
        int success = 0;

        for(int i = 0; i < pTable.getChildCount(); i++) {
            TableRow tr = (TableRow) pTable.getChildAt(i);
            //because when out of products add button isn't in the table
            if(tr.getChildCount() <= 1) break;

            Product p = (Product) ((Spinner) tr.getChildAt(0)).getSelectedItem();
            if(p == null) {
                errorRow = i;
                return null;
            }

            // -1 corresponds to "Nevybrano" (not selected) value, so skip over that field
            if(p.getId() == -1) continue;

            int count;
            try {
                count = Integer.parseInt(((EditText) tr.getChildAt(1)).getText().toString());
            } catch (NumberFormatException e) {
                Log.e(LOG_TAG, "Failed to convert to string to number");
                errorRow = i;
                return null;
            }

            //no count = as if the product wasn't selected
            if(count == 0) {
                hasZero.value = true;
                continue;
            }

            if(p.getStored() < count) {
                AlertDialog.Builder builder = new AlertDialog.Builder(this);
                builder.setTitle(R.string.missing_stock)
                        .setMessage(getString(R.string.only) + " " + p.getStored() + " " +
                                p.getName() + " " + getString(R.string.in_stock_lower_case))
                        .setCancelable(false)
                        .setPositiveButton(R.string.understand, null);
                builder.create().show();
                return null;
            }

            success++;
            p.setOrderCount(count);
            out.add(p);
        }

        if(success <= 0) {
            //Alert handled by caller
            return null;
        }

        return out;
    }

    /**
     * Gets List of items for a new spinner (subtracts selected items from all (fetched) items)
     * @return List<Product>
     */
    private List<Product> initSpinnerList() {
        List<Product> out = new ArrayList<>(fetchedP);

        for(Product p : selectedP) {
            out.remove(p);
        }

        return out;
    }

    /**
     * Adds product back to spinners. This occurs once a selected value in spinner has be reselected
     * to a new value
     * @param p Product which is added to the spinners
     */
    private void addProductToSpinners(Product p) {
        int cnt = pTable.getChildCount();

        //if this is correct, then last button is a "+" button
        if(((TableRow) pTable.getChildAt(cnt - 1)).getChildCount() <= 1) {
            cnt -= 1;
        }

//        for(int i = 0; i < pTable.getChildCount() - 1; i++) {
        for(int i = 0; i < cnt; i++) {
            Spinner s = (Spinner) ((TableRow) pTable.getChildAt(i)).getChildAt(0);
            ProductSpinnerAdapter a = (ProductSpinnerAdapter) s.getAdapter();

            //insert by id
            if(!a.getProducts().contains(p)) {
                boolean isHighestID = true;

                for(int j = 0; j < a.getProducts().size(); j++) {
                    if(p.getId() < a.getProducts().get(j).getId()) {
                        a.getProducts().add(j, p);
                        isHighestID = false;
                        break;
                    }
                }

                if(isHighestID) {
                    a.getProducts().add(p);
                }
            }
        }
    }

    /**
     * Removes product from spinners. This occures when product is selected in a spinner
     * @param p Product
     */
    private void removeProductFromSpinners(Product p) {
        int cnt = pTable.getChildCount();

        //if this is correct, then last button is a "+" button
        if(((TableRow) pTable.getChildAt(cnt - 1)).getChildCount() <= 1) {
            cnt -= 1;
        }

//        for(int i = 0; i < pTable.getChildCount() - 1; i++) {
        for(int i = 0; i < cnt; i++) {
            Spinner s = (Spinner) ((TableRow) pTable.getChildAt(i)).getChildAt(0);
            ProductSpinnerAdapter a = (ProductSpinnerAdapter) s.getAdapter();
            Product selected = (Product) s.getSelectedItem();

            if(selected != p) {
                a.getProducts().remove(p);
            }
        }
    }
}