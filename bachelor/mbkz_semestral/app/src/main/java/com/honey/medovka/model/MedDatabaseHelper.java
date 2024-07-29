package com.honey.medovka.model;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

/**
 * Opens database
 */
public class MedDatabaseHelper extends SQLiteOpenHelper {

    private static final String LOG_TAG = "MedDatabaseHelper";

    private static final String DATABASE_NAME = "medovka.db";
    private static final int DATABASE_VERSION = 1;

    public static final boolean DEBUG = false;
    public static boolean CREATING = false;

    public MedDatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);

        if(DEBUG) {
            context.deleteDatabase(DATABASE_NAME);
//            onCreate(this.getWritableDatabase());
        }

        Log.i(LOG_TAG, "Creating MedDatabaseHelper");
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        Log.i(LOG_TAG, "MedDatabaseHelper called onCreate, starting to create tables");

        CREATING = true;

        db.execSQL("PRAGMA foreign_keys = ON;");

        // create "products" table containing product information
        db.execSQL("CREATE TABLE IF NOT EXISTS products(" +
                "p_id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "p_name TEXT," +
                "p_count INTEGER," +
                "p_reserved INTEGER," +
                "p_sold INTEGER," +
                "p_price INTEGER," +
                "p_img BLOB" +
                ");");
        // create "orders" table containing info about order
        db.execSQL("CREATE TABLE IF NOT EXISTS orders(" +
                "o_id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "o_name TEXT," +
                "o_city TEXT," +
                "o_street TEXT," +
                "o_housenumber INTEGER," +
                "o_psc INTEGER," +
                "o_active BOOLEAN," +
                "o_start_date INTEGER," +
                "o_fin_date INTEGER" +
                ");");
        // create "attributes" table containing list of possible attributes for a product
        db.execSQL("CREATE TABLE IF NOT EXISTS attributes(" +
                "a_id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "a_name TEXT NOT NULL UNIQUE," +
                "a_type INTEGER," +
                "a_units TEXT" +
//                "a_is_wh_att BOOLEAN" +
                ");");
        // contains values for attributes that are designated as enum
        db.execSQL("CREATE TABLE IF NOT EXISTS enum_vals(" +
                "e_id INTEGER PRIMARY KEY AUTOINCREMENT," +
                "e_name TEXT," +
                "e_att_id INTEGER," +
                "FOREIGN KEY(e_att_id) REFERENCES attributes(a_id)" +
                ");");
        // table adding attributes to product
        db.execSQL("CREATE TABLE IF NOT EXISTS product_attributes(" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," + //technically doesn't need id - remove?
                "product_id INTEGER," +
                "attribute_id INTEGER," +
                "value TEXT," +
                "FOREIGN KEY(product_id) REFERENCES products(p_id)," +
                "FOREIGN KEY(attribute_id) REFERENCES attributes(a_id)" +
                ");");
        db.execSQL("CREATE TABLE IF NOT EXISTS order_products(" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT," + //technically doesn't need id - remove?
                "order_id INTEGER," +
                "product_id INTEGER," +
                "op_count INTEGER," +
                "FOREIGN KEY(order_id) REFERENCES orders(o_id)" +
//                "FOREIGN KEY(product_id) REFERENCES products(p_id)" +
                ");");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        Log.i(LOG_TAG, "MedDatabaseHelper called onUpgrade, upgrading database version");
    }
}