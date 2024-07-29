package Launcher;

import Classes.*;

import java.util.*;

public class Run {
    static Random rd = new Random();

    private static <T> void addElementsToList(ArrayList<T> list, T ...p) {
        list.addAll(Arrays.asList(p));
    }

    private static void task1() {
        /*
            Vytvor strukturu pro ptaky, vloz 6 ptaku
         */
        ArrayList<Birds> list = new ArrayList<>();

        Eagle e1 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 10, "Eagle 1");
        Eagle e2 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 1, "Eagle 2");
        Pigeon p1 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 20, "Pigeon 1");
        Pigeon p2 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 5, "Pigeon 2");
        Pigeon p3 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 5, "Pigeon 3");
        Pigeon p4 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 5, "Pigeon 4");

        addElementsToList(list, e1, p1, p2, p3, e2, p4);

        /*
            Posun ptaky
         */
        list.forEach(bird -> bird.moveTo(rd.nextDouble() * 100, rd.nextDouble() * 100));
//        list.stream().forEach(bird -> bird.moveTo(rd.nextDouble() * 100, rd.nextDouble() * 100));
    }

    private static void task2() {
        /*
            Struktura na zvirate, vloz 2o, 2b, 2l
         */
        ArrayList<Animal> list = new ArrayList<>();

        Eagle e1 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 10, "Eagle 1");
        Eagle e2 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 1, "Eagle 2");
        Barracuda b1 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 77, "Barracuda 1");
        Barracuda b2 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 45, "Barracuda 2");
        Sloth s1 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 3, "Sloth 1");
        Sloth s2 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 0, "Sloth 2");

        addElementsToList(list, e1, e2, b1, b2, s1, s2);

        /*
            Vypis je
         */
        list.forEach(animal -> System.out.println(animal.toString()));
//        list.stream().forEach(animal -> System.out.println(animal.toString()));

        /*
            Nazev prvniho prvku z kolekce
         */
        System.out.println("\nFirst element class: " + list.get(0).getClass().getSimpleName());

        //prvni prvek streamem... podle me je to zbytecny se otravovat se streamem na tuto
//        list.stream().findFirst().ifPresent(animal ->
//                System.out.println("\nFirst element class: " + animal.getClass().getSimpleName()));

        /*
            Vypis energii prvni barakudy
         */
        list.stream().filter(animal -> animal instanceof Barracuda)
                     .findFirst().ifPresent(animal ->
                            System.out.println("\nFirst Barracuda (" + animal.getName() +
                                               ") has " + animal.getEnergy() + " energy\n"));

        /*
            Je prvni a druhy ptak?
         */
        if(list.get(0) instanceof Birds) System.out.println("First element is a bird");
        if(list.get(1) instanceof Birds) System.out.println("Second element is a bird");
    }

    private static void task3() {
        /*
            Struktura pro svace, alespon 4 se jmeny z A, B, C
         */
        ArrayList<Mammals> list = new ArrayList<>();

        Rat r1 = new Rat(rd.nextDouble() * 100, rd.nextDouble() * 100, 500, "AAA");
        Rat r2 = new Rat(rd.nextDouble() * 100, rd.nextDouble() * 100, 3, "Ratter");
        Rat r3 = new Rat(rd.nextDouble() * 100, rd.nextDouble() * 100, 11, "ABC");
        Sloth s1 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 3, "Slother");
        Sloth s2 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 2, "CCC");
        Sloth s3 = new Sloth(rd.nextDouble() * 100, rd.nextDouble() * 100, 50, "CAB");

        addElementsToList(list, r1, r2, r3, s1, s2, s3);

        /*
            Vypis vlozene savce
         */
        System.out.println("Inserted elements:");
        list.forEach(animal -> System.out.println(animal.toString()));
//        list.stream().forEach(animal -> System.out.println(animal.toString()));
        System.out.println("\nContaining ABC only:");

        /*
            Vypis savce se jmenem jen z ABC
         */
        list.stream().filter(animal -> animal.getName().matches("[ABC]+"))
                     .forEach(animal -> System.out.println(animal.toString()));
        System.out.println("\nContaining ABC only and more then 3 energy: ");

        /*
            -||- + energie vetsi nez 3
         */
        list.stream().filter(animal -> animal.getName().matches("[ABC]+"))
                     .filter(animal -> animal.getEnergy() > 3)
                     .forEach(animal -> System.out.println(animal.toString()));
    }

    private static void task4() {
        /*
            Struktura na ptaky + vlozeni 3o, 3p
         */
        ArrayList<Birds> list = new ArrayList<>();

        Eagle e1 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 11, "Eagle 1");
        Eagle e2 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 1, "Eagle 2");
        Eagle e3 = new Eagle(rd.nextDouble() * 100, rd.nextDouble() * 100, 9, "Eagle 3");
        Pigeon p1 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 20, "Pigeon 1");
        Pigeon p2 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 5, "Pigeon 2");
        Pigeon p3 = new Pigeon(rd.nextDouble() * 100, rd.nextDouble() * 100, 15, "Pigeon 3");

        addElementsToList(list, e1, e2, e3, p1, p2, p3);

        /*
            Vypis struktury
         */
        System.out.println("Inserted birds:");
        list.forEach(animal -> System.out.println(animal.toString()));
