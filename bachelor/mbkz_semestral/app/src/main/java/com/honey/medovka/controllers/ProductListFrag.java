package com.honey.medovka.controllers;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.honey.medovka.R;
import com.honey.medovka.controllers.subcontrollers.ProductFragAdapter;
import com.honey.medovka.model.MedDatabaseHandler;
import com.honey.medovka.model.Product;
import com.honey.medovka.model.ProductMenuAction;

import java.util.List;

/**
 * Controller handling Product List Fragment
 */
public class ProductListFrag extends Fragment {

    private static final String LOG_TAG = "ProductListFrag";

    public ProductListFrag() {
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
        return inflater.inflate(R.layout.fragment_product_list, container, false);
    }

    @Override
    public void onViewCreated(@NonNull final View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        final PmFragActivity activity = (PmFragActivity) this.getActivity();
        final Fragment frag = this;

        ProductMenuAction action = activity.getAction();
        setTitle(action);

        if(action == ProductMenuAction.COPY || action == ProductMenuAction.REMOVE) {
            view.findViewById(R.id.plHeaderStock).setVisibility(View.GONE);
        }

        RecyclerView productRV = view.findViewById(R.id.productRecyclerView);

        List<Product> list = activity.dbWrapper.fetchProductsWithAttributes();
        if(list == null) {
            view.findViewById(R.id.plNoProductsLabel).setVisibility(View.VISIBLE);
            return;
        }

        final ProductFragAdapter adapter =
                new ProductFragAdapter(list, action, activity, this);
        productRV.setAdapter(adapter);

        view.findViewById(R.id.removeSelectedBtn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                removeSelectedAction(adapter, activity.dbWrapper, view, frag);
            }
        });
    }

    /**
     * Sets tile according to Action
     * @param action ProductMenuAction (determines title)
     */
    private void setTitle(ProductMenuAction action) {
        ActionBar ab =  ((AppCompatActivity) this.getActivity()).getSupportActionBar();
        if(ab != null) {
            switch (action) {
                case COPY: ab.setTitle(getString(R.string.product_copy));
                    break;
                case SHOW: ab.setTitle(getString(R.string.product_browsing));
                    break;
                case REMOVE: ab.setTitle(getString(R.string.product_deletion));
                    break;
                default: ab.setTitle(getString(R.string.default_list));
            }
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }
    }

    /**
     * Method handling removal of selected items
     * @param adapter ProductFragAdapter
     * @param dbWrapper MedDatabaseHandler
     * @param view View
     * @param frag Fragment
     */
    public void removeSelectedAction(final ProductFragAdapter adapter,
                                     final MedDatabaseHandler dbWrapper,
                                     final View view,
                                     final Fragment frag) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this.getActivity());
        builder.setMessage(getString(R.string.product_removal_prompt))
                .setPositiveButton(getString(R.string.delete), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        List<Product> selected = adapter.getSelectedProducts();
                        for(Product pr : selected) {
                            dbWrapper.deleteProduct(pr);
                        }

                        view.findViewById(R.id.removeSelectedBtn).setVisibility(View.GONE);
                        NavHostFragment.findNavController(frag).navigate(R.id.frag_list_to_menu);
                        Toast.makeText(frag.getActivity(),
                                getString(R.string.products_successfully_deleted),
                                Toast.LENGTH_LONG).show();
                    }
                })
                .setNegativeButton(getString(R.string.cancel), null);
        builder.create().show();
    }
}