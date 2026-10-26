package com.chateaufido.controller;

import com.chateaufido.DAO.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Show the change password form
        request.getRequestDispatcher("/views/changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String custID = (String) session.getAttribute("custID");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        System.out.println("=== Change Password Request ===");
        System.out.println("Customer ID: " + custID);

        // Validation
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            System.err.println("ERROR: Missing required fields");
            response.sendRedirect(request.getContextPath() + "/changePassword?error=missing_fields");
            return;
        }

        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            System.err.println("ERROR: New passwords do not match");
            response.sendRedirect(request.getContextPath() + "/changePassword?error=mismatch");
            return;
        }

        // Check password strength (minimum 6 characters)
        if (newPassword.length() < 6) {
            System.err.println("ERROR: Password too short");
            response.sendRedirect(request.getContextPath() + "/changePassword?error=weak_password");
            return;
        }

        // Verify current password and update
        CustomerDAO customerDAO = new CustomerDAO();
        
        // First, verify current password
        if (!customerDAO.verifyCurrentPassword(custID, currentPassword)) {
            System.err.println("ERROR: Current password is incorrect");
            response.sendRedirect(request.getContextPath() + "/changePassword?error=wrong_current");
            return;
        }

        // Update password
        boolean success = customerDAO.updatePassword(custID, newPassword);

        if (success) {
            System.out.println("SUCCESS: Password changed for customer " + custID);
            response.sendRedirect(request.getContextPath() + "/changePassword?success=true");
        } else {
            System.err.println("ERROR: Failed to update password in database");
            response.sendRedirect(request.getContextPath() + "/changePassword?error=server_error");
        }
    }
}