package com.honey.medovka.controllers.subcontrollers;

import android.graphics.Color;
import android.text.format.DateFormat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.fragment.NavHostFragment;
import androidx.recyclerview.widget.RecyclerView;

import com.honey.medovka.R;
import com.honey.medovka.controllers.OrderFragActivity;
import com.honey.medovka.model.Order;

import java.util.List;

/**
 * Adapter for RecyclerView used in OrderListFrag. Handles RecyclerView data and visuals
 */
public class OrderFragAdapter extends RecyclerView.Adapter<OrderFragAdapter.OrderViewHolder> {

    /** Item list */
    private List<Order> orders;
    /** Acitivty where adapter is created */
    private OrderFragActivity activity;
    /** Fragment where adapter is created */
    private Fragment fragment;

    /**
     * Constructor initializing adapter
     * @param orders List<Order>
     * @param activity OrderFragActivity
     * @param fragment Fragment
     */
    public OrderFragAdapter(List<Order> orders, OrderFragActivity activity, Fragment fragment) {
        this.orders = orders;
        this.activity = activity;
        this.fragment = fragment;
    }

    @NonNull
    @Override
    public OrderViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new OrderFragAdapter.OrderViewHolder(
                LayoutInflater.from(activity)
                        .inflate(R.layout.order_item, parent, false),
                activity, fragment
        );
    }

    @Override
    public void onBindViewHolder(@NonNull OrderViewHolder holder, int position) {
        holder.bindProduct(orders.get(position));
        holder.styleProduct(position);
    }

    @Override
    public int getItemCount() {
        return orders.size();
    }

    /**
     * Sets order list to a new one. Used for filtering
     * @param orders
     */
    public void setOrdersList(List<Order> orders) {
        this.orders = orders;
    }

    /**
     * Inner class handling view of item
     */
    static class OrderViewHolder extends RecyclerView.ViewHolder {

        /** View items */
        LinearLayout oItemParent;
        TextView oID;
        TextView oDate;
        TextView oForName;

        /** Activity and fragment */
        OrderFragActivity activity;
        Fragment fragment;

        /**
         * Constructor initializing activity, fragment and view items
         * @param itemView View
         * @param activity OrderFragActivity
         * @param fragment Fragment
         */
        public OrderViewHolder(@NonNull View itemView, OrderFragActivity activity,
                               Fragment fragment) {
            super(itemView);

            oItemParent = itemView.findViewById(R.id.oItemParent);
            oID = itemView.findViewById(R.id.oID);
            oDate = itemView.findViewById(R.id.oDate);
            oForName = itemView.findViewById(R.id.oForName);

            this.activity = activity;
            this.fragment = fragment;
        }

        /**
         * Binds product to graphics
         * @param or product
         */
        public void bindProduct(final Order or) {
            oID.setText(String.valueOf(or.getId()));
            oForName.setText(or.getForName());
            oDate.setText(DateFormat.format("dd.MM.yyyy", or.getDateCreated()));

            oItemParent.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    activity.setClickedOrder(or);
                    NavHostFragment.findNavController(fragment).navigate(R.id.orders_list_to_det);
                }
            });

        }

        /**
         * Alternates between 2 background colors of odd and even items
         * @param pos int
         */
        public void styleProduct(int pos) {
            if(pos % 2 == 1) {
                oItemParent.setBackgroundColor(Color.parseColor("#80FF9900"));
            } else {
                oItemParent.setBackgroundColor(Color.parseColor("#80D8D813"));
            }
        }
    }
}
