package com.honey.medovka.controllers;

import android.content.DialogInterface;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;

import android.text.format.DateFormat;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import com.honey.medovka.R;
import com.honey.medovka.model.Order;
import com.honey.medovka.model.Product;

/**
 * Controller handling Order Fragment Detail
 */
public class OrderDetailFrag extends Fragment {

    private static final String LOG_TAG = "OrderDetailFrag";

    public OrderDetailFrag() {
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
        return inflater.inflate(R.layout.fragment_order_detail, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final OrderFragActivity activity = (OrderFragActivity) this.getActivity();
        final Order clickedO = activity.getClickedOrder();
        final Fragment frag = this;

        //fragment title
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.order_detail));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        //hide buttons if the order isn't active, set button action otherwise
        if(activity.finished) {
            view.findViewById(R.id.odStorno).setVisibility(View.GONE);
            view.findViewById(R.id.odFinish).setVisibility(View.GONE);
        } else {
            view.findViewById(R.id.odStorno).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    cancelOrderAction(clickedO, frag, activity);
                }
            });
            view.findViewById(R.id.odFinish).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    finishOrderAction(clickedO, frag, activity);
                }
            });
        }

        //set static members
        ((TextView) view.findViewById(R.id.odValueID)).setText(clickedO.getId() + "");
        ((TextView) view.findViewById(R.id.odValueName)).setText(clickedO.getForName());
        ((TextView) view.findViewById(R.id.odValueCityP))
                .setText(clickedO.getCity() + ", " + clickedO.getPost());
        ((TextView) view.findViewById(R.id.odValueStreetHN))
                .setText(clickedO.getStreet() + ", " + clickedO.getHouseN());
        ((TextView) view.findViewById(R.id.odValueStatus))
                .setText(clickedO.isActive() ?
                        getString(R.string.active) : getString(R.string.finished));

        //checking created date shouldn't be necessary, but if --- appears
        // that means there is some error
        if(clickedO.getDateCreated().getTime() <= 0) {
            ((TextView) view.findViewById(R.id.odValueCreated)).setText("---");
        } else {
            ((TextView) view.findViewById(R.id.odValueCreated))
                    .setText(DateFormat.format("dd.MM.yyyy", clickedO.getDateCreated()));
        }

        if(clickedO.getDateFinished().getTime() <= 0) {
            ((TextView) view.findViewById(R.id.odValueFinished)).setText("---");
        } else {
            ((TextView) view.findViewById(R.id.odValueFinished))
                    .setText(DateFormat.format("dd.MM.yyyy", clickedO.getDateFinished()));
        }

        //adds products to table of ordered items
        if(clickedO.getProducts() == null || clickedO.getProducts().isEmpty()) {
            view.findViewById(R.id.odProductScroll).setVisibility(View.GONE);
        } else {
            for(Product p : clickedO.getProducts()) {
                addProductToTable(p);
            }
        }
    }

    /**
     * Adds row showing one ordered product to table
     * @param p Product
     */
    private void addProductToTable(Product p) {
        TableLayout pTable = this.getView().findViewById(R.id.odProductTable);

        TableRow row = (TableRow) LayoutInflater.from(this.getActivity()).
                inflate(R.layout.table_row_od_products, pTable, false);
        ((TextView) row.getChildAt(0)).setText(p.getName());
        ((TextView) row.getChildAt(1)).setText(p.getOrderCount() + "");

        pTable.addView(row);
    }

    /**
     * Button action that cancels the order. After a dialog the order is removed from DB
     * @param o Order
     * @param frag Fragment
     * @param act OrderFragActivity
     */
    private void cancelOrderAction(final Order o, final Fragment frag, final OrderFragActivity act){
        AlertDialog.Builder builder = new AlertDialog.Builder(this.getActivity());
        builder.setTitle(R.string.order_cancelation)
                .setMessage(R.string.order_cancelation_prompt)
                .setPositiveButton(R.string.yes, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        act.dbWrapper.updateOrderAsCanceled(o);
                        act.fetchedOrders.remove(o);
                        NavHostFragment.findNavController(frag).navigate(R.id.orders_det_to_list);
                        Toast.makeText(act, R.string.order_cancelation_success,
                                Toast.LENGTH_SHORT).show();
                    }
                })
                .setNegativeButton(R.string.no, null);
        builder.create().show();
    }

    /**
     * Button action that finishes the order. After dialog the order is updated as finished in DB.
     * @param o Order
     * @param frag Fragment
     * @param act OrderFragActivity
     */
    private void finishOrderAction(final Order o, final Fragment frag, final OrderFragActivity act){
        AlertDialog.Builder builder = new AlertDialog.Builder(this.getActivity());
        builder.setTitle(R.string.order_completion)
                .setMessage(R.string.order_completion_prompt)
                .setPositiveButton(R.string.yes, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        act.dbWrapper.updateOrderAsFinished(o);
                        act.fetchedOrders.remove(o);

                        NavHostFragment.findNavController(frag)
                                .navigate(R.id.orders_det_to_list);

//                        if(frag.getId() == R.id.or_det_frag) {
//                            NavHostFragment.findNavController(frag)
//                                    .navigate(R.id.orders_det_to_list);
//                        } else {
//                            Log.i(LOG_TAG, "I'm not navigating anywhere," +
//                                    " because im not in detail");
//                        }

                        Toast.makeText(act, R.string.order_completion_success,
                                Toast.LENGTH_SHORT).show();
                    }
                })
                .setNegativeButton(R.string.no, null);
        builder.create().show();
    }
}