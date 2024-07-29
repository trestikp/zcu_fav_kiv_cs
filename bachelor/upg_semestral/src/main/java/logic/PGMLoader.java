package logic;

import model.UPGImage;

import java.io.*;
import java.nio.ByteBuffer;
import java.util.Arrays;


/**
 *  Classes that loads images in PGM format. Can read formats with magic number P2 and P5
 *
 *  @author Pavel Trestik - A17B0380P
 */
public class PGMLoader {
    // from https://en.wikipedia.org/wiki/Whitespace_character
    // used by a removed loading method, kept just for sure
    static int[] whiteSpaces = new int[]{9, 10, 11, 12, 13, 32, 133, 160};

    // since Java is too clever for unsigned, I'm just gonna assume only basic ascii is possible (0-127)
    static byte[] byteWhiteSpaces = new byte[]{9, 10, 11, 12, 13, 32};


    /**
     * Caller for loading PGM file through memory. First loads whole file into memory and then loads data to
     * UPGImage from memory
     * @param f file to be loaded
     * @return loaded UPGImage instance (null on error)
     */
    public static UPGImage loadPGMFileThroughMemory(File f) {
        try {
            long start = System.currentTimeMillis();

            FileInputStream fis = new FileInputStream(f);

//            start = System.currentTimeMillis();
            byte[] buffer = fis.readAllBytes();
//            end = System.currentTimeMillis();

//            System.out.println("File loading time: " + (end - start));

            fis.close();

//            start = System.currentTimeMillis();
            UPGImage img = parseBuffer(buffer);
//            end = System.currentTimeMillis();

//            System.out.println("Buffer parsing time: " + (end - start));

            if(img == null) {
                System.err.println("Failed to create UPGImage!!");
                return null;
            }

            img.setImgName(f.getName());

            long end = System.currentTimeMillis();

            System.out.println("TIME: File loading: " + (end - start) + " ms");

            return img;
        } catch (IOException e) {
            System.err.println("File input error occurred. Message: " + e.getMessage());
            return null;
        }
    }

    /**
     * Starts parsing memory buffer of loaded file
     * @param buffer memory of loaded file
     * @return loaded UPGImage instance (null on error)
     */
    private static UPGImage parseBuffer(byte[] buffer) {
        // i wish i had a pointer ;)
        IntWrapper pos_in_buffer = new IntWrapper();

        UPGImage img = loadHeaderFromBuffer(buffer, pos_in_buffer);

        if(img == null) {
            System.err.println("Cannot load this file. Failed to load metadata");
            return null;
        }

        if(img.getType().charAt(1) == '2') {
            loadAsciiPixelsFromBuffer(img, buffer, pos_in_buffer);
        } else if(img.getType().charAt(1) == '5') {
            loadBytePixelsFromBuffer(img, buffer, pos_in_buffer);
        }

        return img;
    }

    /**
     * Loads basic image information from buffer
     * @param buffer image data in memory
     * @param position position in the buffer (wrapped in custom class IntWrapper)
     * @return UPGImage instance
     */
    private static UPGImage loadHeaderFromBuffer(byte[] buffer, IntWrapper position) {
        String format = "";
        int width = 0, height = 0, maxGrey = -1, counter = 0;

        while(maxGrey == -1) {
            String val = readAsciiFromBuffer(buffer, position);

            if(val.equals("")) {
//                position.value++;
                continue;
            }

            try {
                switch (counter) {
                    case 0: format = val; break;
                    case 1: width = Integer.parseInt(val); break;
                    case 2: height = Integer.parseInt(val); break;
                    case 3: maxGrey = Integer.parseInt(val); break;
                }
            } catch (NumberFormatException e) {
                System.err.println("Failed to parse String to int while loading file!");
                return null;
            }

            counter++;
        }

        // http://netpbm.sourceforge.net/doc/pgm.html - also mentioned in byte loading
        if(maxGrey < 0 || maxGrey > 65535) {
            System.err.println("Maximum grey value can be 65535");
            return null;
        }

        //not very pretty, but necessary check
        if(format.length() != 2) {
            System.err.println("Unrecognized file format");
            return null;
        } else {
            if(format.charAt(0) != 'P') {
                System.err.println("Unrecognized file format");
                return null;
            } else {
                if(format.charAt(1) != '2' && format.charAt(1) != '5') {
                    System.err.println("Unrecognized PGM magic number");
                    return null;
                } else {
                    return new UPGImage(width, height, maxGrey, format);
                }
            }
        }
    }

