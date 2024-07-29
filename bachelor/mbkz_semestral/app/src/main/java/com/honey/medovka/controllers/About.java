package com.honey.medovka.controllers;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;

import com.honey.medovka.R;

/**
 * Controller for About activity
 */
public class About extends AppCompatActivity {

    private static final String LOG_TAG = "About";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);

        //activity title
        ActionBar ab =  this.getSupportActionBar();
        if(ab != null) {
            ab.setTitle(getString(R.string.menu_about));
        } else {
            Log.e(LOG_TAG, "Cannot set title");
        }

        Log.i(LOG_TAG, "Loaded About activity");
    }
}