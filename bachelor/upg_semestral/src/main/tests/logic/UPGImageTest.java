package logic;

import model.UPGImage;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.File;

import static org.junit.jupiter.api.Assertions.*;

class UPGImageTest {
    UPGImage img;

    @BeforeEach
    public void setUp() throws Exception {
        img = PGMLoader.loadPGMFileThroughMemory(new File("data/plzen.pgm"));
    }

    @Test
    public void testDiff() {
        int[] fakeMatrix = new int[]{
                160,  87,  93, 107,   //max diff in row 73
                120, 113,  70,  99,   //max diff in row 43
//                130,  95, 106,  65,   //max diff in row 41
//                140, 150, 100, 101, //max diff in row 50
//max diff in col 40, 55,  36,  36
        };

//        img.rasterArray = fakeMatrix;
//
//        img.initialWidth = 4;
//        img.initialHeight = 2;
//
//        img.findDiff();

        assertEquals(73, img.getDiff());
    }

    @Test
    public void testDiffIndex() {
        int[] fakeMatrix = new int[]{
                160,  87,  93, 107,   //max diff in row 73
                120, 113,  70,  99,   //max diff in row 43
                130,  95, 106,  65,   //max diff in row 41
                140, 150, 100, 101, //max diff in row 50
//max diff in col 40, 55,  36,  36
        };

//        img.actualImageWidth = 4;
//        img.actualImageHeight = 4;

//        img.findDiff(fakeMatrix);

        assertEquals(0, img.getDiffIndex());
    }
}