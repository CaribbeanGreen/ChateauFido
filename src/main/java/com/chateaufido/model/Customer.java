package com.chateaufido.model;

public class Customer {
    private String custID;
    private String custName;
    private String custNO;
    private String custEmail;
    private String password;
    
    // Default constructor
    public Customer() {}
    
    // Constructor with parameters
    public Customer(String custID, String custName, String custNO, String custEmail, String password) {
        this.custID = custID;
        this.custName = custName;
        this.custNO = custNO;
        this.custEmail = custEmail;
        this.password = password;
    }
    
    // Getters and Setters
    public String getCustID() {
        return custID;
    }
    
    public void setCustID(String custID) {
        this.custID = custID;
    }
    
    public String getCustName() {
        return custName;
    }
    
    public void setCustName(String custName) {
        this.custName = custName;
    }
    
    public String getCustNO() {
        return custNO;
    }
    
    public void setCustNO(String custNO) {
        this.custNO = custNO;
    }
    
    public String getCustEmail() {
        return custEmail;
    }
    
    public void setCustEmail(String custEmail) {
        this.custEmail = custEmail;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Override
    public String toString() {
        return "Customer{" +
                "custID='" + custID + '\'' +
                ", custName='" + custName + '\'' +
                ", custEmail='" + custEmail + '\'' +
                '}';
    }
}