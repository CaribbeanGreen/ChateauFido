package com.chateaufido.controller;

import com.chateaufido.DAO.DogDAO;
import com.chateaufido.model.Dog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myDogs")
@MultipartConfig
public class DogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String custID = (String) session.getAttribute("custID");
            System.out.println("DogServlet: Fetching dogs for customer: " + custID);
            
            // Get all dogs for this customer
            DogDAO dogDAO = new DogDAO();
            List<Dog> dogs = dogDAO.getDogsByCustomer(custID);
            
            System.out.println("DogServlet: Found " + dogs.size() + " dogs");
            
            // Pass dogs list to JSP
            request.setAttribute("dogs", dogs);
            
            // Check for success message
            String success = request.getParameter("success");
            if ("true".equals(success)) {
                request.setAttribute("successMessage", "Dog registered successfully! Awaiting verification.");
            }
            
            // Check for roomID (if redirected from booking flow)
            String roomID = request.getParameter("roomID");
            if (roomID != null && !roomID.isEmpty()) {
                request.setAttribute("roomID", roomID);
            }
            
            // Forward to the dogs listing page
            request.getRequestDispatcher("/views/my_dogs.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("DogServlet: Error occurred");
            e.printStackTrace();
            response.sendRedirect("views/error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect POST to GET
        doGet(request, response);
    }
}