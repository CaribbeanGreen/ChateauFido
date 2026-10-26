package com.chateaufido.controller;

import com.chateaufido.DAO.ReservationDAO;
import com.chateaufido.DAO.PaymentDAO;
import com.chateaufido.model.Reservation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/confirmBooking")
public class ConfirmBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String custID = (String) session.getAttribute("custID");

        try {
            // 1. Get all parameters from the hidden form fields
            String dogID = request.getParameter("dogID");
            String roomID = request.getParameter("roomID");
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String totalAmountStr = request.getParameter("totalAmount");

            // 2. Parse and validate inputs
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);
            BigDecimal totalAmount = new BigDecimal(totalAmountStr);

            // 3. Create Reservation object
            ReservationDAO reservationDAO = new ReservationDAO();
            String reservID = reservationDAO.generateReservationID();

            Reservation reservation = new Reservation();
            reservation.setReservID(reservID);
            reservation.setRoomID(roomID);
            reservation.setDogID(dogID);
            reservation.setCustID(custID);
            reservation.setStaffID("STAFF001"); // Default staff or get from session if available
            reservation.setCheckInDate(Date.valueOf(checkIn));
            reservation.setCheckOutDate(Date.valueOf(checkOut));
            reservation.setStatus("Confirmed");
            reservation.setTotalAmount(totalAmount);

            // 4. Save reservation to database
            boolean reservationCreated = reservationDAO.createReservation(reservation);

            if (!reservationCreated) {
                response.sendRedirect("booking?error=reservation_failed");
                return;
            }

            // 5. Record payment
            PaymentDAO paymentDAO = new PaymentDAO();
            String payID = generatePaymentID();
            boolean paymentRecorded = paymentDAO.recordPayment(payID, reservID, totalAmount.doubleValue());

            if (!paymentRecorded) {
                System.err.println("Warning: Reservation created but payment recording failed");
            }

            // 6. Store reservation details in session for confirmation page
            session.setAttribute("lastReservationID", reservID);
            session.setAttribute("lastBookingAmount", totalAmount);
            session.setAttribute("lastCheckIn", checkInStr);
            session.setAttribute("lastCheckOut", checkOutStr);

            // 7. Redirect to confirmation page
            response.sendRedirect(request.getContextPath() + "/views/bookingConfirmation.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking?error=booking_failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("booking");
    }

    /**
     * Generate unique payment ID
     */
    private String generatePaymentID() {
        return "PAY" + System.currentTimeMillis();
    }
}