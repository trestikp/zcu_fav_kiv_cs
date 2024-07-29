package com.honey.medovka.model;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.graphics.Bitmap;
import android.util.Log;

import com.honey.medovka.R;
import com.honey.medovka.functions.Utils;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Database wrapper. Gives access to methods manipulating DB.
 */
public final class MedDatabaseHandler {

    private static MedDatabaseHandler INSTANCE;
    public static MedDatabaseHandler getInstance() {
        return INSTANCE;
    }

    private static final String LOG_TAG = "MedDatabaseHandler";

    private final long creationTime;
    private final SQLiteDatabase database;
    private final MedDatabaseHelper dbHelper;


    public MedDatabaseHandler(Context context, boolean readOnly) {
        creationTime = System.currentTimeMillis();
        Log.i(LOG_TAG, "Creating DBHandler at time: " + creationTime);

        dbHelper = new MedDatabaseHelper(context);
        database = dbHelper.getWritableDatabase();

        //db initialization (some data are randomly generated for testing purposes)
        if(MedDatabaseHelper.CREATING) {
            for (Attribute at : prepareAttributes()) {
                insertAttribute(at);
            }

            for (Product p : prepareProducts(context)) {
                insertNewProduct(p);
            }
        }

        if(MedDatabaseHelper.DEBUG) {
            createFakeOrders();
        }

        INSTANCE = this;
    }

    /**
     * Initializes Attributes
     * @return List<Attribute>
     */
    private List<Attribute> prepareAttributes() {
        List<Attribute> out = new ArrayList<>();

//        out.add(new Attribute(-1, AttributeType.NUMBER.index,
//                "Celková hmotnost", null));
        out.add(new Attribute(-1, AttributeType.NUMBER.index,
                "Hmotnost sklenice", null, "g"));
        out.add(new Attribute(-1, AttributeType.NUMBER.index,
                "Množství medu", null, "ml"));
        out.add(new Attribute(-1, AttributeType.NUMBER.index,
                "Objem", null, "ml"));
        out.add(new Attribute(-1, AttributeType.NUMBER.index,
                "Výška", null, "cm"));
        out.add(new Attribute(-1, AttributeType.NUMBER.index,
                "Kusů na paletě", null));

        Attribute a = new Attribute(-1, AttributeType.ENUM.index,
                "Sklenice", null);
        a.initEmptyEnumValues();
        a.getEnumValues().add("Glas 65");
        a.getEnumValues().add("Amfora 145");
        a.getEnumValues().add("Jaroslav");
        a.getEnumValues().add("Orcio 212");
        a.getEnumValues().add("Orcio 314");
        a.getEnumValues().add("Včela 730");
        a.getEnumValues().add("Medvěd 100");
        a.getEnumValues().add("Medvěd 180");
        a.getEnumValues().add("Medvěd 280");
        out.add(a);

        a = new Attribute(-1, AttributeType.ENUM.index,
                "Víčko", null);
        a.initEmptyEnumValues();
        a.getEnumValues().add("TO 43 Zlaté RTO TPE");
        a.getEnumValues().add("TO 43 stříbrné RTO R47");
        a.getEnumValues().add("TO 53 zlaté RTS R47");
        a.getEnumValues().add("TO 53 zlaté RSB R47");
        a.getEnumValues().add("TO 63 zlaté RTS R47");
        a.getEnumValues().add("TO 66 včelí plást RTS R47");
        a.getEnumValues().add("TO 66 ošatka RTS R47");
        a.getEnumValues().add("TO 66 zlaté RTS R47");
        out.add(a);

        a = new Attribute(-1, AttributeType.ENUM.index,
                "Uskladnění", null);
        a.initEmptyEnumValues();
        a.getEnumValues().add("Paleta");
        a.getEnumValues().add("Bedna");
        out.add(a);

        return out;
    }

