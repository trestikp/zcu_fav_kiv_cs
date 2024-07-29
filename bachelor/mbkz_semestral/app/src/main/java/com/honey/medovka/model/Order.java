package com.honey.medovka.model;

import android.util.Log;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Order
 */
public class Order implements Serializable {
    private static final String LOG_TAG = "Order";

    private final String forName;
    private int id;
    private final Date dateCreated;
    private final String city;
    private final String street;
    private final int houseN;
    private final int post;
    private boolean active;
    private Date dateFinished;
    private final List<Product> products;


    public Order(int id, String forName, String city, String street, int houseN,
                 int post, boolean active, Date creation, Date finish, List<Product> products) {
        this.id = id;
        this.forName = forName;
        this.city = city;
        this.street = street;
        this.houseN = houseN;
        this.post = post;
        this.active = active;
        this.dateCreated = creation;
        this.dateFinished = finish;
        this.products = products;
    }

/***************************************************************************************************
*                                                                                                  *
*            Accessors                                                                             *
*                                                                                                  *
***************************************************************************************************/

    public Date getDateFinished() {
        return dateFinished;
    }

    public void setDateFinished(Date dateFinished) {
        if(dateFinished.getTime() < dateCreated.getTime()) {
            Log.e(LOG_TAG, "Date finished is before creation");
            return;
        }
        this.dateFinished = dateFinished;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public String getForName() {
        return forName;
    }

    public String getCity() {
        return city;
    }

    public String getStreet() {
        return street;
    }

    public int getHouseN() {
        return houseN;
    }

    public int getPost() {
        return post;
    }

    public List<Product> getProducts() {
        return products;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    //this was originally meant for debug only, not sure if it works
    public void setID(int id) {
        this.id = id;
    }
}
