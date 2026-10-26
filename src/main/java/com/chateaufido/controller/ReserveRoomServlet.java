package com.chateaufido.controller;

import com.chateaufido.DAO.DogDAO;
import com.chateaufido.DAO.RoomDAO;
import com.chateaufido.model.Dog;
import com.chateaufido.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/reserveRoom")
public class ReserveRoomServlet extends HttpServlet {

    /**
     * Handles the POST request from booking.jsp when "Select Room" is clicked.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("custID") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Get parameters from the form
        String dogID = request.getParameter("dogID");
        String roomID = request.getParameter("roomID");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        try {
            // 2. Parse Dates and Calculate Stay Duration
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);
            
            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
            
            // Ensure at least 1 night is charged if dates are same day
            if (nights <= 0) {
                nights = 1;
            }

            // 3. Fetch full details from DAOs
            DogDAO dogDAO = new DogDAO();
            RoomDAO roomDAO = new RoomDAO();
            
            Dog selectedDog = dogDAO.getDogByID(dogID);
            Room selectedRoom = roomDAO.getRoomByID(roomID);

            // 4. Calculate Price using the room's actual price
            double pricePerNight = selectedRoom.getPricePerNight();
            double totalPrice = nights * pricePerNight;

            // 5. Pass data to the BookingSummary.jsp
            request.setAttribute("selectedDog", selectedDog);
            request.setAttribute("selectedRoom", selectedRoom);
            request.setAttribute("checkInDate", checkInStr);
            request.setAttribute("checkOutDate", checkOutStr);
            request.setAttribute("nights", nights);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("pricePerNight", pricePerNight);

            // 6. Forward to the summary/payment page
            request.getRequestDispatcher("/views/BookingSummary.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Redirect back to booking with an error message if something fails
            response.sendRedirect("booking?error=invalid_dates");
        }
    }

    /**
     * Handles accidental direct URL access (GET request).
     * Redirects users back to the booking selection page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("booking");
    }
}