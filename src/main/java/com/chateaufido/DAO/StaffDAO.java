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
import com.chateaufido.model.PasswordUtil;
import com.chateaufido.model.Staff;
import java.sql.*;

public class StaffDAO {
    private DatabaseConnection dbConn;

    public StaffDAO() {
        this.dbConn = DatabaseConnection.getInstance();
    }

    // UPDATED Staff Login Method with hashing
    public Staff login(String email, String password) {
        String sql = "SELECT * FROM staff WHERE staffEmail = ?";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("password");
                
                // Verify the password against the stored hash
                if (PasswordUtil.verifyPassword(password, storedHash)) {
                    Staff staff = new Staff();
                    staff.setStaffID(rs.getString("staffID"));
                    staff.setStaffName(rs.getString("staffName"));
                    staff.setStaffEmail(rs.getString("staffEmail"));
                    return staff;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Optional: Add method to update staff password
    public boolean updateStaffPassword(String staffID, String newPassword) {
        String sql = "UPDATE staff SET password = ? WHERE staffID = ?";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Hash the new password before storing
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, staffID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}