/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.chateaufido.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author a1990
 */
@WebServlet("/mariadb-connect")
public class LessonDBB extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String url = "jdbc:mariadb://localhost:3306/lesson1";
        String username = "users";
        String password = "users";

        response.setContentType("text/html");

        try {
            Class.forName("org.mariadb.jdbc.Driver");

            Connection conn = DriverManager.getConnection(url, username, password);

            Statement stmt = conn.createStatement();

            ResultSet rs = stmt.executeQuery("select * from users");

            while (rs.next()) {
                response.getWriter().print("id : " + rs.getInt("id") + "<br>");
                response.getWriter().print("name : " + rs.getString("name") + "<br>");
                response.getWriter().print("email : " + rs.getString("email") + "<br>");
            }

//            response.getWriter().print("connection to database success from lessonDBB!");
            
            stmt.close();
            conn.close();

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LessonDBB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            response.getWriter().print("connection to database failed " + ex);
            Logger.getLogger(LessonDBB.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
