package com.honey.medovka.controllers;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.honey.medovka.R;

/**
 * Controller for Order Menu Fragment
 */
public class OrderMenuFrag extends Fragment {

    private static final String LOG_TAG = "OrderMenuFrag";


    public OrderMenuFrag() {
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
        return inflater.inflate(R.layout.fragment_order_menu, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final OrderFragActivity activity = (OrderFragActivity) this.getActivity();

        //fragment title
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.orders));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        view.findViewById(R.id.om_frag_active_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from OrderMenuFrag to " +
                        "OrderListFrag (show)");

                NavHostFragment.findNavController(OrderMenuFrag.this)
                        .navigate(R.id.orders_menu_to_list);
                activity.finished = false;
            }
        });
        view.findViewById(R.id.om_frag_completed_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from OrderMenuFrag to " +
                        "OrderListFrag (show)");

                NavHostFragment.findNavController(OrderMenuFrag.this)
                        .navigate(R.id.orders_menu_to_list);
                activity.finished = true;
            }
        });
        view.findViewById(R.id.om_frag_create_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from OrderMenuFrag to " +
                        "OrderCreation activity");

                Intent i = new Intent(activity, OrderCreation.class);
                startActivity(i);
            }
        });
    }
}