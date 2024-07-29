package com.honey.medovka.model;


import android.graphics.Bitmap;

import androidx.annotation.NonNull;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Product implements Serializable, Cloneable {
    private List<Attribute> attributes = new ArrayList<>();

    //i wanted ID to be final, but i need to set it to assigned ID
    // after the product is inserted into DB
    private int id;
    private int price;
    private String name;
    private int stored;
    private int reserved;
    private int sold;
    private Bitmap image = null;
    private int orderCount;

    private boolean selected = false;

    public Product(int id, String name, int stored, int reserved, int sold) {
        this.id = id;
        this.name = name;
        this.stored = stored;
        this.reserved = reserved;
        this.sold = sold;

        this.price = -1;
    }

    public Product(int id, String name, int stored, int reserved, int sold, int price) {
        this.id = id;
        this.name = name;
        this.stored = stored;
        this.reserved = reserved;
        this.sold = sold;
        this.price = price;
    }

    public Product(int id, String name, int stored, int reserved, int sold, int price, Bitmap img) {
        this.id = id;
        this.name = name;
        this.stored = stored;
        this.reserved = reserved;
        this.sold = sold;
        this.price = price;
        this.image = img;
    }

    public String getName() {
        return name;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public List<Attribute> getAttributes() {
        return attributes;
    }

    public void addAttribute(Attribute at) {
        attributes.add(at);
    }

    public void alterNameAsCopy() {
        this.name = this.name + " (kopie)";
    }


    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    @NonNull
    @Override
    public Product clone() throws CloneNotSupportedException {
        //used to have clone with id -1, not sure why, but for db testing need actual ID
        Product p = new Product(id, this.name, 0, 0, 0, price, image);

        for(Attribute a : attributes) {
            p.addAttribute(a.clone());
        }

        return p;
    }

    public int getSold() {
        return sold;
    }

    public int getReserved() {
        return reserved;
    }

    public int getStored() {
        return stored;
    }

    public void addStored(int n) {
        if(n <= 0) return; //TODO some error?
        this.stored += n;
    }

    public int getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(int orderCount) {
        this.orderCount = orderCount;
    }

    public Bitmap getImage() {
        return image;
    }

    public void setImage(Bitmap image) {
        this.image = image;
    }

    public int getPrice() {
        return price;
    }

    public boolean subtractStored(int n) {
        if(stored < n) return false;
        stored -= n;
        return true;
    }

    public void increaseReserved(int n) {
        reserved += n;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setName(String name) {
        this.name = name;
    }

    //Following methods are meant for edit only

    public void removeAttribute(Attribute at) {
        for(int i = 0; i < attributes.size(); i++) {
            if(attributes.get(i).getId() == at.getId()) {
                attributes.remove(i);
                break;
            }
        }
    }

    public void replaceAttribute(Attribute at) {
        for(int i = 0; i < attributes.size(); i++) {
            if(attributes.get(i).getId() == at.getId()) {
                attributes.set(i, at);
                break;
            }
        }
    }

    public void orderSuccessAction() {
        this.stored -= orderCount;
        this.reserved += orderCount;
    }

    @NonNull
    @Override
    public String toString() {
        String out = "Produkt: " + name;
        out += "\n\tCena: " + price;
        out += "\n\tNa sklade: " + stored;
        out += "\n\tRezervovano: " + reserved;
        out += "\n\tProdano: " + sold;

        return out;
    }
}
