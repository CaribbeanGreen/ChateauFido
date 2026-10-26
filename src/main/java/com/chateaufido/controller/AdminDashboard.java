/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.controller;

/**
 *
 * @author Administrator
 */
import com.chateaufido.DAO.DogDAO;
import com.chateaufido.DAO.InventoryDAO;
import com.chateaufido.DAO.ReservationDAO;
import com.chateaufido.DAO.RoomDAO;
import com.chateaufido.model.Dog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboard", urlPatterns = {"/admin-dashboard", "/admin-bookings"})
public class AdminDashboard extends HttpServlet {

    private DogDAO dogDAO;
    private InventoryDAO inventoryDAO;
    private ReservationDAO reservationDAO;
    private RoomDAO roomDAO;

    @Override
    public void init() {
        dogDAO = new DogDAO();
        inventoryDAO = new InventoryDAO();
        reservationDAO = new ReservationDAO();
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Security Check
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Fetch Dashboard Data
        List<Dog> pendingDogs = dogDAO.getPendingDogs();
        int pendingCount = pendingDogs.size();
        
        // Fetch Stats
        int checkInCount = reservationDAO.getTodayCheckInsCount();
        int activeGuestCount = reservationDAO.getActiveGuestsCount();
        int lowStockCount = inventoryDAO.getLowStockCount();
        
        // --- Fetch Available Rooms Count ---
        // Use the existing getAvailableRooms() method and get its size
        int availableRoomsCount = roomDAO.getAvailableRooms().size();

        // 3. Set Attributes
        request.setAttribute("pendingDogs", pendingDogs);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("checkInCount", checkInCount);
        request.setAttribute("activeGuestCount", activeGuestCount);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("availableRoomsCount", availableRoomsCount);

        // 4. Router
        String path = request.getServletPath();
        if (path.equals("/admin-bookings")) {
            request.getRequestDispatcher("/views/AdminBookings.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/views/AdminDashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String dogID = request.getParameter("dogID");

        if (dogID != null && action != null) {
            boolean success = false;
            if ("approve".equals(action)) {
                success = dogDAO.updateVaccineStatus(dogID, "Approved");
            } else if ("reject".equals(action)) {
                success = dogDAO.updateVaccineStatus(dogID, "Rejected");
            }

            if (success) {
                request.setAttribute("message", "Dog " + dogID + " status updated.");
            }
        }
        doGet(request, response);
    }
}