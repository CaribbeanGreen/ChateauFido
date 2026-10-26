package com.chateaufido.controller;


import com.chateaufido.model.Customer;
import com.chateaufido.DAO.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Show registration page
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (name == null || phone == null || email == null || 
            password == null || confirmPassword == null ||
            name.trim().isEmpty() || phone.trim().isEmpty() || 
            email.trim().isEmpty() || password.isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Password length validation
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (customerDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered. Please login.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Create customer object
        Customer customer = new Customer();
        customer.setCustID(customerDAO.generateCustomerID());
        customer.setCustName(name);
        customer.setCustNO(phone);
        customer.setCustEmail(email);
        customer.setPassword(password); // In production, hash this password!
        
        // Register customer
        boolean success = customerDAO.registerCustomer(customer);
        
        if (success) {
            System.out.println("✓ New customer registered: " + email);
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}