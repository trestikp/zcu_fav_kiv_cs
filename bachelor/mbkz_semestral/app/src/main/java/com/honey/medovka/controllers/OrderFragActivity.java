package com.honey.medovka.controllers;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;

import android.os.Bundle;
import android.view.MenuItem;

import com.honey.medovka.R;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Order;

import java.util.List;

/**
 * Host activity for Order List, Detail and Menu Fragments
 */
public class OrderFragActivity extends AppCompatActivity {

    private static final String LOG_TAG = "OrderFragActivity";

    /** Used to prevent fetching orders again if its the same list */
    protected boolean lastAction = false;
    /** Used to store if fetched orders are finished or active */
    protected boolean finished = false;
    /** Wrapper for DB usage */
    protected MedDatabaseHandler dbWrapper;
    /** List of fetched orders */
    protected List<Order> fetchedOrders = null;
    /** Order clicked from RecyclerView */
    private Order clickedOrder;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_frag);

//        dbWrapper = new MedDatabaseHandler(this, false);
        dbWrapper = MedDatabaseHandler.getInstance();
    }

    /**
     * Used for "back arrow" navigation
     * @param item MenuItem
     * @return succes
     */
    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                int id;

                NavController nav =
                        Navigation.findNavController(this, R.id.order_nav_host_graph);

                try {
                    id = nav.getCurrentDestination().getId();
                } catch (NullPointerException e) {
                    id = -1;
                }

                switch(id) {
                    case R.id.or_list_frag: nav.navigate(R.id.orders_list_to_menu); break;
                    case R.id.or_det_frag: nav.navigate(R.id.orders_det_to_list); break;
//                    case R.id.product_det_frag: nav.navigate(R.id.frag_det_to_list); break;
                    case R.id.or_menu_frag: //if in product menu, go back from activity
                    default: return super.onOptionsItemSelected(item);
                }

                return true;
            default: return super.onOptionsItemSelected(item);
        }
    }

    /**
     * Gets clicked order
     * @return Order
     */
    public Order getClickedOrder() {
        return clickedOrder;
    }

    /**
     * Sets clicked order
     * @param clickedOrder Order
     */
    public void setClickedOrder(Order clickedOrder) {
        this.clickedOrder = clickedOrder;
    }
}