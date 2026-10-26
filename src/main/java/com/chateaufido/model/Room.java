package com.chateaufido.model;

public class Room {

    private String roomID;
    private double pricePerNight;
    private String status;
    private String roomType;

    // Getter & Setter: Room ID
    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    // Getter & Setter: Price Per Night
    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    // Getter & Setter: Status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Getter & Setter: Room Type
    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public void setCustID(String string) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}