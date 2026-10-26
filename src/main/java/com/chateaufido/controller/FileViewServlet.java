package com.chateaufido.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/viewDocument/*")
public class FileViewServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "C:/chateau_fido_uploads";
    
  protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    String pathInfo = request.getPathInfo();
    if (pathInfo == null || pathInfo.length() <= 1) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name required");
        return;
    }
    
    String fileName = pathInfo.substring(1); // Remove leading /
    
    // Remove "uploads/" prefix if present
    if (fileName.startsWith("uploads/")) {
        fileName = fileName.substring(8);
    }
    
    File file = new File(UPLOAD_DIRECTORY, fileName);
    
    System.out.println("FileViewServlet: Original path: " + pathInfo);
    System.out.println("FileViewServlet: Cleaned filename: " + fileName);
    System.out.println("FileViewServlet: Full path: " + file.getAbsolutePath());
    System.out.println("FileViewServlet: File exists: " + file.exists());
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }
        
        // Determine content type
        String contentType = getServletContext().getMimeType(fileName);
        if (contentType == null) {
            // Fallback based on extension
            if (fileName.toLowerCase().endsWith(".pdf")) {
                contentType = "application/pdf";
            } else if (fileName.toLowerCase().endsWith(".png")) {
                contentType = "image/png";
            } else if (fileName.toLowerCase().endsWith(".jpg") || fileName.toLowerCase().endsWith(".jpeg")) {
                contentType = "image/jpeg";
            } else {
                contentType = "application/octet-stream";
            }
        }
        
        System.out.println("FileViewServlet: Content type: " + contentType);
        
        // Set response headers
        response.setContentType(contentType);
        response.setContentLengthLong(file.length());
        response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
        
        // Stream the file content
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            
            os.flush();
            System.out.println("FileViewServlet: File served successfully");
            
        } catch (IOException e) {
            System.err.println("FileViewServlet: Error serving file");
            e.printStackTrace();
            throw e;
        }
    }
}