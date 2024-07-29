package model;

public class Person {
    private String firstName;
    private String lastName;
    private String email;
    private int postCode;

    public Person(String firstName, String lastName, String email, int postCode) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.postCode = postCode;
    }

    public int getPostCode() {
        return postCode;
    }

    public void setPostCode(int postCode) {
        this.postCode = postCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName;
    }
}
