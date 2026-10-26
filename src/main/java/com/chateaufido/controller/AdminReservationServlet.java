package com.chateaufido.controller;

import com.chateaufido.DAO.ReservationDAO;
import com.chateaufido.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "AdminReservationServlet", urlPatterns = {"/admin-reservations"})
public class AdminReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if admin is logged in
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            ReservationDAO resDAO = new ReservationDAO();
            String searchQuery = request.getParameter("search");
            
            List<Reservation> reservations;
            
            // 1. Fetch ONLY Confirmed reservations by default
            // This ensures the backend matches the "Confirmed Reservations" title in your JSP
            if (searchQuery != null && !searchQuery.isEmpty()) {
                // If searching, we fetch by ID but still filter for 'Confirmed' in the logic
                Reservation res = resDAO.getReservationById(searchQuery);
                reservations = new java.util.ArrayList<>();
                if (res != null && "Confirmed".equals(res.getStatus())) {
                    reservations.add(res);
                }
            } else {
                // Default view: Only show confirmed
                reservations = resDAO.getReservationsByStatus("Confirmed");
            }

            request.setAttribute("reservations", reservations);
            request.setAttribute("searchQuery", searchQuery);
            request.getRequestDispatcher("/views/AdminReservations.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-dashboard?error=system_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String reservID = request.getParameter("reservID");
        ReservationDAO resDAO = new ReservationDAO();
        
        // Removed 'updateStatus' block because the JSP no longer has the status change UI.
        // Keeping only 'viewReceipt' as it is the only functional action left.
        if ("viewReceipt".equals(action)) {
            Reservation reservation = resDAO.getReservationById(reservID);
            if (reservation != null) {
                request.setAttribute("reservation", reservation);
                request.getRequestDispatcher("/views/AdminReceipt.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-reservations?error=notfound");
            }
        } else {
            // Default fallback if no valid action is sent
            response.sendRedirect(request.getContextPath() + "/admin-reservations");
        }
    }
}