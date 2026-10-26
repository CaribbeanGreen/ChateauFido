package com.chateaufido.DAO;

import com.chateaufido.config.DatabaseConnection;
import com.chateaufido.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    private DatabaseConnection dbConn = DatabaseConnection.getInstance();

    /**
     * Admin: Add a new room to the system.
     */
    public boolean addRoom(Room room) {
        String sql = "INSERT INTO room (roomID, price_per_night, status, room_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, room.getRoomID());
            pstmt.setDouble(2, room.getPricePerNight());
            pstmt.setString(3, room.getStatus());
            pstmt.setString(4, room.getRoomType());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM room";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getString("roomID"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setStatus(rs.getString("status"));
                room.setRoomType(rs.getString("room_type"));
                rooms.add(room);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return rooms;
    }

    /**
     * Operations: Update room status during Check-In (Occupied) or Check-Out (Available).
     */
    public boolean updateRoomStatus(String roomID, String newStatus) {
        String sql = "UPDATE room SET status = ? WHERE roomID = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newStatus);
            pstmt.setString(2, roomID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Customer: Retrieve all rooms that are currently available for booking.
     */
    public List<Room> getAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM room WHERE status = 'Available'";
        
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getString("roomID"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setStatus(rs.getString("status"));
                room.setRoomType(rs.getString("room_type"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public Room getRoomByID(String roomID) {
        String sql = "SELECT * FROM room WHERE roomID = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getString("roomID"));
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setStatus(rs.getString("status")); // FIXED: Now retrieves status
                return room;
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return null;
    }

    /**
     * Admin: Delete a room from the system.
     * Simple version without validation - deletes any room.
     */
    public boolean deleteRoom(String roomID) {
        String sql = "DELETE FROM room WHERE roomID = ?";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, roomID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}