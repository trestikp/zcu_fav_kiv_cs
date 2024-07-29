package com.honey.medovka.controllers;

import android.app.DatePickerDialog;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.DatePicker;

import com.honey.medovka.R;
import com.honey.medovka.controllers.subcontrollers.OrderFragAdapter;
import com.honey.medovka.model.Order;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Controller for Order List Fragment
 */
public class OrderListFrag extends Fragment {

    private static final String LOG_TAG = "OrderListFrag";

    /** Dates prepared for filters */
    private Date newerThan;
    private Date olderThan;

    /** Order RecyclerView */
    private RecyclerView rv;

    public OrderListFrag() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            Log.i(LOG_TAG, "Fragment has arguments");
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        //make this true to get menu with filter options, but they don't fully work
        setHasOptionsMenu(false);
        return inflater.inflate(R.layout.fragment_order_list, container, false);
    }

    @Override
    public void onCreateOptionsMenu(@NonNull Menu menu, @NonNull MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.order_list_menu, menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.ol_newer_filter:
                startDateChooser(true);
                return true;
            case R.id.ol_older_filter:
                startDateChooser(false);
                return true;
            case R.id.ol_cancel_filters:
                newerThan = null;
                olderThan = null;
                updateListAfterFilter();
                return true;
            default: return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        OrderFragActivity activity = (OrderFragActivity) this.getActivity();

        //fragment title
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            if(activity.finished) {
                ab.setTitle(getString(R.string.orders_finished));
            } else {
                ab.setTitle(getString(R.string.orders_active));
            }
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        rv = view.findViewById(R.id.ol_frag_list);

        if(activity.fetchedOrders == null || activity.lastAction != activity.finished) {
            Log.i(LOG_TAG, "Fetching orders");
            // finished == true -> active == false
            activity.fetchedOrders = activity.dbWrapper.fetchOrders(!activity.finished);
            activity.lastAction = activity.finished;
        }

        if(activity.fetchedOrders == null || activity.fetchedOrders.isEmpty()) {
            view.findViewById(R.id.ol_frag_list).setVisibility(View.GONE);
            view.findViewById(R.id.ol_empty_text).setVisibility(View.VISIBLE);
        } else {
            OrderFragAdapter adapter =
                    new OrderFragAdapter(activity.fetchedOrders, activity, this);
            rv.setAdapter(adapter);
        }
    }

    /**
     * Methods starts Date chooser dialog for filter
     * @param newer
     */
    public void startDateChooser(final boolean newer) {
        // Use the current date as the default date in the picker
        final Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        DatePickerDialog.OnDateSetListener listener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int month, int dayOfMonth) {
                Calendar c = Calendar.getInstance();
                if(newer) {
                    c.set(year, month, dayOfMonth, 0, 0, 1);
                    newerThan = c.getTime();
                } else {
                    c.set(year, month, dayOfMonth, 23, 59, 59);
                    olderThan = c.getTime();
                }

                updateListAfterFilter();
            }
        };

        DatePickerDialog dial = new DatePickerDialog(getActivity(), listener, year, month, day);
        dial.show();
    }

    /**
     * Removes items not fitting filters from a copy of fetched list and sets this copy as
     * items of RecyclerView
     */
    public void updateListAfterFilter() {
        OrderFragAdapter adapt = (OrderFragAdapter) rv.getAdapter();
        List<Order> orderCopy = new ArrayList<>(((OrderFragActivity) getActivity()).fetchedOrders);
        int iterator = 0;

        if(newerThan != null) {
            while(iterator != orderCopy.size() -1) {
                if(orderCopy.get(iterator).getDateCreated().getTime() < newerThan.getTime()) {
                    orderCopy.remove(iterator);
                    continue;
                }

                iterator++;
            }
        }

        if(olderThan != null) {
            iterator = 0;
            while(iterator != orderCopy.size() -1) {
                if(orderCopy.get(iterator).getDateCreated().getTime() > olderThan.getTime()) {
                    orderCopy.remove(iterator);
                    continue;
                }

                iterator++;
            }
        }

        adapt.setOrdersList(orderCopy);
        adapt.notifyDataSetChanged();
    }
}