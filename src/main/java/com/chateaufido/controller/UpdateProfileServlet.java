package com.chateaufido.controller;

import com.chateaufido.DAO.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get customer ID from session
        String custID = (String) session.getAttribute("custID");
        
        // Get form parameters
        String name = request.getParameter("custName");
        String email = request.getParameter("custEmail");
        String phone = request.getParameter("custPhone");
        
        // Debug logging
        System.out.println("=== Update Profile Request ===");
        System.out.println("Customer ID: [" + custID + "]");
        System.out.println("New Name: " + name);
        System.out.println("New Email: " + email);
        System.out.println("New Phone: " + phone);
        
        // Validate inputs
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty()) {
            System.err.println("ERROR: Missing required fields");
            response.sendRedirect(request.getContextPath() + "/editProfile?error=missing_fields");
            return;
        }

        // Update database
        CustomerDAO customerDAO = new CustomerDAO();
        boolean success = customerDAO.updateCustomerProfile(custID, name, email, phone);

        if (success) {
            System.out.println("SUCCESS: Profile updated for " + custID);
            
            // Update session attributes so changes reflect immediately
            session.setAttribute("custName", name);
            session.setAttribute("custEmail", email);
            session.setAttribute("custPhone", phone);
            
            // Redirect back to profile view with success message
            response.sendRedirect(request.getContextPath() + "/profile?update=success");
        } else {
            System.err.println("ERROR: Update failed for customer ID: " + custID);
            response.sendRedirect(request.getContextPath() + "/editProfile?error=not_found");
        }
    }
}