//        list.stream().forEach(animal -> System.out.println(animal.toString()));
        System.out.println();

        /*
            Vypis prumernou energii vsech
         */
        System.out.println("Average of all: " + list.stream().mapToInt(Animal::getEnergy).average().getAsDouble());

        /*
            Vypis prumernou enrgii vsech orlu
         */
        System.out.println("Average of eagles: " + list.stream().filter(animal -> animal instanceof Eagle)
                                        .mapToInt(Animal::getEnergy)
                                        .average().getAsDouble());
    }

    private static void task5() {
        /*
            Vyvor strukturu jmen a pridej jmena
         */
        ArrayList<String> list = new ArrayList<>();

        addElementsToList(list, "Pepa", "Amanda", "Jessica", "Karel", "Jan", "Eva");

        /*
            Vypis jmena
         */
        System.out.println("Name list: ");
        list.forEach(System.out::println);
//        list.stream().forEach(System.out::println);
        System.out.println();

        /*
            Vypsat serazene podle abecedy
         */
        System.out.println("Alphabetically ordered: ");
        list.stream().sorted().forEach(System.out::println);
        System.out.println();

        /*
            Nahodne prohazej jmena
         */
        for(int i = 0; i < 10; i++) {
            int a = rd.nextInt(list.size());
            int b = rd.nextInt(list.size());

            Collections.swap(list, a, b);
        }

        /*
            Vypis jmena serazena vzestupne podle delky
         */
        System.out.println("Ascending order: ");
        list.stream().sorted(Comparator.comparingInt(String::length))
                .forEach(System.out::println);
        System.out.println();

        /*
            Vypis jmena serazena sestupne podle delky
         */
        System.out.println("Descending order: ");
        list.stream().sorted((var1, var2) -> var2.length() - var1.length()) // weeeelp, to je skoda
                .forEach(System.out::println);
    }

    private static void task6() {
        /*
            Vytvor strukturu
         */
        ArrayList<Fishes> list = new ArrayList<>();

        Barracuda b1 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 77, "Barracuda 1");
        Barracuda b2 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 45, "Barracuda 2");
        Barracuda b3 = new Barracuda(rd.nextDouble() * 100, rd.nextDouble() * 100, 24, "Barracuda 3");
        Carp c1 = new Carp(rd.nextDouble() * 100, rd.nextDouble() * 100, 38, "Carp 1");
        Carp c2 = new Carp(rd.nextDouble() * 100, rd.nextDouble() * 100, 2, "Carp 2");
        Carp c3 = new Carp(rd.nextDouble() * 100, rd.nextDouble() * 100, 13, "Carp 3");

        addElementsToList(list, b1, c2, b3, c1, b2, c3);

        /*
            Vypis strukturu
         */
        System.out.println("Inserted fishes:");
        list.forEach(System.out::println);
        System.out.println();

        /*
            Melka kopie
         */
        ArrayList<Fishes> copy = list;

        /*
            Overeni melke kopie
         */
        System.out.println("Copy verification - energy before eggs: " + list.get(0).getEnergy());
        list.get(0).layEggs();
        System.out.println("Copy verification - energy after eggs: " + copy.get(0).getEnergy());

        /*
            Novy prvek na 4. pozici
         */
        list.add(4, new Carp(rd.nextDouble() * 100, rd.nextDouble() * 100, 13, "Makrela"));

        /*
            Vejmout vsechny barakudy a vypsat strukturu
         */
        list.removeIf(fish -> fish instanceof Barracuda);

        System.out.println("\nList after removing Barracudas");
        list.forEach(System.out::println);
    }

    public static void main(String[] args) {
        System.out.println("\n============ task 1 ============\n");
        task1();
        System.out.println("\n============ task 2 ============\n");
        task2();
        System.out.println("\n============ task 3 ============\n");
        task3();
        System.out.println("\n============ task 4 ============\n");
        task4();
        System.out.println("\n============ task 5 ============\n");
        task5();
        System.out.println("\n============ task 6 ============\n");
        task6();
    }
}
