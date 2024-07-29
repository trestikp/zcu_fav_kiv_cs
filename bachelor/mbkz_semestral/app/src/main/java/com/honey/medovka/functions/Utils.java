package com.honey.medovka.functions;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.ByteArrayOutputStream;

/**
 * General utilities, (because i didn't know where to put this)
 */
public class Utils {

    /**
     * Converts Bitmap to byte[] (binary) which is inserted to DB. Expects Bitmap in JPEG format.
     * @param map Bitmap
     * @return byte[]
     */
    public static byte[] bitmapToBinary(Bitmap map) {
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        map.compress(Bitmap.CompressFormat.JPEG, 50, stream);

        //cant recycle it here anymore, because it is used in EDIT -> COPY
        // and the bitmap is still needed
//        map.recycle();

        return stream.toByteArray();
    }

    /**
     * Gets Bitmap from drawable resource
     * @param resources Resources
     * @param id drawable ID
     * @return Bitmap
     */
    public static Bitmap getDrawableAsBitmap(Resources resources, int id) {
        return BitmapFactory.decodeResource(resources, id);
    }

    /**
     * Converts byte[] (binary) to Bitmap
     * @param data byte[]
     * @return Bitmap
     */
    public static Bitmap binaryToBitmap(byte[] data) {
        return BitmapFactory.decodeByteArray(data, 0, data.length);
    }
}
