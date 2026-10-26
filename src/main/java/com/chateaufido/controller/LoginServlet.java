/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.controller;

import com.chateaufido.model.Customer;
import com.chateaufido.model.Staff;
import com.chateaufido.DAO.CustomerDAO;
import com.chateaufido.DAO.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    private CustomerDAO customerDAO;
    private StaffDAO staffDAO;
    
    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        staffDAO = new StaffDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // If already logged in, redirect based on role
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("role") != null) {
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
            return;
        }
        
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 1. Try to login as Customer
        Customer customer = customerDAO.login(email, password);
        
        if (customer != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", customer);
            session.setAttribute("custID", customer.getCustID());
            session.setAttribute("custName", customer.getCustName());
            session.setAttribute("role", "CUSTOMER"); // Set Role
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        // 2. If Customer failed, try to login as Staff (Admin)
        Staff staff = staffDAO.login(email, password);
        
        if (staff != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("admin", staff);
            session.setAttribute("staffName", staff.getStaffName());
            session.setAttribute("role", "ADMIN"); // Set Role
            System.out.println("✓ Admin logged in: " + staff.getStaffEmail());
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            return;
        }
        
        // 3. If both failed
        request.setAttribute("error", "Invalid email or password");
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}