    /**
     * Initializes products which are defaults of the database
     * @param context Context for access to resources
     * @return List<Product>
     */
    private List<Product> prepareProducts(Context context) {
        List<Product> out = new ArrayList<>();
        Bitmap d;

        List<Attribute> al = fetchAllAttributes();

        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.boruvka_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Borůvkáč",//1
                40, 0, 0, 80, d));
        al.get(0).setAttValue("20");
        out.get(0).addAttribute(al.get(0));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.cerny_rybiz_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Černorybízák",//2
                40, 0, 0, 75, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.jahoda_sklenice_uai_720x720);
        out.add(new Product(-1, "Kozákův Jahoďák",//3
                40, 0, 0, 75, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.malina_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Malináč",//4
                40, 0, 0, 75, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.ostropestrec_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Ostropestřák",//5
                40, 0, 0, 80, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.ostruzina_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Ostružiňák",//6
                40, 0, 0, 85, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.rakytnik_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Rakytňák",//7
                40, 0, 0, 85, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.zazvor_sklenice_uai_1032x1032);
        out.add(new Product(-1, "Kozákův Zázvoráč",//8
                40, 0, 0, 85, d));

        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.kvetovy_med_230g);
        out.add(new Product(-1, "Květový med - 230g",//9
                40, 0, 0, 100, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.kvetovy_med_450g);
        out.add(new Product(-1, "Květový med - 450g",//10
                40, 0, 0, 130, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.medovicovy_med_230g);
        out.add(new Product(-1, "Medovicový med - 230g",//11
                40, 0, 0, 145, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.medovicovy_med_450g);
        out.add(new Product(-1, "Medovicový med - 450g",//12
                40, 0, 0, 180, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.pastovy_med_230g);
        out.add(new Product(-1, "Pastový med - 230g",//13
                40, 0, 0, 100, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.pastovy_med_450g);
        out.add(new Product(-1, "Pastový med - 450g",//14
                40, 0, 0, 130, d));

        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.orechy_v_medu_180g);
        out.add(new Product(-1, "Vlašské ořechy v medu 180g",//15
                40, 0, 0, 130, d));
        d = Utils.getDrawableAsBitmap(context.getResources(),
                R.drawable.orechy_v_medu_75g);
        out.add(new Product(-1, "Vlašské ořechy v medu 75g",//16
                40, 0, 0, 70, d));

        return out;
    }

    /**
     * Generates some random products for order
     * @param selection All products from which can be chosen
     * @return List<Product>
     */
    private List<Product> generateFewRandomProducts(List<Product> selection) {
        List<Product> out = new ArrayList<>();
        Random rd = new Random();
        int pCount = rd.nextInt(3) + 1;

        for(int i = 0; i < pCount; i++) {
            int index = rd.nextInt(selection.size()); //Can generate same index twice but w/e
            int sum = rd.nextInt(4) + 1;

            //not enough stored => generate again
            if(selection.get(index).getStored() < sum) {
                i--;
                continue;
            }

            try {
                Product p = selection.get(index).clone();
                p.setOrderCount(sum);
                out.add(p);
            } catch (CloneNotSupportedException e) {
                e.printStackTrace();
            }

        }

        return out;
    }

    /**
     * Initializes some fake orders for testing, uses method above
     */
    private void createFakeOrders() {
        Calendar c = Calendar.getInstance();
        c.set(2021, 6, 7);
        long time1 = c.getTime().getTime();
        c.set(2021, 6, 6);
        long time2 = c.getTime().getTime();
        c.set(2020, 11, 2);
        long time3 = c.getTime().getTime();

        List<Product> all = fetchAvailableProducts();
        List<Product> asdf = generateFewRandomProducts(all);
        Order o = new Order(-1, "Pepa Horecny", "Praha", "Palackeho", 1, 55555, true, new Date(), null, asdf);
        insertOrder(o);
        asdf = generateFewRandomProducts(all);                                                                                      // 6.6.2021 -1622995052
        o = new Order(-1, "Franta Pisek", "Brno", "Parizska", 2, 55554, true, new Date(time2), null, asdf);
        insertOrder(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Ema Wainer", "Briza", "Hlavni", 3, 55455, true, new Date(), null, asdf);
        insertOrder(o);
        updateOrderAsFinished(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Zaneta Novakova", "Plzen", "Klatovska", 4, 55444, true, new Date(), null, asdf);
        insertOrder(o);
        updateOrderAsFinished(o);
        asdf = generateFewRandomProducts(all);                                                                                      // 7.6.2021 - 1623081452
        o = new Order(-1, "Skyler Lloyd", "New York", "Main", 5, 92405, true, new Date(time1), null, asdf);
        insertOrder(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Akira Pollar", "Co", "Javim", 111, 72134, true, new Date(), null, asdf);
        insertOrder(o);
        updateOrderAsFinished(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Natalee Savage", "Oregano", "Neco", 7, 12308, true, new Date(), null, asdf);
        insertOrder(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Damian Cannon", "Origano", "Neco 2", 411, 12039, true, new Date(), null, asdf);
        insertOrder(o);
        updateOrderAsFinished(o);
        asdf = generateFewRandomProducts(all);                                                                                          // 2.11.2020 - 1622995052
        o = new Order(-1, "Jasse Robbins", "Imaginary", "Rand", 420, 57498, true, new Date(time3), null, asdf);
        insertOrder(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Ryland Mathis", "Duck", "OmSh", 69, 10000, true, new Date(), null, asdf);
        insertOrder(o);
        updateOrderAsFinished(o);
        asdf = generateFewRandomProducts(all);
        o = new Order(-1, "Judah McKee", "Cmon", "Itty", 333, 66666, true, new Date(), null, asdf);
        insertOrder(o);
    }

/***************************************************************************************************
*                                                                                                  *
*            Deletes                                                                               *
*                                                                                                  *
***************************************************************************************************/

    /**
     * Delete product with its "attributes" (bonds)
     * @param pr Product to be deleted
     */
    public void deleteProduct(Product pr) {
        try {
            database.execSQL("DELETE FROM product_attributes WHERE product_id = " + pr.getId());
            database.execSQL("DELETE FROM products WHERE p_id = " + pr.getId());
            pr = null; //"free" product
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes only products bond to attribute
     * @param pID product id
     * @param aID attribute id
     * @return success boolean
     */
    public boolean deleteProductAttributeBond(final int pID, final int aID) {
        try {
            database.execSQL("DELETE FROM product_attributes " +
                             "WHERE product_id = " + pID + " AND attribute_id = " + aID + ";");
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL ERROR deleting product attribute bond.\n" + e.getMessage());
            return false;
        }
    }

/***************************************************************************************************
*                                                                                                  *
*            Selects                                                                               *
*                                                                                                  *
***************************************************************************************************/

    /**
     * Fetches all products and their information and stores them in a list. Does NOT fetch
     * attributes.
     * @return ArrayList\<Product\>
     */
    private List<Product> fetchProducts() {
        List<Product> out = new ArrayList<>();
        final String sql = "SELECT p_id,p_name,p_count,p_reserved,p_sold, p_price FROM products;";

        Cursor c =  database.rawQuery(sql,null);
        c.moveToFirst();

        if(c.getCount() == 0) {
            Log.e(LOG_TAG, "Failed to fetch products or products are empty");
            return null;
        }

        try {
            do {
                out.add(new Product(
                        c.getInt(c.getColumnIndexOrThrow("p_id")),
                        c.getString(c.getColumnIndexOrThrow("p_name")),
                        c.getInt(c.getColumnIndexOrThrow("p_count")),
                        c.getInt(c.getColumnIndexOrThrow("p_reserved")),
                        c.getInt(c.getColumnIndexOrThrow("p_sold")),
                        c.getInt(c.getColumnIndexOrThrow("p_price"))
                ));
            } while (c.moveToNext());
        } catch (IllegalArgumentException e) {
            Log.e(LOG_TAG, "Failed to fetch product(s) because column name wasn't found");
        }

        c.close();

        return out;
    }

    /**
     * Calls fetchProducts() and then fetches their attributes
     * @return ArrayList\<Product\> of products with their attributes
     */
    public List<Product> fetchProductsWithAttributes() {
        if(database == null || !database.isOpen()) {
            Log.e(LOG_TAG, "Cannot fetch products, because the DB is closed or NULL");
            return null;
        }

        List<Product> out = fetchProducts();
        if(out == null) {
            return null;
        }

        final String sql = "SELECT product_attributes.*,attributes.*" +
                "FROM attributes, product_attributes " +
                "WHERE attribute_id = a_id;";

        Cursor c =  database.rawQuery(sql, null);
        c.moveToFirst();

        if(c.getCount() == 0) {
            Log.i(LOG_TAG, "Failed to fetch attributes or product has no attributes");
            return out;
        }

        try {
            do {
                Attribute a = new Attribute(
                        c.getInt(c.getColumnIndexOrThrow("a_id")),
                        c.getInt(c.getColumnIndexOrThrow("a_type")),
                        c.getString(c.getColumnIndexOrThrow("a_name")),
                        c.getString(c.getColumnIndexOrThrow("value")),
                        c.getString(c.getColumnIndexOrThrow("a_units"))
                );

                for(Product p : out) {
                    if(p.getId() == c.getInt(c.getColumnIndexOrThrow("product_id"))) {
                        p.addAttribute(a);
                        break;
                    }
                }
            } while (c.moveToNext());
        } catch (IllegalArgumentException e) {
            Log.e(LOG_TAG, "Failed to fetch attribute(s) because column name wasn't found");
        }

        System.out.println();

        c.close();

        return out;
    }

    /**
     * Fetches products which have >0 stored. Doesn't fetch attributes and most unnecessary values.
     * Fetches id, count stored, name, price
     * @return list of selected products
     */
    public List<Product> fetchAvailableProducts() {
        List<Product> out = new ArrayList<>();
        final String sql = "SELECT p_id,p_name,p_count,p_price,p_reserved,p_sold " +
                           "FROM products " +
                           "WHERE p_count > 0;";

        Cursor c =  database.rawQuery(sql,null);
        c.moveToFirst();

        if(c.getCount() == 0) {
            Log.i(LOG_TAG, "There are no available products/ error fetching products");
            return null;
        }

        try {
            do {
                out.add(new Product(
                        c.getInt(c.getColumnIndexOrThrow("p_id")),
                        c.getString(c.getColumnIndexOrThrow("p_name")),
                        c.getInt(c.getColumnIndexOrThrow("p_count")),
                        c.getInt(c.getColumnIndexOrThrow("p_reserved")),
                        c.getInt(c.getColumnIndexOrThrow("p_sold")),
                        c.getInt(c.getColumnIndexOrThrow("p_price"))
                ));
            } while (c.moveToNext());
        } catch (IllegalArgumentException e) {
            Log.e(LOG_TAG, "Failed to fetch product(s) because column name wasn't found");
            return null;
        }

        c.close();

        return out;
    }

    /**
     * Fetches image (Bitmap) (stored as blobl) of Product from database
     * @param p Product
     * @return Bitmap
     */
    public Bitmap fetchProductImage(Product p) {
        String sql = "SELECT p_img FROM products WHERE p_id = " + p.getId() + ";";

        try {
            Cursor c = database.rawQuery(sql, null);
            c.moveToFirst();
            byte[] data = c.getBlob(c.getColumnIndexOrThrow("p_img"));
            c.close();

            //at least 50 bytes for image
            if(data == null || data.length < 50) {
                return null;
            }

            return Utils.binaryToBitmap(data);
        } catch (IllegalArgumentException e1) {
            Log.e(LOG_TAG, "SQL product image SELECT error." +
                    " (Column not found)\n" + e1.getMessage());
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL product image SELECT error.\n" + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Fetches products of and Order with oID
     * @param oID Order ID
     * @return List<Product>
     */
    private List<Product> fetchOrderedProducts(int oID) {
        List<Product> out = new ArrayList<>();

        // cols: id, order_id, product_id
        String sql = "SELECT p.*, op.op_count FROM products p " +
                    "JOIN order_products op ON op.product_id = p.p_id " +
                    "JOIN orders o ON op.order_id = o.o_id WHERE o.o_id = " + oID + ";";

        Cursor c;
        try {
            c =  database.rawQuery(sql,null);
        } catch (Exception e) {
            System.err.println("SQL SELECT failed to fetch ordered products.\n" + e.getMessage());
            return null;
        }
        c.moveToFirst();

        // ordered products mustn't be 0! order must have at least 1 product ordered -> error
        if (c.getCount() == 0) {
            Log.e(LOG_TAG, "Failed to fetched ordered products");
            return null;
        }

        try {
            do {
                Product p = new Product(
                        c.getInt(c.getColumnIndexOrThrow("p_id")),
                        c.getString(c.getColumnIndexOrThrow("p_name")),
                        c.getInt(c.getColumnIndexOrThrow("p_count")),
                        c.getInt(c.getColumnIndexOrThrow("p_reserved")),
                        c.getInt(c.getColumnIndexOrThrow("p_sold")));
                p.setOrderCount(c.getInt(c.getColumnIndexOrThrow("op_count")));
                out.add(p);
            } while (c.moveToNext());
        } catch (IllegalArgumentException e) {
            Log.e(LOG_TAG, "Failed to fetch product(s) because column name wasn't found");
            return null;
        }

        c.close();

        return out;
    }

    /**
     * Fetches active/ finished orders, based on parameter
     * @param active boolean active = true => fetches active orders
     * @return List<Order>
     */
    public List<Order> fetchOrders(boolean active) {
        List<Order> out = new ArrayList<>();

        Cursor c;
        try {
            c = database.rawQuery("SELECT * FROM orders WHERE o_active = " + (active ? 1 : 0)
                                       + ";", null);
        } catch (Exception e) {
            System.err.println("Failed to execute SQL to fetch orders");
            e.printStackTrace();
            return null;
        }

        if(c.getCount() == 0) {
            Log.i(LOG_TAG, "Failed to fetch orders/ orders are empty");
            return null;
        }

        try {
            c.moveToFirst();
            do {
                int oID = c.getInt(c.getColumnIndexOrThrow("o_id"));

                List<Product> products = fetchOrderedProducts(oID);
                //cols: o_id, o_name, o_city, o_street, o_housenumber,
                //      o_psc, o_active, o_start_date, o_fin_date
                Order o = new Order(
                        oID,
                        c.getString(c.getColumnIndexOrThrow("o_name")),
                        c.getString(c.getColumnIndexOrThrow("o_city")),
                        c.getString(c.getColumnIndexOrThrow("o_street")),
                        c.getInt(c.getColumnIndexOrThrow("o_housenumber")),
                        c.getInt(c.getColumnIndexOrThrow("o_psc")),
                        c.getInt(c.getColumnIndexOrThrow("o_active")) > 0,
                        new Date(c.getLong(c.getColumnIndexOrThrow("o_start_date"))),
                        new Date(c.getLong(c.getColumnIndexOrThrow("o_fin_date"))),
                        products
                );
                out.add(o);
            } while (c.moveToNext());

            c.close();
        } catch (IllegalArgumentException e) {
            Log.e(LOG_TAG, "Failed to fetch order(s) because column name wasn't found");
        }

        return out;
    }

    /**
     * Fetches all attributes and their possible values (for ENUM). Select is independent
     * of products, therefore attributes don't have selected value (value is null)
     * @return
     */
    public List<Attribute> fetchAllAttributes() {
        List<Attribute> out = new ArrayList<>();

        Cursor c;
        try {
            c = database.rawQuery("SELECT * FROM attributes;", null);
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL SELECT failed to fetch attributes.\n" + e.getMessage());
            return null;
        }

        if(c.getCount() == 0) {
            Log.e(LOG_TAG, "Fetched 0 attributes");
            return null;
        }

        c.moveToFirst();
        do {
            Attribute at = new Attribute(
                    c.getInt(c.getColumnIndexOrThrow("a_id")),
                    c.getInt(c.getColumnIndexOrThrow("a_type")),
                    c.getString(c.getColumnIndexOrThrow("a_name")),
                    (String) null,
                    c.getString(c.getColumnIndexOrThrow("a_units")));
            //if attribute is enum, fetch possible values
            if(at.getType() == AttributeType.ENUM.index) {
                List<String> enums = fetchEnumValues(at.getId());
                if(enums == null) {
                    Log.e(LOG_TAG, "Failed to fetch enum values");
                } else {
                    at.setEnumValues(enums);
                }
            }
            out.add(at);
        } while(c.moveToNext());

        c.close();

        return out;
    }

    /**
     * Fetched values of attribute with type ENUM
     * @param attId attribute ID
     * @return String list of values
     */
    private List<String> fetchEnumValues(final int attId) {
        List<String> out = new ArrayList<>();

        try {
            Cursor c = database.rawQuery("SELECT * FROM enum_vals " +
                    "WHERE e_att_id = " + attId + ";", null);
            c.moveToFirst();

            if(c.getCount() == 0) {
                Log.e(LOG_TAG, "Failed to fetch enum values/ 0 enum values");
                return null;
            }

            do {
                out.add(c.getString(c.getColumnIndexOrThrow("e_name")));
            } while (c.moveToNext());

            c.close();
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL SELECT failed to fetch enum values.\n" + e.getMessage());
            return null;
        }

        return out;
    }

/***************************************************************************************************
*                                                                                                  *
*            Updates                                                                               *
*                                                                                                  *
***************************************************************************************************/

    /**
     * Updates p_count column (products stored)
     * @param pr product which is updated
     * @return boolean success
     */
    public boolean updateProductStored(Product pr) {
        try {
            database.execSQL("UPDATE products SET p_count = " + pr.getStored() +
                    " WHERE p_id = " + pr.getId() + ";");
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error on product stored count.\n" + e.getMessage());
//            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates p_count and p_reserved columns, called on new order creation
     * @param pr product which is updated
     * @return boolean success
     */
    public boolean updateProductOrdered(Product pr) {
        try {
            database.execSQL("UPDATE products " +
                             "SET p_count = p_count - " + pr.getOrderCount() + ", " +
                             "p_reserved = p_reserved + " + pr.getOrderCount() +
                             " WHERE p_id = " + pr.getId() + ";");
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error on product stored count.\n" + e.getMessage());
            return false;
        }
    }

    /**
     * Update values of orders and products so order is considered finished
     * @param o ORder that is finished
     * @return success
     */
    public boolean updateOrderAsFinished(Order o) {
        try {
            database.execSQL("UPDATE orders SET o_active = 0 WHERE o_id = " + o.getId());
            database.execSQL("UPDATE orders SET o_fin_date = " +
                             (new Date()).getTime() + " WHERE o_id = " + o.getId());
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error on order active (state).\n" + e.getMessage());
            return false;
        }

        try {
            //p_reserved, p_sold
            for(Product p : o.getProducts()) {
                database.execSQL("UPDATE products " +
                                 "SET p_reserved = p_reserved - " + p.getOrderCount() +
                                 " WHERE p_id = " + p.getId() + ";");
                database.execSQL("UPDATE products " +
                                 "SET p_sold = p_sold + " + p.getOrderCount() +
                                 " WHERE p_id = " + p.getId() + ";");
            }
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error on order active (state).\n" + e.getMessage());
            return false;
        }

        return true;
    }

    /**
     * Update values of orders and products so order is considered canceled
     * (returns values to products) and deletes order
     * @param o Order
     * @return success
     */
    public boolean updateOrderAsCanceled(Order o) {
        //return reserved products to stock
        try {
            for(Product p : o.getProducts()) {
                database.execSQL("UPDATE products " +
                        "SET p_reserved = p_reserved - " + p.getOrderCount() +
                        " WHERE p_id = " + p.getId() + ";");
                database.execSQL("UPDATE products " +
                        "SET p_count = p_count + " + p.getOrderCount() +
                        " WHERE p_id = " + p.getId() + ";");
            }
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error on order cancel (state).\n" + e.getMessage());
            return false;
        }

        //delete order and product bonds
        try {
            database.execSQL("DELETE FROM order_products WHERE order_id = " + o.getId() + ";");
            database.execSQL("DELETE FROM orders WHERE o_id = " + o.getId() + ";");
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL DELETE error on order cancel (state).\n" + e.getMessage());
            return false;
        }

        return true;
    }

    /**
     * Updates value of attribute of a product
     * @param pID product id
     * @param aID attribute id
     * @param value new attribute value
     * @return success
     */
    public boolean updateProductAttributeValue(int pID, int aID, String value) {
        try {
            database.execSQL("UPDATE product_attributes " +
                             "SET value = '" + value + "' " +
                             "WHERE product_id = " + pID + " AND attribute_id = " + aID + ";");
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error updating attribute value");
            return false;
        }
    }

    /**
     * Updates product name
     * @param pID product id
     * @param name new Name
     * @return success
     */
    public boolean updateProductName(int pID, String name) {
        try {
            database.execSQL("UPDATE products SET p_name = '" +
                    name + "' WHERE p_id = " + pID + ";");
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error updating product name");
            return false;
        }
    }

    /**
     * Update product price
     * @param pID product id
     * @param price new price
     * @return success
     */
    public boolean updateProductPrice(int pID, int price) {
        try {
            database.execSQL("UPDATE products SET p_price = '" +
                    price + "' WHERE p_id = " + pID + ";");
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error updating product price");
            return false;
        }
    }

    /**
     * Deletes image value from products table where id = pID (isn't DELETE but UPDATE to NULL)
     * @param pID
     */
    public void deleteProductImage(final int pID) {
        try {
            database.execSQL("UPDATE products SET p_img = NULL WHERE p_id = " +  pID + ";");
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error deleting product image");
        }
    }

    /**
     * Inserts new image for product. (ins't INSERT but UPDATE)
     * @param pID product id
     * @param img new image
     */
    public void insertProductImage(final int pID, final Bitmap img) {
        ContentValues values = new ContentValues();
        values.put("p_img", Utils.bitmapToBinary(img));

        try {
            database.update("products", values, "p_id = " + pID, null);
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL UPDATE error inserting product image");
        }
    }

/***************************************************************************************************
*                                                                                                  *
*            Inserts                                                                               *
*                                                                                                  *
***************************************************************************************************/

    /**
     * Inserts new product and creates bonds to attributes
     * @param pr product
     */
    public void insertNewProduct(Product pr) {
        //cols: p_id, p_name, p_count, p_reserved, p_sold, p_price, p_img
        ContentValues values = new ContentValues();
        values.put("p_name", pr.getName());
        values.put("p_count", pr.getStored());
        values.put("p_reserved", pr.getReserved());
        values.put("p_sold", pr.getSold());
        values.put("p_price", pr.getPrice());
        if(pr.getImage() != null) {
            values.put("p_img", Utils.bitmapToBinary(pr.getImage()));
        } else {
            Log.i(LOG_TAG, "Product has no image to be inserted");
        }

        try {
            database.insert("products", null, values);
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL product INSERT error.\n" + e.getMessage());
        }

        //get new item id
        Cursor c = database.rawQuery("SELECT last_insert_rowid();", null);
        c.moveToFirst();
        int prod_id = c.getInt(c.getColumnIndexOrThrow("last_insert_rowid()"));
        c.close();

        //workaround to get the id after insert (used in EDIT after COPY)
        pr.setId(prod_id);

        //insert product attributes
        try {
            for(Attribute at : pr.getAttributes()) {
                insertProductAttributeBond(prod_id, at.getId(), at.getAttValue());
            }
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL product attribute INSERT error.\n" + e.getMessage());
        }
    }

    /**
     * Inserts bond between product and attribute
     * @param pID   product id
     * @param aID   attribute id
     * @param value attribute value
     * @return success
     */
    public boolean insertProductAttributeBond(final int pID, final int aID, String value) {
        //cols: id, product_id, attribute_id, value
        ContentValues values = new ContentValues();
        values.put("product_id", pID);
        values.put("attribute_id", aID);
        values.put("value", value);

        try {
            database.insert("product_attributes", null, values);
            return true;
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL product_attributes INSERT error.\n" + e.getMessage());
            return false;
        }
    }

    /**
     * Inserts attribute to table. If it's ENUM inserts its values to enum table
     * @param at attribute
     */
    public void insertAttribute(Attribute at) {
        //cols: a_id, a_name, a_type
        ContentValues values = new ContentValues();
        values.put("a_name", at.getAttName());
        values.put("a_type", at.getType());
        values.put("a_units", at.getAttUnits());

        try {
            database.insert("attributes", null, values);

            Cursor c = database.rawQuery("SELECT last_insert_rowid();", null);
            c.moveToFirst();
            int att_id = c.getInt(c.getColumnIndexOrThrow("last_insert_rowid()"));
            c.close();

            //if attribute is enum, insert values to enum_vals table
            //cols: e_id, e_name, e_att_id
            if(at.getType() == AttributeType.ENUM.index) {
                for(String s : at.getEnumValues()) {
                    ContentValues enVals = new ContentValues();
                    enVals.put("e_name", s);
                    enVals.put("e_att_id", att_id);
                    database.insert("enum_vals", null, enVals);
                }
            }
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL attribute INSERT error.\n" + e.getMessage());
        }
    }

    /**
     * Inserts order and its products
     * @param o Order
     */
    public void insertOrder(Order o) {
        //cols: o_id, o_name, o_city, o_street, o_housenumber, o_psc, o_active, o_start_date, o_fin_date
        ContentValues values = new ContentValues();
        values.put("o_name", o.getForName());
        values.put("o_city", o.getCity());
        values.put("o_street", o.getStreet());
        values.put("o_housenumber", o.getHouseN());
        values.put("o_psc", o.getPost());
        values.put("o_active", 1); //o.isActive should also be true, but w/e
        values.put("o_start_date", o.getDateCreated().getTime());
        values.put("o_fin_date", 0); //cannot be initialized since its being created

        try {
            database.insert("orders", null, values);

            Cursor c = database.rawQuery("SELECT last_insert_rowid();", null);
            c.moveToFirst();
            int oID = c.getInt(c.getColumnIndexOrThrow("last_insert_rowid()"));
            c.close();

            o.setID(oID);

            for(Product p : o.getProducts()) {
                ContentValues bindVals = new ContentValues();
                bindVals.put("order_id", oID);
                bindVals.put("product_id", p.getId());
                bindVals.put("op_count", p.getOrderCount());

                database.insert("order_products", null, bindVals);
                boolean rv = updateProductOrdered(p);
                if(!rv) {
                    Log.e(LOG_TAG, "Failed to update broduct");
                }
            }
        } catch (Exception e) {
            Log.e(LOG_TAG, "SQL order INSERT error.\n" + e.getMessage());
        }
    }

    /**
     * Not used because android...
     */
    public void closeDatabase() {
        Log.i(LOG_TAG, "Closing DB created at time: " + creationTime);
        dbHelper.close();
    }
}

