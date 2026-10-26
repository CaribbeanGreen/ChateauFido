package com.chateaufido.controller;

import com.chateaufido.DAO.RoomDAO;
import com.chateaufido.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/admin-rooms")
public class AdminRoomServlet extends HttpServlet {
    
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Room> allRooms = roomDAO.getAllRooms(); 
        request.setAttribute("rooms", allRooms);
        request.getRequestDispatcher("/views/AdminRooms.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            try {
                Room room = new Room();
                room.setRoomID(request.getParameter("roomID"));
                room.setRoomType(request.getParameter("roomType"));
                
                // Validate price to prevent NumberFormatException
                String priceStr = request.getParameter("pricePerNight");
                double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
                room.setPricePerNight(price);
                
                room.setStatus("Available");
                boolean success = roomDAO.addRoom(room);
                
                if (success) {
                    response.sendRedirect("admin-rooms?success=RoomAdded");
                } else {
                    response.sendRedirect("admin-rooms?error=AddFailed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-rooms?error=ExceptionOccurred");
            }
        } else if ("delete".equals(action)) {
            try {
                String roomID = request.getParameter("roomID");
                boolean success = roomDAO.deleteRoom(roomID);
                
                if (success) {
                    response.sendRedirect("admin-rooms?success=RoomDeleted");
                } else {
                    response.sendRedirect("admin-rooms?error=DeleteFailed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-rooms?error=ExceptionOccurred");
            }
        } else {
            response.sendRedirect("admin-rooms");
        }
    }
}