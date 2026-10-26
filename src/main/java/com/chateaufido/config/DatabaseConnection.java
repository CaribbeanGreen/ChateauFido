package com.chateaufido.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Manager for Château Fido Management System
 * Connects to XAMPP MySQL
 */
public class DatabaseConnection {
    
    // XAMPP MySQL Configuration
    private static final String URL = "jdbc:mysql://localhost:3306/chateau_fido?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Empty for XAMPP default
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Singleton instance
    private static DatabaseConnection instance;
    private boolean driverLoaded = false;
    
    /**
     * Private constructor - loads MySQL driver
     */
    private DatabaseConnection() {
        try {
            Class.forName(DRIVER);
            driverLoaded = true;
            System.out.println("✓ MySQL JDBC Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            driverLoaded = false;
            System.err.println("✗ MySQL JDBC Driver NOT found!");
            System.err.println("Please ensure mysql-connector-java JAR is in your lib folder");
            e.printStackTrace();
            // Don't throw exception - let getInstance() return successfully
            // but getConnection() will fail gracefully
        }
    }
    
    /**
     * Get singleton instance
     */
    public static synchronized DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }
    
    /**
     * Get database connection
     */
    public Connection getConnection() throws SQLException {
        if (!driverLoaded) {
            System.err.println("✗ Cannot get connection - JDBC driver not loaded");
            throw new SQLException("MySQL JDBC Driver not loaded. Check your classpath.");
        }
        
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✓ Database connection established!");
            return conn;
        } catch (SQLException e) {
            System.err.println("✗ Failed to connect to database");
            System.err.println("URL: " + URL);
            System.err.println("User: " + USER);
            System.err.println("Error: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Close connection safely
     */
    public void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("✓ Database connection closed!");
            } catch (SQLException e) {
                System.err.println("✗ Error closing connection!");
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test database connection
     */
    public boolean testConnection() {
        if (!driverLoaded) {
            System.err.println("✗ Driver not loaded - cannot test connection");
            return false;
        }
        
        try (Connection conn = getConnection()) {
            boolean isValid = conn != null && !conn.isClosed();
            System.out.println("Connection test: " + (isValid ? "✓ SUCCESS" : "✗ FAILED"));
            return isValid;
        } catch (SQLException e) {
            System.err.println("✗ Connection test FAILED!");
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}