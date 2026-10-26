package com.chateaufido.model;

public class Dog {
    private String dogID;
    private String custID;
    private String dogName;
    private int dogAge;
    private String dogBreed;
    private String vaccineDocPath;
    private String vaccineStatus; // Represents "Pending", "Approved", or "Rejected"

    // Default Constructor
    public Dog() {}

    // Getter and Setter for dogID
    public String getDogID() {
        return dogID;
    }

    public void setDogID(String dogID) {
        this.dogID = dogID;
    }

    // Getter and Setter for custID
    public String getCustID() {
        return custID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    // Getter and Setter for dogName
    public String getDogName() {
        return dogName;
    }

    public void setDogName(String dogName) {
        this.dogName = dogName;
    }

    // Getter and Setter for dogAge
    public int getDogAge() {
        return dogAge;
    }

    public void setDogAge(int dogAge) {
        this.dogAge = dogAge;
    }

    // Getter and Setter for dogBreed
    public String getDogBreed() {
        return dogBreed;
    }

    public void setDogBreed(String dogBreed) {
        this.dogBreed = dogBreed;
    }

    // Getter and Setter for vaccineDocPath
    public String getVaccineDocPath() {
        return vaccineDocPath;
    }

    public void setVaccineDocPath(String vaccineDocPath) {
        this.vaccineDocPath = vaccineDocPath;
    }

    // NEW: Getter and Setter for vaccineStatus
    public String getVaccineStatus() {
        return vaccineStatus;
    }

    public void setVaccineStatus(String vaccineStatus) {
        this.vaccineStatus = vaccineStatus;
    }
}