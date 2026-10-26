/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.model;

/**
 *
 * @author Administrator
 */

import java.sql.Date;

public class InventoryItem {
    private String itemID;
    private String itemName;
    private String category;
    private int currentStock;
    private int minStock;
    private Date lastRestock;
    private String status;
    private String staffID; // Last updated by

    public InventoryItem() {}

    // Getters and Setters
    public String getItemID() { return itemID; }
    public void setItemID(String itemID) { this.itemID = itemID; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getCurrentStock() { return currentStock; }
    public void setCurrentStock(int currentStock) { this.currentStock = currentStock; }

    public int getMinStock() { return minStock; }
    public void setMinStock(int minStock) { this.minStock = minStock; }

    public Date getLastRestock() { return lastRestock; }
    public void setLastRestock(Date lastRestock) { this.lastRestock = lastRestock; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStaffID() { return staffID; }
    public void setStaffID(String staffID) { this.staffID = staffID; }
    
    // Helper to calculate status dynamically if needed
    public String calculateStatus() {
        if (currentStock <= 0) return "Critical";
        if (currentStock < minStock) return "Low";
        return "Good";
    }
}