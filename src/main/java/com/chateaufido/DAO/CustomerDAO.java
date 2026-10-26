package com.chateaufido.DAO;

import com.chateaufido.config.DatabaseConnection;
import com.chateaufido.model.Customer;
import com.chateaufido.model.PasswordUtil;
import java.sql.*;

public class CustomerDAO {
    
    private DatabaseConnection dbConn;
    
    public CustomerDAO() {
        this.dbConn = DatabaseConnection.getInstance();
    }

    // ==========================================
    // NEW PASSWORD MANAGEMENT METHODS
    // ==========================================

    /**
     * Verify current password for password change
     */
   public boolean verifyCurrentPassword(String custID, String currentPassword) {
        String sql = "SELECT password FROM customer WHERE TRIM(custID) = TRIM(?)";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, custID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    return PasswordUtil.verifyPassword(currentPassword, storedHash);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update customer password
     */
  public boolean updatePassword(String custID, String newPassword) {
        String sql = "UPDATE customer SET password = ? WHERE TRIM(custID) = TRIM(?)";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Hash the new password before storing
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, custID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ==========================================
    // ORIGINAL CORE METHODS
    // ==========================================

  public boolean registerCustomer(Customer customer) {
        String sql = "INSERT INTO customer (custID, custName, custNO, custEmail, password) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Hash the password before storing
            String hashedPassword = PasswordUtil.hashPassword(customer.getPassword());
            
            pstmt.setString(1, customer.getCustID());
            pstmt.setString(2, customer.getCustName());
            pstmt.setString(3, customer.getCustNO());
            pstmt.setString(4, customer.getCustEmail());
            pstmt.setString(5, hashedPassword); // Store hashed password
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

     public Customer login(String email, String password) {
        String sql = "SELECT * FROM customer WHERE custEmail = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    
                    // Verify the password against the stored hash
                    if (PasswordUtil.verifyPassword(password, storedHash)) {
                        Customer customer = new Customer();
                        customer.setCustID(rs.getString("custID"));
                        customer.setCustName(rs.getString("custName"));
                        customer.setCustNO(rs.getString("custNO"));
                        customer.setCustEmail(rs.getString("custEmail"));
                        return customer;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM customer WHERE custEmail = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String generateCustomerID() {
        String sql = "SELECT custID FROM customer ORDER BY custID DESC LIMIT 1";
        try (Connection conn = dbConn.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                String lastID = rs.getString("custID");
                if (lastID != null && lastID.startsWith("CUST")) {
                    int numericPart = Integer.parseInt(lastID.substring(4));
                    return String.format("CUST%04d", numericPart + 1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "CUST0001";
    }

    public boolean updateCustomerProfile(String custID, String name, String email, String phone) {
        String sql = "UPDATE customer SET custName = ?, custEmail = ?, custNO = ? WHERE TRIM(custID) = TRIM(?)";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, custID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer getCustomerByID(String custID) {
        String sql = "SELECT * FROM customer WHERE TRIM(custID) = TRIM(?)";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, custID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustID(rs.getString("custID"));
                    customer.setCustName(rs.getString("custName"));
                    customer.setCustEmail(rs.getString("custEmail"));
                    customer.setCustNO(rs.getString("custNO"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}