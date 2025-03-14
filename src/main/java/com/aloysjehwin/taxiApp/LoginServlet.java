package com.aloysjehwin.taxiApp;

import java.io.IOException;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chatapp?useSSL=false", "root", "Ausnet@1975");

            // Query to fetch the hashed password and user details for the given username
            String query = "SELECT * FROM users WHERE username = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, username); // Set the username in the query

            rs = pst.executeQuery();

            if (rs.next()) {
                // Retrieve the hashed password and user details from the database
                String storedPassword = rs.getString("password");

                // Debugging logs
                System.out.println("Stored Password: " + storedPassword);
                System.out.println("Input Password: " + password);

                // Create an instance of Argon2
                Argon2 argon2 = Argon2Factory.create();

                // Verify password using Argon2
                if (argon2.verify(storedPassword, password.toCharArray())) {
                    // Password matched, set session attributes
                    session.invalidate();
                    session = request.getSession();
                    session.setAttribute("userId", rs.getInt("id")); // Correctly retrieve id as an integer
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("name", rs.getString("name"));

                    // Retrieve and decrypt private key using RSAUtility
                    String privateKeyBase64 = rs.getString("private_key"); // Retrieve the private key from DB (Base64 encoded)
                    String privateKeyString = null;
                    try {
                        privateKeyString = RSAUtility.decryptPrivateKey(privateKeyBase64);
                    } catch (Exception e) {
                        // Log the exception and set a user-friendly error message
                        e.printStackTrace();
                        request.setAttribute("status", "decryption_error");
                        dispatcher = request.getRequestDispatcher("login.jsp");
                        dispatcher.forward(request, response);
                        return;
                    } // Decrypt the private key

                    if (privateKeyString != null) {
                        session.setAttribute("private_key", privateKeyString); // Store the decrypted private key in the session
                        dispatcher = request.getRequestDispatcher("dashboard.jsp");
                    } else {
                        // Handle the case where the private key could not be decrypted
                        request.setAttribute("status", "decryption_error");
                        dispatcher = request.getRequestDispatcher("login.jsp");
                    }

                } else {
                    // Password mismatch
                    System.out.println("Password mismatch.");
                    request.setAttribute("status", "failed");
                    dispatcher = request.getRequestDispatcher("login.jsp");
                }

                // Clean up resources
                argon2.wipeArray(password.toCharArray());
            } else {
                // User not found
                System.out.println("User not found.");
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
            }

            // Forward the request to the appropriate JSP page
            dispatcher.forward(request, response);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database driver not found.", e);

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred.", e);

        } finally {
            // Close resources to prevent resource leaks
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
