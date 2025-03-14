package com.aloysjehwin.taxiApp;

import java.io.IOException;
import java.security.KeyPair;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("pass");
        String mobile = request.getParameter("contact");

        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chatapp?useSSL=false", "root", "Ausnet@1975");

            // Check if the username already exists
            String checkQuery = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            ResultSet checkResult = checkStmt.executeQuery();
            checkResult.next();
            int count = checkResult.getInt(1);

            if (count > 0) {
                request.setAttribute("status", "duplicate"); // Username already exists
                dispatcher = request.getRequestDispatcher("registration.jsp");
            } else {
                // Hash the password using Argon2
                Argon2 argon2 = Argon2Factory.create();
                String hashedPassword = argon2.hash(4, 65536, 1, password.toCharArray());

                // Generate RSA key pair using RSAUtility
                KeyPair keyPair = RSAUtility.generateKeyPair(2048);
                String publicKeyBase64 = RSAUtility.publicKeyToString(keyPair.getPublic());
                String privateKeyBase64 = RSAUtility.privateKeyToString(keyPair.getPrivate());

                // Insert the new user into the database
                String insertQuery = "INSERT INTO users(name, username, password, mobile, public_key, private_key) VALUES(?, ?, ?, ?, ?, ?)";
                PreparedStatement pst = con.prepareStatement(insertQuery);
                pst.setString(1, name);
                pst.setString(2, username);
                pst.setString(3, hashedPassword);
                pst.setString(4, mobile);
                pst.setString(5, publicKeyBase64);
                pst.setString(6, privateKeyBase64);

                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    request.setAttribute("status", "success");
                } else {
                    request.setAttribute("status", "failed");
                }

                dispatcher = request.getRequestDispatcher("registration.jsp");

                // Clean up sensitive data
                argon2.wipeArray(password.toCharArray());
            }

            dispatcher.forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database driver not found.", e);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred.", e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error during registration.", e);
        } finally {
            // Close database resources
            try {
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
