package Launcher;

import Classes.*;
import Interfaces.*;

import java.util.Random;

public class Run {
    private static void feedArray(Animal[] animals, Random rd) {
        for(Animal a : animals) {
            ((commonInterface) a).eat(1 + rd.nextInt(10));
        }
    }

    private static void moveArray(Animal[] animals, Random rd) {
        for(Animal a : animals) {
            ((commonInterface) a).moveTo(rd.nextDouble() * 100, rd.nextDouble() * 100);
        }
    }

    private static void cryArray(Animal[] animals) {
        for(Animal a : animals) {
            if(a instanceof soundInterface) {
                ((soundInterface) a).cry();
            }
        }
    }

    private static void layArray(Animal[] animals) {
        for(Animal a : animals) {
            if(a instanceof eggInterface) {
                ((eggInterface) a).layEggs();
            }
        }
    }

    private static void doFour(Animal[] animals, Random rd) {
        feedArray(animals, rd);
        System.out.println();
        moveArray(animals, rd);
        System.out.println();
        cryArray(animals);
        System.out.println();
        layArray(animals);
    }

    public static void main(String[] args) {
        Random rd = new Random();

        Eagle e1 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 10, "Eagle 1");
        Eagle e2 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 1, "Eagle 2");
        Pigeon p1 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 20, "Pigeon 1");
        Pigeon p2 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 5, "Pigeon 2");
        Barracuda b1 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 77, "Barracuda 1");
        Barracuda b2 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 45, "Barracuda 2");
        Carp c1 = new Carp(rd.nextDouble() * 100, rd.nextDouble() * 100, 38, "Carp 1");
        Carp c2 = new Carp(rd.nextDouble() * 100, rd.nextDouble() * 100, 2, "Carp 2");
        Rat r1 = new Rat(rd.nextDouble() * 100, rd.nextDouble() * 100, 500, "Rat 1");
        Rat r2 = new Rat(rd.nextDouble() * 100, rd.nextDouble() * 100, 3, "Rat 2");
        Sloth s1 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 3, "Sloth 1");
        Sloth s2 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 0, "Sloth 2");


        Animal[] allAnimal = new Animal[]{e1, e2, p1, p2, b1, b2, c1, c2, r1, r2, s1, s2};
//        eggInterface[] eggLayers = new Interfaces.eggInterface[]{e1, e2, p1, p2, b1, b2, c1, c2};
        Animal[] eggLayers = new Animal[]{e1, e2, p1, p2, b1, b2, c1, c2};
//        soundInterface[] soundAnimals = new Interfaces.soundInterface[]{e1, e2, p1, p2, r1, r2, s1, s2};
        Animal[] soundAnimals = new Animal[]{e1, e2, p1, p2, r1, r2, s1, s2};
        Birds[] birdsOnly = new Birds[]{e1, e2, p1, p2};

        System.out.println("========== all animal array ==========");
        doFour(allAnimal, rd);

        System.out.println("\n========== egg layer array ==========");
        doFour(eggLayers, rd);

        System.out.println("\n========== sound animal array ==========");
        doFour(soundAnimals, rd);

        System.out.println("\n========== bird only array ==========");
        doFour(birdsOnly, rd);
    }
}
