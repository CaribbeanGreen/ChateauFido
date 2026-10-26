package com.chateaufido.controller;

import com.chateaufido.DAO.ReservationDAO;
import com.chateaufido.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Check if user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("custID") == null) {
            // Not logged in → redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Get logged-in customer ID from session
        String custID = (String) session.getAttribute("custID");

        // 3. Fetch reservations for this customer
        ReservationDAO resDAO = new ReservationDAO();
        List<Reservation> reservations = resDAO.getReservationsByCustomer(custID);

        // 4. Send data to JSP
        request.setAttribute("reservations", reservations);

        // 5. Forward to dashboard page
        request.getRequestDispatcher("/views/dashboard.jsp")
               .forward(request, response);
    }
}
