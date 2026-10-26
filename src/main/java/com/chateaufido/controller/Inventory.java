/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.controller;

/**
 *
 * @author Administrator
 */


import com.chateaufido.DAO.InventoryDAO;
import com.chateaufido.model.InventoryItem;
import com.chateaufido.model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Inventory", urlPatterns = {"/admin-inventory"})
public class Inventory extends HttpServlet {

    private InventoryDAO inventoryDAO;

    @Override
    public void init() {
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // --- NEW: SEARCH & FILTER LOGIC ---
        String search = request.getParameter("search");
        String category = request.getParameter("category");

        List<InventoryItem> items;
        
        // If there is a search term OR a category filter (that isn't "All")
        if ((search != null && !search.trim().isEmpty()) || (category != null && !"All".equals(category))) {
            items = inventoryDAO.searchInventory(search, category);
        } else {
            items = inventoryDAO.getAllItems();
        }
        
        request.setAttribute("items", items);
        request.getRequestDispatcher("/views/admin_inventory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Staff admin = (Staff) session.getAttribute("admin"); 
        String staffID = (admin != null) ? admin.getStaffID() : "Unknown";

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Add New Item
            String name = request.getParameter("itemName");
            String category = request.getParameter("category");
            int stock = Integer.parseInt(request.getParameter("currentStock"));
            int min = Integer.parseInt(request.getParameter("minStock"));

            InventoryItem item = new InventoryItem();
            item.setItemName(name);
            item.setCategory(category);
            item.setCurrentStock(stock);
            item.setMinStock(min);
            item.setStaffID(staffID);

            if (inventoryDAO.addItem(item)) {
                request.setAttribute("message", "Item added successfully!");
            } else {
                request.setAttribute("error", "Failed to add item.");
            }

        } else if ("update_stock".equals(action)) {
            // Stock In / Stock Out
            String itemID = request.getParameter("itemID");
            String type = request.getParameter("type"); 
            int qty = Integer.parseInt(request.getParameter("quantity"));

            if ("out".equals(type)) {
                qty = -qty;
            }

            if (inventoryDAO.updateStock(itemID, qty, staffID)) {
                request.setAttribute("message", "Stock updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update stock. (Check if stock is sufficient)");
            }
        
        } else if ("delete".equals(action)) {
            // Delete Item
            String itemID = request.getParameter("itemID");
            if (inventoryDAO.deleteItem(itemID)) {
                request.setAttribute("message", "Item deleted successfully.");
            } else {
                request.setAttribute("error", "Failed to delete item.");
            }

        } else if ("edit".equals(action)) {
            // Edit Item
            String itemID = request.getParameter("itemID");
            String name = request.getParameter("itemName");
            String category = request.getParameter("category");
            int min = Integer.parseInt(request.getParameter("minStock"));

            InventoryItem item = new InventoryItem();
            item.setItemID(itemID);
            item.setItemName(name);
            item.setCategory(category);
            item.setMinStock(min);
            item.setStaffID(staffID); 

            if (inventoryDAO.updateItemDetails(item)) {
                request.setAttribute("message", "Item updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update item.");
            }
        }

        // Reload the list (keeping filters would be nice, but simple reload for now)
        doGet(request, response);
    }
}