    /**
     * Loads image pixels (as ASCII data) from buffer
     * @param img UPGImage instance to which pixels are loaded
     * @param buffer image data in memory
     * @param position position in the buffer
     */
    private static void loadAsciiPixelsFromBuffer(UPGImage img, byte[] buffer, IntWrapper position) {
        int counter = 0;

        while(position.value < buffer.length) {
            String val = readAsciiFromBuffer(buffer, position);

            if(val.equals("")) {
//                position.value++;
                continue;
            }

            if(counter >= img.getRasterArray().length) {
                System.err.println("Loading more values than there is pixels");
                break;
            } else {

                try {
                    img.getRasterArray()[counter] = Integer.parseInt(val);
                } catch (NumberFormatException e) {
                    System.err.println("Failed to parse number");
                    break;
                }

            }

            counter++;
        }
    }

    /**
     * Loads image pixels (as binary data) from buffer
     * @param img UPGImage instance to which pixels are loaded
     * @param buffer image data in memory
     * @param position position in the buffer
     */
    private static void loadBytePixelsFromBuffer(UPGImage img, byte[] buffer, IntWrapper position) {
        int number_size = 1; //in bytes
        int pos = position.value;
        int counter = 0;

        // according to http://netpbm.sourceforge.net/doc/pgm.html maximum grey value can be 2^16 (-1 cuz 0)
        // max value is check in header
        if(img.getMaxGreyValue() > 255 && img.getMaxGreyValue() <= 65535) {
            number_size = 2;
        }

        while(pos < buffer.length) { // stop when end of buffer is reached
            //however check, if there isn't more values in buffer than there is pixels
            if(counter >= img.getRasterArray().length) {
                System.err.println("Loading more values than there is pixels");
                break;
            }

            int val;

            if(number_size == 1) {
                //need & 0xFF because java doesn't have unsigned -> this interprets it as a positive (int?)
                val = (buffer[pos] & 0xFF);

                pos++;
            } else {
//                val = ByteBuffer.wrap(buffer, pos, pos + 1).getInt();
                val = ByteBuffer.wrap(buffer, pos, 2).getInt();

                pos += 2;
            }

            img.getRasterArray()[counter] = val;

            counter++;
        }
    }

    /**
     * Interprets part of buffer from @position to next defined white space as ASCII string
     * @param buffer image data in memory
     * @param position position from which values are loading
     * @return ASCII string
     */
    private static String readAsciiFromBuffer(byte[] buffer, IntWrapper position) {
        StringBuilder sb = new StringBuilder();

        int pos = position.value;

        while(!isByteWhiteByte(buffer[pos])) {
            if(((char) buffer[pos]) == '#') {
                pos = skipLineInBuffer(buffer, pos);

                position.value = pos;
                return sb.toString();
            }

            sb.append((char) buffer[pos]);
            pos++;
        }

        // to skip the detected white space
        pos++;

        position.value = pos;

        return sb.toString();
    }

    /**
     * Goes through buffer till next end of line char
     * @param buffer image data in memory
     * @param pos position in buffer from which to start skipping data
     * @return position in buffer after skipped data
     */
    private static int skipLineInBuffer(byte[] buffer, int pos) {
        while(((char) buffer[pos]) != '\n') {
            pos++;
        }

        return pos;
    }

    /**
     * Checks if byte @n is in defined white spaces
     * @param n byte
     * @return true if it is in defined white spaces, false otherwise
     */
    private static boolean isByteWhiteByte(byte n) {
        return Arrays.binarySearch(byteWhiteSpaces, n) >= 0;
    }
}

/**
 * Custom class to be able to preserve int value throughout multiple method calls
 */
class IntWrapper {
    public int value;

    public IntWrapper() {
        value = 0;
    }
}