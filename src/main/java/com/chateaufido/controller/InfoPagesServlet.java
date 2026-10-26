package com.chateaufido.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Shared servlet for static information pages
 * Handles About Us and Contact Us pages
 */
@WebServlet(urlPatterns = {"/about", "/contact"})
public class InfoPagesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/about":
                request.getRequestDispatcher("/views/about.jsp").forward(request, response);
                break;
            case "/contact":
                request.getRequestDispatcher("/views/contact.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Handle contact form submission
        if ("/contact".equals(request.getServletPath())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");
            
            // Log the contact form submission
            System.out.println("=== Contact Form Submission ===");
            System.out.println("Name: " + name);
            System.out.println("Email: " + email);
            System.out.println("Subject: " + subject);
            System.out.println("Message: " + message);
            
            // In production, you would:
            // 1. Save to database
            // 2. Send email notification to admin
            // 3. Send confirmation email to customer
            
            // Redirect with success message
            request.setAttribute("successMessage", "Thank you for contacting us! We'll get back to you within 24 hours.");
            request.getRequestDispatcher("/views/contact.jsp").forward(request, response);
        } else {
            doGet(request, response);
        }
    }
}