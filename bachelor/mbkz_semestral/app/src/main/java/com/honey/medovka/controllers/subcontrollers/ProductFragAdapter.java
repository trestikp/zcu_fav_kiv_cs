package com.honey.medovka.controllers.subcontrollers;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;
import androidx.recyclerview.widget.RecyclerView;

import com.honey.medovka.R;
import com.honey.medovka.controllers.PmFragActivity;
import com.honey.medovka.model.Product;
import com.honey.medovka.model.ProductMenuAction;

import java.util.ArrayList;
import java.util.List;

/**
 *  Adapter for RecyclerView used in ProductListFrag. Handles RecyclerView data and visuals
 */
public class ProductFragAdapter extends RecyclerView.Adapter<ProductFragAdapter.ProductViewHolder> {

    /** List of products */
    private final List<Product> products;
    /** Action which determines what list is loaded and events */
    private final ProductMenuAction action;
    private final PmFragActivity activity;
    private final Fragment fragment;


    /**
     * Constructor initializing attributes
     * @param products List<Product>
     * @param action ProductMenuAction
     * @param activity PmFragActivity
     * @param fragment Fragment
     */
    public ProductFragAdapter(List<Product> products, ProductMenuAction action,
                              PmFragActivity activity, Fragment fragment) {
        this.products = products;
        this.action = action;
        this.activity = activity;
        this.fragment = fragment;
    }


    @NonNull
    @Override
    public ProductViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        int resource;

        if(action == ProductMenuAction.REMOVE) {
            resource = R.layout.product_list_selection_item;
        } else {
            resource = R.layout.product_list_item;
        }

        return new ProductViewHolder(
                LayoutInflater.from(parent.getContext()).inflate(
                        resource, parent, false), action, activity, fragment
        );
    }

    @Override
    public void onBindViewHolder(@NonNull ProductViewHolder holder, int position) {
        holder.bindProduct(products.get(position));
        holder.styleProduct(position);
    }

    @Override
    public int getItemCount() {
        return products.size();
    }

    /**
     * Get products selected in a list
     * @return List<Product> of selected products
     */
    public List<Product> getSelectedProducts() {
        List<Product> res = new ArrayList<>();

        for(Product pr : products) {
            if(pr.isSelected()) res.add(pr);
        }

        return res;
    }

    /**
     * Class handling product adapter view
     */
    class ProductViewHolder extends RecyclerView.ViewHolder {
        /** View items */
        ConstraintLayout itemParent;
        TextView productName;
        TextView productStored;
        TextView productReserved;
        TextView productSold;
        CheckBox productCB;

        /** attribute forwarded from adapter */
        ProductMenuAction action;
        PmFragActivity activity;
        Fragment fragment;

        /**
         * Initis attributes
         * @param itemView View
         * @param action ProductMenuAction
         * @param activity PmFragActivity
         * @param fragment Fragment
         */
        public ProductViewHolder(@NonNull View itemView, ProductMenuAction action,
                                 PmFragActivity activity, Fragment fragment)
        {
            super(itemView);

            this.action = action;

            productName = itemView.findViewById(R.id.productName);
            itemParent = itemView.findViewById(R.id.itemParent);

            if(action == ProductMenuAction.SHOW) {
                productStored = itemView.findViewById(R.id.productStored);
                productStored.setVisibility(View.VISIBLE);
//            productReserved = itemView.findViewById(R.id.productReserved);
//            productSold = itemView.findViewById(R.id.productSold);
            }

            productCB = itemView.findViewById(R.id.productCheckBox);

            this.activity = activity;
            this.fragment = fragment;
        }

        /**
         * Binds product to View and sets up click events
         * @param pr Product
         */
        public void bindProduct(final Product pr) {
            productName.setText(pr.getName());
            if(action == ProductMenuAction.SHOW) {
                productStored.setText(pr.getStored() + "");
//            productReserved.setText(pr.getReserved() + "");
//            productSold.setText(pr.getSold() + "");4
            }

            itemParent.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(productCB != null) {
                        onClickSelect(pr);
                    }

                    switch (action) {
                        case COPY: copyItemAction(pr);
                            break;
                        case REMOVE: removeItemAction();
                            break;
                        case SHOW: showProductDetail(pr);
                            break;
                    }
                }
            });

            if(productCB != null) {
                if(pr.isSelected()) {
                    productCB.setChecked(true);
                } else {
                    productCB.setChecked(false);
                }

                productCB.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        onClickSelect(pr);
                        if(action == ProductMenuAction.REMOVE) {
                            removeItemAction();
                        }
                    }
                });
            }
        }

        /**
         * Alternates between 2 background colors of odd and even items
         * @param pos int
         */
        public void styleProduct(int pos) {
            if(pos % 2 == 1) {
                itemParent.setBackgroundColor(Color.parseColor("#80FF9900"));
            } else {
                itemParent.setBackgroundColor(Color.parseColor("#80D8D813"));
            }
        }

        /**
         * Sets View checkbox to selected/ not selected
         * @param pr clicked Product
         */
        private void onClickSelect(Product pr) {
            if(pr.isSelected()) {
                productCB.setChecked(false);
                pr.setSelected(false);
            } else {
                productCB.setChecked(true);
                pr.setSelected(true);
            }
        }

        /**
         * Method handling COPY event
         * @param pr Product
         */
        private void copyItemAction(final Product pr) {
            AlertDialog.Builder builder = new AlertDialog.Builder(activity);
            String prompt = activity.getString(R.string.copy_prompt);
            String btnText = activity.getString(R.string.do_copy);
            final String copySuccess = activity.getString(R.string.product_copy_success);
            String btnCancel = activity.getString(R.string.cancel);

            builder.setMessage(prompt + " " + pr.getName())
                    .setPositiveButton(btnText, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            PmFragActivity act = (PmFragActivity) fragment.getActivity();
                            try {
                                Product copy = pr.clone();
                                copy.alterNameAsCopy();

                                if(copy.getImage() == null) {
                                    Bitmap b = act.getDbWrapper().
                                            fetchProductImage(pr);
                                    copy.setImage(b);
                                }

                                act.getDbWrapper().insertNewProduct(copy);
                                act.setClickedItem(copy);
                                NavHostFragment.findNavController(fragment)
                                        .navigate(R.id.frag_list_to_edit);
//                                NavHostFragment.findNavController(fragment)
//                                        .navigate(R.id.frag_list_to_menu);
                                Toast.makeText(activity, copySuccess,
                                        Toast.LENGTH_LONG).show();
                            } catch (CloneNotSupportedException e) {
                                e.printStackTrace();
                            }
                        }
                    })
                    .setNegativeButton(btnCancel, null);
            builder.create().show();
        }

        /**
         * Method handling REMOVE event
         */
        private void removeItemAction() {
            if(getSelectedProducts().size() > 0) {
                activity.findViewById(R.id.removeSelectedBtn).setVisibility(View.VISIBLE);
            } else {
                activity.findViewById(R.id.removeSelectedBtn).setVisibility(View.GONE);
            }
        }

        /**
         * Method handling SHOW event
         * @param pr
         */
        private void showProductDetail(Product pr) {
            ((PmFragActivity) this.fragment.getActivity()).setClickedItem(pr);
            NavHostFragment.findNavController(fragment).navigate(R.id.frag_list_to_det);
        }
    }
}