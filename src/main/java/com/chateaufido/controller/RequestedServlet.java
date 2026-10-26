package com.chateaufido.controller;

import com.chateaufido.DAO.DogDAO;
import com.chateaufido.model.Dog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/final")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, 
    maxFileSize = 1024 * 1024 * 10,      
    maxRequestSize = 1024 * 1024 * 15    
)
public class RequestedServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== RequestedServlet START ===");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            System.err.println("ERROR: No session or custID");
            response.sendRedirect("login.jsp");
            return;
        }

        String custID = null;
        String dogName = null;
        String dogAgeStr = null;
        String dogBreed = null;
        String roomID = null;
        Part filePart = null;
        String fileName = null;

        try {
            custID = (String) session.getAttribute("custID");
            System.out.println("Customer ID: " + custID);
            
            dogName = request.getParameter("dogName");
            System.out.println("Dog Name: " + dogName);
            
            dogAgeStr = request.getParameter("dogAge");
            System.out.println("Dog Age String: " + dogAgeStr);
            
            dogBreed = request.getParameter("dogBreed");
            System.out.println("Dog Breed: " + dogBreed);
            
            roomID = request.getParameter("roomID");
            System.out.println("Room ID: " + roomID);

            // Validate mandatory fields
            if (dogName == null || dogName.trim().isEmpty()) {
                throw new IllegalArgumentException("Dog name is required");
            }
            if (dogAgeStr == null || dogAgeStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Dog age is required");
            }
            if (dogBreed == null || dogBreed.trim().isEmpty()) {
                throw new IllegalArgumentException("Dog breed is required");
            }

            System.out.println("Step 1: Parameters validated");

            // Handle File Upload
            filePart = request.getPart("vaccineFile");
            System.out.println("File part: " + (filePart != null ? "Found" : "NULL"));
            
            if (filePart == null) {
                throw new IllegalArgumentException("No file uploaded");
            }
            
            System.out.println("File size: " + filePart.getSize());
            
            if (filePart.getSize() == 0) {
                throw new IllegalArgumentException("File is empty");
            }

            String originalFileName = filePart.getSubmittedFileName();
            System.out.println("Original filename: " + originalFileName);
            
            if (originalFileName == null || originalFileName.trim().isEmpty()) {
                throw new IllegalArgumentException("Invalid filename");
            }

            System.out.println("Step 2: File validated");

            // Generate unique filename
            fileName = UUID.randomUUID().toString() + "_" + originalFileName;
            System.out.println("Generated filename: " + fileName);
            
            // Fixed upload directory - change this to your preferred location
            String uploadPath = "C:/chateau_fido_uploads"; // Windows
            // String uploadPath = "/var/chateau_fido_uploads"; // Linux/Mac
            System.out.println("Upload path: " + uploadPath);
            
            // Create directory if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                System.out.println("Created upload directory: " + created + " at " + uploadPath);
            }

            // Save file using InputStream (more reliable than filePart.write)
            String fullPath = uploadPath + File.separator + fileName;
            System.out.println("Saving file to: " + fullPath);
            
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(fullPath), StandardCopyOption.REPLACE_EXISTING);
            }
            
            System.out.println("Step 3: File saved successfully");
            
            String relativePath = "uploads/" + fileName;

            // Parse age
            int dogAge = Integer.parseInt(dogAgeStr);
            System.out.println("Parsed age: " + dogAge);
            
            if (dogAge < 0 || dogAge > 30) {
                throw new IllegalArgumentException("Invalid age: " + dogAge);
            }

            System.out.println("Step 4: Creating DogDAO");
            
            // Create DAO
            DogDAO dogDAO = new DogDAO();
            System.out.println("DogDAO created successfully");
            
            System.out.println("Step 5: Generating Dog ID");
            String dogID = dogDAO.generateDogID();
            System.out.println("Generated Dog ID: " + dogID);

            // Create Dog object
            Dog newDog = new Dog();
            newDog.setDogID(dogID);
            newDog.setCustID(custID);
            newDog.setDogName(dogName);
            newDog.setDogAge(dogAge);
            newDog.setDogBreed(dogBreed);
            newDog.setVaccineDocPath(relativePath);
            newDog.setVaccineStatus("Pending");

            System.out.println("Step 6: Dog object created");
            System.out.println("  - ID: " + newDog.getDogID());
            System.out.println("  - CustID: " + newDog.getCustID());
            System.out.println("  - Name: " + newDog.getDogName());
            System.out.println("  - Age: " + newDog.getDogAge());
            System.out.println("  - Breed: " + newDog.getDogBreed());
            System.out.println("  - Doc Path: " + newDog.getVaccineDocPath());
            System.out.println("  - Status: " + newDog.getVaccineStatus());

            System.out.println("Step 7: Attempting database insert");
            boolean success = dogDAO.addDog(newDog);
            System.out.println("Database insert result: " + success);

            if (success) {
                System.out.println("SUCCESS: Redirecting to MyDogs");
                String redirectUrl = request.getContextPath() + "/myDogs?success=true";
                if (roomID != null && !roomID.isEmpty()) {
                    redirectUrl += "&roomID=" + roomID;
                }
                response.sendRedirect(redirectUrl);
            } else {
                System.err.println("ERROR: Database insert returned false");
                response.sendRedirect("views/intake.jsp?error=db_error");
            }

        } catch (NumberFormatException e) {
            System.err.println("ERROR: Number format exception");
            e.printStackTrace();
            response.sendRedirect("views/intake.jsp?error=invalid_age&msg=" + e.getMessage());
            
        } catch (IllegalArgumentException e) {
            System.err.println("ERROR: Illegal argument");
            e.printStackTrace();
            response.sendRedirect("views/intake.jsp?error=validation&msg=" + e.getMessage());
            
        } catch (Exception e) {
            System.err.println("ERROR: Unexpected exception - " + e.getClass().getName());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
            
            String errorMsg = e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName();
            response.sendRedirect("views/intake.jsp?error=server_error&msg=" + errorMsg);
        }
        
        System.out.println("=== RequestedServlet END ===");
    }
}