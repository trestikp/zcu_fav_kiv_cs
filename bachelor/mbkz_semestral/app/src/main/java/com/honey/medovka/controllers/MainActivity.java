package com.honey.medovka.controllers;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.honey.medovka.R;
import com.honey.medovka.model.MedDatabaseHandler;


/**
 * Starting activity of the application
 */
public class MainActivity extends AppCompatActivity {

    private static final String LOG_TAG = "MainActivity";
    private static boolean starting = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //this creates and INSTANCE in MedDatabaseHandler which is persistent through the whole app
        if(starting) {
            new MedDatabaseHandler(this, false);
            starting = false;
        }

        Log.i(LOG_TAG, "Loaded MainActivity");
    }

    /**
     * Button event, starts PmFragActivity
     * @param v View
     */
    public void startProductActivity(View v) {
        Log.i(LOG_TAG, "Changing activity from MainActivity to ProductMenu");

        Intent i = new Intent(this, PmFragActivity.class);
        startActivity(i);
    }

    /**
     * Button event, starts About activity
     * @param v View
     */
    public void startAboutActivity(View v) {
        Log.i(LOG_TAG, "Changing activity from MainActivity to About");

        Intent i = new Intent(this, About.class);
        startActivity(i);
    }

    /**
     * Button event, starts OrderFragActivity
     * @param v View
     */
    public void startOrderMenuActivity(View v) {
        Log.i(LOG_TAG, "Changing activity from MainActivity to OrderMenu");

        Intent i = new Intent(this, OrderFragActivity.class);
        startActivity(i);
    }

    @Override
    protected void onDestroy() {
        Log.i(LOG_TAG, "Destroying activity MainActivity");
//        MedDatabaseHandler.getInstance().closeDatabase();
        super.onDestroy();
    }

}
