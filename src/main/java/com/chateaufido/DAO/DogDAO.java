package com.chateaufido.DAO;

import com.chateaufido.config.DatabaseConnection;
import com.chateaufido.model.Dog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DogDAO {
    private DatabaseConnection dbConn;

    public DogDAO() {
        try {
            this.dbConn = DatabaseConnection.getInstance();
            System.out.println("DogDAO: DatabaseConnection initialized");
        } catch (Exception e) {
            System.err.println("DogDAO: Failed to initialize DatabaseConnection");
            e.printStackTrace();
        }
    }

    public boolean addDog(Dog dog) {
        String sql = "INSERT INTO dog (dogID, custID, dogName, dogAge, dogBreed, vaccineDocPath, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            if (dbConn == null) {
                System.err.println("addDog: dbConn is NULL");
                return false;
            }
            
            conn = dbConn.getConnection();
            if (conn == null) {
                System.err.println("addDog: Connection is NULL");
                return false;
            }
            
            System.out.println("addDog: Connection established");
            System.out.println("addDog: Inserting dog with ID: " + dog.getDogID());
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dog.getDogID());
            pstmt.setString(2, dog.getCustID());
            pstmt.setString(3, dog.getDogName());
            pstmt.setInt(4, dog.getDogAge());
            pstmt.setString(5, dog.getDogBreed());
            pstmt.setString(6, dog.getVaccineDocPath());
            pstmt.setString(7, "Pending");
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("addDog: Rows affected = " + rowsAffected);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("addDog: SQLException occurred");
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Dog> getPendingDogs() {
        List<Dog> dogs = new ArrayList<>();
        String sql = "SELECT * FROM dog WHERE status = 'Pending'";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            if (dbConn == null) return dogs;
            conn = dbConn.getConnection();
            if (conn == null) return dogs;
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                dogs.add(mapResultSetToDog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dogs;
    }

    public boolean updateVaccineStatus(String dogID, String status) {
        String sql = "UPDATE dog SET status = ? WHERE dogID = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            if (dbConn == null) return false;
            conn = dbConn.getConnection();
            if (conn == null) return false;
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setString(2, dogID);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Dog> getDogsByCustomer(String custID) {
        List<Dog> dogs = new ArrayList<>();
        String sql = "SELECT * FROM dog WHERE custID = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            if (dbConn == null) return dogs;
            conn = dbConn.getConnection();
            if (conn == null) return dogs;
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, custID);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                dogs.add(mapResultSetToDog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dogs;
    }

    private Dog mapResultSetToDog(ResultSet rs) throws SQLException {
        Dog dog = new Dog();
        dog.setDogID(rs.getString("dogID"));
        dog.setCustID(rs.getString("custID"));
        dog.setDogName(rs.getString("dogName"));
        dog.setDogAge(rs.getInt("dogAge"));
        dog.setDogBreed(rs.getString("dogBreed"));
        dog.setVaccineDocPath(rs.getString("vaccineDocPath"));
        dog.setVaccineStatus(rs.getString("status")); 
        return dog;
    }

    public List<Dog> getVerifiedDogsByCustomer(String custID) {
        List<Dog> dogs = new ArrayList<>();
        String sql = "SELECT * FROM dog WHERE custID = ? AND status = 'Approved'";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            if (dbConn == null) return dogs;
            conn = dbConn.getConnection();
            if (conn == null) return dogs;
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, custID);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                dogs.add(mapResultSetToDog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dogs;
    }

    public String generateDogID() {
        // Try to get max ID from database
        String sql = "SELECT dogID FROM dog ORDER BY dogID DESC LIMIT 1";
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            System.out.println("generateDogID: Starting");
            
            if (dbConn == null) {
                System.err.println("generateDogID: dbConn is NULL");
                return "DOG0001";
            }
            
            conn = dbConn.getConnection();
            if (conn == null) {
                System.err.println("generateDogID: Connection is NULL");
                return "DOG0001";
            }
            
            System.out.println("generateDogID: Connection established");
            
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) {
                String lastDogID = rs.getString("dogID");
                System.out.println("generateDogID: Last dog ID found: " + lastDogID);
                
                // Extract numeric part (e.g., "DOG0001" -> 1)
                if (lastDogID != null && lastDogID.startsWith("DOG")) {
                    try {
                        int numericPart = Integer.parseInt(lastDogID.substring(3));
                        String newID = String.format("DOG%04d", numericPart + 1);
                        System.out.println("generateDogID: Generated new ID: " + newID);
                        return newID;
                    } catch (NumberFormatException e) {
                        System.err.println("generateDogID: Error parsing dog ID: " + lastDogID);
                    }
                }
            }
            
            System.out.println("generateDogID: No existing dogs, returning DOG0001");
            return "DOG0001";
            
        } catch (SQLException e) {
            System.err.println("generateDogID: SQLException occurred");
            e.printStackTrace();
            return "DOG0001";
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Dog getDogByID(String dogID) {
        String sql = "SELECT * FROM dog WHERE dogID = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            if (dbConn == null) return null;
            conn = dbConn.getConnection();
            if (conn == null) return null;
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dogID);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToDog(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}