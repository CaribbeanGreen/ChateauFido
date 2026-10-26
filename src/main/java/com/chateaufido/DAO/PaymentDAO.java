package com.chateaufido.DAO;

import com.chateaufido.model.Payment;
import com.chateaufido.config.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private DatabaseConnection dbConn;

    // Constructor - FIXED: Initialize dbConn
    public PaymentDAO() {
        this.dbConn = DatabaseConnection.getInstance();
    }

    // 1. Record a new payment after a successful booking
    public boolean recordPayment(String payID, String reservID, double amount) {
        String sql = "INSERT INTO payment (payID, reservID, amount, pay_time, pay_date) VALUES (?, ?, ?, CURTIME(), CURDATE())";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, payID);
            pstmt.setString(2, reservID);
            pstmt.setDouble(3, amount);
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Error recording payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // 2. Fetch payment history for a specific customer (to show on Dashboard)
    public List<Payment> getPaymentHistoryByCustomer(String custID) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.* FROM payment p " +
                     "JOIN reservation r ON p.reservID = r.reservID " +
                     "WHERE r.custID = ? " +
                     "ORDER BY p.pay_date DESC, p.pay_time DESC";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, custID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Payment pay = new Payment();
                pay.setPayID(rs.getString("payID"));
                pay.setReservID(rs.getString("reservID"));
                pay.setAmount(rs.getDouble("amount"));
                pay.setPayTime(rs.getTime("pay_time"));
                pay.setPayDate(rs.getDate("pay_date"));
                payments.add(pay);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    // 3. Get total revenue for Admin (Current Month)
    public double getTotalMonthlyRevenue() {
        double total = 0;
        String sql = "SELECT SUM(amount) as total FROM payment " +
                     "WHERE MONTH(pay_date) = MONTH(CURRENT_DATE()) " +
                     "AND YEAR(pay_date) = YEAR(CURRENT_DATE())";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // 4. Find payment details for a specific reservation
    public Payment getPaymentByReservation(String reservID) {
        Payment pay = null;
        String sql = "SELECT * FROM payment WHERE reservID = ?";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, reservID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                pay = new Payment();
                pay.setPayID(rs.getString("payID"));
                pay.setReservID(rs.getString("reservID"));
                pay.setAmount(rs.getDouble("amount"));
                pay.setPayTime(rs.getTime("pay_time"));
                pay.setPayDate(rs.getDate("pay_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pay;
    }
}