package com.chateaufido.controller;

import com.chateaufido.DAO.ReservationDAO;
import com.chateaufido.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/reserve") // Updated to match the action in your booking.jsp
public class ReservationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String custID = (String) session.getAttribute("custID");

        // Safety check for session
        if (custID == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 1. Capture inputs (Matching names in your updated booking.jsp)
        String roomID = request.getParameter("roomID");
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");
        
        // Use getParameterValues because a user might have selected multiple dogs
        String[] dogIDs = request.getParameterValues("dogIDs");

        try {
            // 2. Date and Price Calculation
            LocalDate checkInDate = LocalDate.parse(checkInStr);
            LocalDate checkOutDate = LocalDate.parse(checkOutStr);
            
            long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            if (nights <= 0) nights = 1; 

            BigDecimal ratePerNight = new BigDecimal("80.00"); 
            BigDecimal totalAmount = ratePerNight.multiply(new BigDecimal(nights));

            // 3. Create Reservations
            ReservationDAO resDAO = new ReservationDAO();
            boolean overallSuccess = true;

            if (dogIDs != null) {
                for (String dogID : dogIDs) {
                    Reservation res = new Reservation();
                    
                    // Use the sequential ID generator we added to your DAO
                    res.setReservID(resDAO.generateReservationID()); 
                    
                    res.setRoomID(roomID);
                    res.setDogID(dogID);
                    res.setCustID(custID);
                    res.setCheckInDate(java.sql.Date.valueOf(checkInDate));
                    res.setCheckOutDate(java.sql.Date.valueOf(checkOutDate));
                    res.setStatus("PENDING");
                    res.setTotalAmount(totalAmount);
                    res.setStaffID("STAFF001"); // Matches your DB foreign key constraint

                    if (!resDAO.createReservation(res)) {
                        overallSuccess = false;
                    }
                }
            }

            // 4. Final Redirection
            if (overallSuccess) {
                // Redirect to dashboard where "My Bookings" will now show the data
                response.sendRedirect(request.getContextPath() + "/dashboard?booking=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/views/booking.jsp?error=db_error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/booking.jsp?error=invalid_data");
        }
    }
    
}