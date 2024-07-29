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
import com.honey.medovka.model.ProductMenuAction;

/**
 * Controller handling Product Menu Fragment
 */
public class ProductMenuFrag extends Fragment {

    private static final String LOG_TAG = "ProductMenuFrag";


    public ProductMenuFrag() {
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
        return inflater.inflate(R.layout.fragment_product_menu, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        //fragment title
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.products));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        final PmFragActivity activity = (PmFragActivity) this.getActivity();

        //inits button navigation
        view.findViewById(R.id.pm_frag_show_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from ProductMenuFrag to " +
                        "ProductListFrag (show)");

                NavHostFragment.findNavController(ProductMenuFrag.this)
                        .navigate(R.id.frag_menu_to_list);
                activity.setAction(ProductMenuAction.SHOW);
            }
        });

        view.findViewById(R.id.pm_frag_copy_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from ProductMenuFrag to " +
                        "ProductListFrag (copy)");

                NavHostFragment.findNavController(ProductMenuFrag.this)
                        .navigate(R.id.frag_menu_to_list);
                activity.setAction(ProductMenuAction.COPY);
            }
        });

        view.findViewById(R.id.pm_frag_del_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from ProductMenuFrag to " +
                        "ProductListFrag (delete)");

                NavHostFragment.findNavController(ProductMenuFrag.this)
                        .navigate(R.id.frag_menu_to_list);
                activity.setAction(ProductMenuAction.REMOVE);
            }
        });

        view.findViewById(R.id.pm_frag_add_btn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View event) {
                Log.i(LOG_TAG, "Changing fragment from ProductMenuFrag to " +
                        "ProductAddition");

//                activity.dbWrapper.closeDatabase();
                Intent i = new Intent(activity, ProductAddition.class);
                startActivity(i);
            }
        });
    }
}