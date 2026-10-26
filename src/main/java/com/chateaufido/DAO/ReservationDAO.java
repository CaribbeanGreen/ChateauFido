package com.chateaufido.DAO;

import com.chateaufido.config.DatabaseConnection;
import com.chateaufido.model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ReservationDAO {
    private DatabaseConnection dbConn;

    public ReservationDAO() {
        this.dbConn = DatabaseConnection.getInstance();
    }

    /**
     * RESTORED: Staff: Fetches confirmed bookings starting today for the check-in list.
     * Used by CheckInServlet.java.
     */
    public List<Reservation> getTodayArrivals() {
        List<Reservation> arrivals = new ArrayList<>();
        String sql = "SELECT * FROM reservation WHERE check_in_date = CURDATE() AND status = 'Confirmed'";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Reservation res = new Reservation();
                res.setReservID(rs.getString("reservID"));
                res.setDogID(rs.getString("dogID"));
                res.setRoomID(rs.getString("roomID"));
                res.setCustID(rs.getString("custID"));
                res.setCheckInDate(rs.getDate("check_in_date"));
                res.setCheckOutDate(rs.getDate("check_out_date"));
                res.setStatus(rs.getString("status"));
                // Using getBigDecimal to match your previous setup
                res.setTotalAmount(rs.getBigDecimal("total_amount"));
                arrivals.add(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return arrivals;
    }

    /**
     * RESTORED: Staff: Updates reservation status (e.g., 'Checked-In', 'Completed').
     * Used by CheckInServlet.java.
     */
    public boolean updateReservationStatus(String reservID, String newStatus) {
        String sql = "UPDATE reservation SET status = ? WHERE reservID = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newStatus);
            pstmt.setString(2, reservID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

   // Inside ReservationDAO.java -> createReservation method
// Modify the SQL and the parameter setting for staffID

public boolean createReservation(Reservation res) {
    String sql = "INSERT INTO reservation (reservID, roomID, staffID, dogID, custID, check_in_date, check_out_date, status, total_amount, payment_status, reservation_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
    String updateRoom = "UPDATE room SET status = 'Occupied' WHERE roomID = ?";

    try (Connection conn = dbConn.getConnection()) {
        conn.setAutoCommit(false);
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             PreparedStatement pstmtRoom = conn.prepareStatement(updateRoom)) {
            
            pstmt.setString(1, res.getReservID());
            pstmt.setString(2, res.getRoomID());
            pstmt.setString(3, res.getStaffID() != null ? res.getStaffID() : "STAFF001");
            pstmt.setString(4, res.getDogID());
            pstmt.setString(5, res.getCustID());
            pstmt.setDate(6, new java.sql.Date(res.getCheckInDate().getTime()));
            pstmt.setDate(7, new java.sql.Date(res.getCheckOutDate().getTime()));
            pstmt.setString(8, res.getStatus());
            pstmt.setBigDecimal(9, res.getTotalAmount());
            pstmt.setString(10, res.getPaymentStatus() != null ? res.getPaymentStatus() : "PENDING");
            pstmt.executeUpdate();

            pstmtRoom.setString(1, res.getRoomID());
            pstmtRoom.executeUpdate();

            conn.commit();
            return true;
        } catch (SQLException e) {
            conn.rollback();
            e.printStackTrace();
            return false;
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    /**
     * RESTORED: Fetch all reservations for a specific customer.
     */
    public List<Reservation> getReservationsByCustomer(String custID) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservation WHERE custID = ? ORDER BY check_in_date DESC";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, custID);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Reservation res = new Reservation();
                res.setReservID(rs.getString("reservID"));
                res.setCheckInDate(rs.getDate("check_in_date"));
                res.setCheckOutDate(rs.getDate("check_out_date"));
                res.setRoomID(rs.getString("roomID"));
                res.setStatus(rs.getString("status"));
                res.setTotalAmount(rs.getBigDecimal("total_amount"));
                list.add(res);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    /**
     * RESTORED: Dashboard statistics for daily check-ins.
     */
public int getTodayCheckInsCount() {
    // Added: AND status = 'Confirmed' to match the list logic
    String sql = "SELECT COUNT(*) FROM reservation WHERE check_in_date = CURDATE() AND status = 'Confirmed'";
    try (Connection conn = dbConn.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) { 
        e.printStackTrace(); 
    }
    return 0;
}

    /**
     * RESTORED: Dashboard statistics for active confirmed guests.
     */
public int getActiveGuestsCount() {
    // Changed: 'Confirmed' to 'Checked-In' to reflect dogs currently on-site
    String sql = "SELECT COUNT(*) FROM reservation WHERE status = 'Checked-In'";
    try (Connection conn = dbConn.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) { 
        e.printStackTrace(); 
    }
    return 0;
}
    /**
     * RESTORED: Auto-generation of unique Reservation IDs.
     */
    public String generateReservationID() {
        String sql = "SELECT MAX(CAST(SUBSTRING(reservID, 5) AS UNSIGNED)) as maxID FROM reservation";
        try (Connection conn = dbConn.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return String.format("RESV%04d", rs.getInt("maxID") + 1);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return "RESV0001";
    }
    
    // Add these methods to your ReservationDAO.java class

/**
 * Fetch all reservations with full details
 */
// Update your getAllReservations() method to include joined data:
public List<Reservation> getAllReservations() {
    List<Reservation> list = new ArrayList<>();
    String sql = "SELECT r.*, c.custName, c.custEmail, c.custNO, d.dogName, d.breed, " +
                 "rm.room_type, rm.price_per_night " +
                 "FROM reservation r " +
                 "LEFT JOIN customer c ON r.custID = c.custID " +
                 "LEFT JOIN dog d ON r.dogID = d.dogID " +
                 "LEFT JOIN room rm ON r.roomID = rm.roomID " +
                 "ORDER BY r.check_in_date DESC";
    
    try (Connection conn = dbConn.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        
        while (rs.next()) {
            Reservation res = mapResultSetToReservation(rs);
            list.add(res);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}


/**
 * Fetch reservations by status
 */
public List<Reservation> getReservationsByStatus(String status) {
    List<Reservation> list = new ArrayList<>();
    String sql = "SELECT * FROM reservation WHERE status = ? ORDER BY check_in_date DESC";
    
    try (Connection conn = dbConn.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, status);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Reservation res = new Reservation();
            res.setReservID(rs.getString("reservID"));
            res.setRoomID(rs.getString("roomID"));
            res.setDogID(rs.getString("dogID"));
            res.setStaffID(rs.getString("staffID"));
            res.setCustID(rs.getString("custID"));
            res.setCheckInDate(rs.getDate("check_in_date"));
            res.setCheckOutDate(rs.getDate("check_out_date"));
            res.setStatus(rs.getString("status"));
            res.setTotalAmount(rs.getBigDecimal("total_amount"));
            list.add(res);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

/**
 * Search reservations by reservation ID or customer ID
 */
public List<Reservation> searchReservations(String searchQuery) {
    List<Reservation> list = new ArrayList<>();
    String sql = "SELECT * FROM reservation WHERE reservID LIKE ? OR custID LIKE ? ORDER BY check_in_date DESC";
    
    try (Connection conn = dbConn.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        String searchPattern = "%" + searchQuery + "%";
        pstmt.setString(1, searchPattern);
        pstmt.setString(2, searchPattern);
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Reservation res = new Reservation();
            res.setReservID(rs.getString("reservID"));
            res.setRoomID(rs.getString("roomID"));
            res.setDogID(rs.getString("dogID"));
            res.setStaffID(rs.getString("staffID"));
            res.setCustID(rs.getString("custID"));
            res.setCheckInDate(rs.getDate("check_in_date"));
            res.setCheckOutDate(rs.getDate("check_out_date"));
            res.setStatus(rs.getString("status"));
            res.setTotalAmount(rs.getBigDecimal("total_amount"));
            list.add(res);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}

/**
 * Get reservation by ID with full details
 */
// Also update the other methods to use this helper:
public Reservation getReservationById(String reservID) {
    String sql = "SELECT r.*, c.custName, c.custEmail, c.custNO, d.dogName, d.breed, " +
                 "rm.room_type, rm.price_per_night " +
                 "FROM reservation r " +
                 "LEFT JOIN customer c ON r.custID = c.custID " +
                 "LEFT JOIN dog d ON r.dogID = d.dogID " +
                 "LEFT JOIN room rm ON r.roomID = rm.roomID " +
                 "WHERE r.reservID = ?";
    
    try (Connection conn = dbConn.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, reservID);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            return mapResultSetToReservation(rs);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}
// Add this helper method to map ResultSet with joined fields:
private Reservation mapResultSetToReservation(ResultSet rs) throws SQLException {
    Reservation res = new Reservation();
    res.setReservID(rs.getString("reservID"));
    res.setRoomID(rs.getString("roomID"));
    res.setDogID(rs.getString("dogID"));
    res.setStaffID(rs.getString("staffID"));
    res.setCustID(rs.getString("custID"));
    res.setCheckInDate(rs.getDate("check_in_date"));
    res.setCheckOutDate(rs.getDate("check_out_date"));
    res.setStatus(rs.getString("status"));
    res.setTotalAmount(rs.getBigDecimal("total_amount"));
    
    // Joined fields
    res.setCustomerName(rs.getString("custName"));
    res.setCustomerEmail(rs.getString("custEmail"));
    res.setCustomerPhone(rs.getString("custNO"));
    res.setDogName(rs.getString("dogName"));
    res.setDogBreed(rs.getString("breed"));
    res.setRoomType(rs.getString("room_type"));
    res.setRoomPrice(rs.getBigDecimal("price_per_night"));
    
    return res;
}

}