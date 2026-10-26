package com.chateaufido.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/uploads/*")
public class FileDownloadServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "C:/chateau_fido_uploads";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fileName = request.getPathInfo().substring(1); // Remove leading /
        File file = new File(UPLOAD_DIRECTORY + File.separator + fileName);
        
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        response.setContentType(getServletContext().getMimeType(fileName));
        response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
        
        Files.copy(file.toPath(), response.getOutputStream());
    }
}