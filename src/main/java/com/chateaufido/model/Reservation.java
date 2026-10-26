package com.chateaufido.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Reservation {
    private String reservID;
    private String roomID;
    private String dogID;
    private String staffID;
    private String custID;
    private Date checkInDate;
    private Date checkOutDate;
    private String status;
    private BigDecimal totalAmount;
    
    // Additional fields from table joins
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String dogName;
    private String dogBreed;
    private String roomType;
    private BigDecimal roomPrice;
    
    // Core functional metadata
    private String paymentStatus;
    private Date reservationDate;

    // Getters and Setters
    public String getReservID() { return reservID; }
    public void setReservID(String reservID) { this.reservID = reservID; }

    public String getRoomID() { return roomID; }
    public void setRoomID(String roomID) { this.roomID = roomID; }

    public String getDogID() { return dogID; }
    public void setDogID(String dogID) { this.dogID = dogID; }

    public String getStaffID() { return staffID; }
    public void setStaffID(String staffID) { this.staffID = staffID; }

    public String getCustID() { return custID; }
    public void setCustID(String custID) { this.custID = custID; }

    public Date getCheckInDate() { return checkInDate; }
    public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }

    public Date getCheckOutDate() { return checkOutDate; }
    public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getDogName() { return dogName; }
    public void setDogName(String dogName) { this.dogName = dogName; }

    public String getDogBreed() { return dogBreed; }
    public void setDogBreed(String dogBreed) { this.dogBreed = dogBreed; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public BigDecimal getRoomPrice() { return roomPrice; }
    public void setRoomPrice(BigDecimal roomPrice) { this.roomPrice = roomPrice; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public Date getReservationDate() { return reservationDate; }
    public void setReservationDate(Date reservationDate) { this.reservationDate = reservationDate; }

    // Helper method to calculate number of nights
    public int getNumberOfNights() {
        if (checkInDate == null || checkOutDate == null) return 0;
        long diff = checkOutDate.getTime() - checkInDate.getTime();
        return (int) (diff / (1000 * 60 * 60 * 24));
    }

    @Override
    public String toString() {
        return "Reservation{" + "reservID='" + reservID + '\'' + ", status='" + status + '\'' + '}';
    }
}