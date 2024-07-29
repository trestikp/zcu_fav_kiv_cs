package model;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Random;

public class PersonList {

    private ObservableList<Person> personList;
    private Random rd;

    public PersonList(int personCount) {
        personList = FXCollections.observableList(new ArrayList<>());
        rd = new Random();

        for(int i = 0; i < personCount; i++) {
            int firstLen = 1 + rd.nextInt(4);
            int lastLen = 4 + rd.nextInt(7);
            int emailLen = 10 + rd.nextInt(15);
            int PC = 10000 + rd.nextInt(89999);

            personList.add(new Person(generateRandomString(firstLen), generateRandomString(lastLen),
                                      transformToEmail(generateRandomString(emailLen)), PC));
        }

        personList.sort(Comparator.comparing(Person::getFirstName));
    }

    private String generateRandomString(int length) {
        StringBuilder sb = new StringBuilder();

        for(int i = 0; i < length; i++) {
            sb.append((char) (97 + rd.nextInt(25)));
        }

        return sb.toString();
    }

    private String transformToEmail(String str) {
        int pos = 2 + rd.nextInt(str.length() - 2);

        StringBuilder sb = new StringBuilder(str);
        sb.setCharAt(pos, '@');

        return sb.toString();
    }

    public ObservableList<Person> getPersonList() {
        return personList;
    }

    public void printFirstThree() {
        for(int i = 0; i < 3; i++) {
            System.out.println(personList.get(i).toString());
        }
    }
}
