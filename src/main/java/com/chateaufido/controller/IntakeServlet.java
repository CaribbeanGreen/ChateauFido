package com.chateaufido.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AddDog")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 15    // 15MB
)
public class IntakeServlet extends HttpServlet {

    /**
     * FIXES THE 405 ERROR
     * This method handles clicks from the Dashboard link (GET request)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // When clicking "My Dogs" from Dashboard, roomID will be null.
        // We capture it anyway just in case.
        String roomID = request.getParameter("roomID");
        request.setAttribute("roomID", roomID);
        
        // Send the user to the form
        request.getRequestDispatcher("/views/intake.jsp").forward(request, response);
    }

    /**
     * This handles the "Book" button from the Room selection table (POST request)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String roomID = request.getParameter("roomID");
        request.setAttribute("roomID", roomID);
        
        request.getRequestDispatcher("/views/intake.jsp").forward(request, response);
    }
}