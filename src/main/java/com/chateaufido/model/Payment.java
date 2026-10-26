package com.chateaufido.model;
import java.sql.Date;
import java.sql.Time;

public class Payment {
    private String payID;
    private String reservID;
    private double amount;
    private Time payTime;
    private Date payDate;

    // Getters and Setters
    public String getPayID() { return payID; }
    public void setPayID(String payID) { this.payID = payID; }
    public String getReservID() { return reservID; }
    public void setReservID(String reservID) { this.reservID = reservID; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public Time getPayTime() { return payTime; }
    public void setPayTime(Time payTime) { this.payTime = payTime; }
    public Date getPayDate() { return payDate; }
    public void setPayDate(Date payDate) { this.payDate = payDate; }
}