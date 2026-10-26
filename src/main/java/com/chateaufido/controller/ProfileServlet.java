package com.chateaufido.controller;

import com.chateaufido.DAO.CustomerDAO;
import com.chateaufido.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile") // This creates the "masked" URL: chateaufido/profile
public class ProfileServlet extends HttpServlet {

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
        
        // Fetch the data
        Customer customer = customerDAO.getCustomerByID(custID);

        if (customer != null) {
            // Attach the data so profile.jsp can see it
            request.setAttribute("customer", customer);
            
            // FORWARD to the JSP (Hides the .jsp from the URL)
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
        } else {
            response.sendRedirect("dashboard?error=notfound");
        }
    }
}