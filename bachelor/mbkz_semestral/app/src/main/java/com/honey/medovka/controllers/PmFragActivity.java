package com.honey.medovka.controllers;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;

import android.os.Bundle;
import android.view.MenuItem;

import com.honey.medovka.R;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Product;
import com.honey.medovka.model.ProductMenuAction;


/**
 * Activity for ProdcutMenu (=Pm). Offers fragments for product management
 */
public class PmFragActivity extends AppCompatActivity {

    private static final String LOG_TAG = "PmFragActivity";

    /** Determines what list is to be generated */
    protected ProductMenuAction action = ProductMenuAction.SHOW;
    /** If item is clicked in a SHOW list */
    protected Product clickedItem = null;
    /** Database wrapper */
    protected MedDatabaseHandler dbWrapper;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pm_frag);

        dbWrapper = MedDatabaseHandler.getInstance();
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home: //if "arrow back" was pressed
                int id;

                NavController nav =
                        Navigation.findNavController(this, R.id.product_nav_host_fragment);
                try {
                    id = nav.getCurrentDestination().getId();
                } catch (NullPointerException e) {
                    id = -1;
                }

                //switch that determines where to move from current fragment
                switch(id) {
                    case R.id.product_list_frag: nav.navigate(R.id.frag_list_to_menu); break;
                    case R.id.product_det_frag: nav.navigate(R.id.frag_det_to_list); break;
                    case R.id.product_edit_farg: nav.navigate(R.id.frag_edit_to_det); break;
                    case R.id.pm_menu_frag: //if in product menu, go back from activity
                    default: return super.onOptionsItemSelected(item);
                }

                return true;
            default: return super.onOptionsItemSelected(item);
        }
    }

    /**
     * Returns action to be performed. Used in determining what list of data is to be generated.
     * @return ProductMenuAction
     */
    public ProductMenuAction getAction() {
        return action;
    }

    /**
     * Set action to be performed.
     * @param action ProductMenuAction
     */
    public void setAction(ProductMenuAction action) {
        this.action = action;
    }

    /**
     * Returns clicked Product in SHOW list
     * @return Product
     */
    public Product getClickedItem() {
        return clickedItem;
    }

    /**
     * Sets clicked Product in SHOW list
     * @param clickedItem Product
     */
    public void setClickedItem(Product clickedItem) {
        this.clickedItem = clickedItem;
    }

    /**
     * Returns instance of database wrapper
     * @return MedDatabaseHandler
     */
    public MedDatabaseHandler getDbWrapper() {
        return dbWrapper;
    }
}