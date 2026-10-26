/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.DAO;

/**
 *
 * @author Administrator
 */


import com.chateaufido.config.DatabaseConnection;
import com.chateaufido.model.InventoryItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {
    
    private DatabaseConnection dbConn;

    public InventoryDAO() {
        this.dbConn = DatabaseConnection.getInstance();
    }

    // Generate ID like INV0001
    private String generateItemID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(itemID, 4) AS UNSIGNED)) as maxID FROM inventory WHERE itemID LIKE 'INV%'";
        try (Connection conn = dbConn.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                int maxID = rs.getInt("maxID");
                return String.format("INV%04d", maxID + 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "INV0001";
    }

    // List all items (Sorted by Priority: Critical -> Low -> Good)
    public List<InventoryItem> getAllItems() {
        return searchInventory(null, null); // Re-use search method with no filters
    }

    // --- NEW: SEARCH & FILTER INVENTORY ---
    public List<InventoryItem> searchInventory(String keyword, String category) {
        List<InventoryItem> list = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder("SELECT * FROM inventory WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        // Add Search Filter
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (item_name LIKE ? OR itemID LIKE ?) ");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Add Category Filter
        if (category != null && !category.trim().isEmpty() && !"All".equals(category)) {
            sql.append("AND category = ? ");
            params.add(category);
        }

        // Add Sorting Logic
        sql.append("ORDER BY CASE status ")
           .append("  WHEN 'Critical' THEN 1 ")
           .append("  WHEN 'Low' THEN 2 ")
           .append("  WHEN 'Good' THEN 3 ")
           .append("  ELSE 4 END, category, item_name");
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            // Set parameters dynamically
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    InventoryItem item = new InventoryItem();
                    item.setItemID(rs.getString("itemID"));
                    item.setItemName(rs.getString("item_name"));
                    item.setCategory(rs.getString("category"));
                    item.setCurrentStock(rs.getInt("current_stock"));
                    item.setMinStock(rs.getInt("min_stock"));
                    item.setLastRestock(rs.getDate("last_restock"));
                    item.setStatus(rs.getString("status"));
                    item.setStaffID(rs.getString("staffID"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Add new item
    public boolean addItem(InventoryItem item) {
        String newID = generateItemID();
        String sql = "INSERT INTO inventory (itemID, item_name, category, current_stock, min_stock, status, staffID, last_restock) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newID);
            pstmt.setString(2, item.getItemName());
            pstmt.setString(3, item.getCategory());
            pstmt.setInt(4, item.getCurrentStock());
            pstmt.setInt(5, item.getMinStock());
            pstmt.setString(6, item.calculateStatus());
            pstmt.setString(7, item.getStaffID());
            pstmt.setDate(8, new Date(System.currentTimeMillis())); 
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update Stock (Stock In / Stock Out)
    public boolean updateStock(String itemID, int quantityChange, String staffID) {
        String selectSql = "SELECT current_stock, min_stock FROM inventory WHERE itemID = ?";
        String updateSql = "UPDATE inventory SET current_stock = ?, status = ?, staffID = ?, last_restock = ? WHERE itemID = ?";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
            
            selectStmt.setString(1, itemID);
            ResultSet rs = selectStmt.executeQuery();
            
            if (rs.next()) {
                int current = rs.getInt("current_stock");
                int min = rs.getInt("min_stock");
                int newStock = current + quantityChange;
                
                if (newStock < 0) return false; 
                
                String newStatus = (newStock <= 0) ? "Critical" : (newStock < min ? "Low" : "Good");
                
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, newStock);
                    updateStmt.setString(2, newStatus);
                    updateStmt.setString(3, staffID);
                    Date date = new Date(System.currentTimeMillis());
                    updateStmt.setDate(4, date);
                    updateStmt.setString(5, itemID);
                    return updateStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Item
    public boolean deleteItem(String itemID) {
        String sql = "DELETE FROM inventory WHERE itemID = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, itemID);
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Edit Item Details (Name, Category, MinStock)
    public boolean updateItemDetails(InventoryItem item) {
        String selectSql = "SELECT current_stock FROM inventory WHERE itemID = ?";
        String updateSql = "UPDATE inventory SET item_name = ?, category = ?, min_stock = ?, status = ?, staffID = ? WHERE itemID = ?";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
            
            selectStmt.setString(1, item.getItemID());
            ResultSet rs = selectStmt.executeQuery();
            
            if (rs.next()) {
                int currentStock = rs.getInt("current_stock");
                item.setCurrentStock(currentStock);
                String newStatus = item.calculateStatus();

                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, item.getItemName());
                    updateStmt.setString(2, item.getCategory());
                    updateStmt.setInt(3, item.getMinStock());
                    updateStmt.setString(4, newStatus);
                    updateStmt.setString(5, item.getStaffID());
                    updateStmt.setString(6, item.getItemID());
                    
                    return updateStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // For Dashboard
    public int getLowStockCount() {
        String sql = "SELECT COUNT(*) FROM inventory WHERE status IN ('Low', 'Critical')";
        try (Connection conn = dbConn.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}