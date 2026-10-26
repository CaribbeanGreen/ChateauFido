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
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

  @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("custID") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String custID = (String) session.getAttribute("custID");

    // 1. Fetch available rooms
    RoomDAO roomDAO = new RoomDAO();
    List<Room> availableRooms = roomDAO.getAvailableRooms();

    // 2. Fetch only VERIFIED dogs for this customer
    DogDAO dogDAO = new DogDAO();
    List<Dog> verifiedDogs = dogDAO.getVerifiedDogsByCustomer(custID);

    // 3. Send both lists to the JSP
    request.setAttribute("rooms", availableRooms);
    request.setAttribute("userDogs", verifiedDogs); // This matches ${userDogs} in booking.jsp
    
    request.getRequestDispatcher("/views/booking.jsp").forward(request, response);
}
}