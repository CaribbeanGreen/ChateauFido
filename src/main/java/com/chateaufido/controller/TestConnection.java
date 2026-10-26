package com.chateaufido.controller;


import com.chateaufido.config.DatabaseConnection;
import java.sql.Connection;

public class TestConnection {
    
    public static void main(String[] args) {
        System.out.println("=== Testing XAMPP Connection ===\n");
        
        try {
            // Get database connection
            DatabaseConnection dbConn = DatabaseConnection.getInstance();
            Connection conn = dbConn.getConnection();
            
            if (conn != null && !conn.isClosed()) {
                System.out.println("✓ SUCCESS! Connected to XAMPP MySQL");
                System.out.println("✓ Database: " + conn.getCatalog());
                conn.close();
            } else {
                System.out.println("✗ FAILED! Connection is null");
            }
            
        } catch (Exception e) {
            System.out.println("✗ ERROR! Connection failed:");
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}