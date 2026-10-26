package com.chateaufido.controller;

import com.chateaufido.DAO.CustomerDAO;
import com.chateaufido.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String custID = (String) session.getAttribute("custID");
        CustomerDAO customerDAO = new CustomerDAO();
        
        // Fetch the customer data
        Customer customer = customerDAO.getCustomerByID(custID);

        if (customer != null) {
            // Pass customer object to JSP for pre-filling the form
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/views/editProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("profile?error=notfound");
        }
    }
}