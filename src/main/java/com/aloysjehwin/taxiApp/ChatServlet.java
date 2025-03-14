package com.aloysjehwin.taxiApp;

import java.security.PublicKey;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.Base64;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Retrieves the recipient's public key from the database.
     *
     * @param receiverId The ID of the recipient.
     * @return The recipient's public key.
     * @throws Exception If retrieval or decoding fails.
     */
    private PublicKey getRecipientPublicKey(int receiverId) throws Exception {
        String query = "SELECT public_key FROM users WHERE id = ?";
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chatapp", "root", "Ausnet@1975");
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, receiverId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String publicKeyBase64 = rs.getString("public_key");
                    if (publicKeyBase64 == null || publicKeyBase64.isEmpty()) {
                        throw new IllegalArgumentException("Public key is missing for user ID: " + receiverId);
                    }

                    // Use RSAUtility to convert the Base64 string to PublicKey
                    return RSAUtility.stringToPublicKey(publicKeyBase64);
                } else {
                    throw new SQLException("No public key found for user ID: " + receiverId);
                }
            }
        }
    }

    /**
     * Handles POST requests to send an encrypted message.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);  // Don't create a new session if it doesn't exist
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer senderId = (Integer) session.getAttribute("userId");
        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
        String message = request.getParameter("message");

        try {
            // Retrieve recipient's public key using RSAUtility
            PublicKey recipientPublicKey = getRecipientPublicKey(receiverId);

            // Encrypt the message using RSAUtility
            String encryptedMessage = RSAUtility.encrypt(message, recipientPublicKey);

            // Save the encrypted message to the database
            saveEncryptedMessage(senderId, receiverId, encryptedMessage);

            // Redirect to the chat page
            response.sendRedirect("chat.jsp?receiverId=" + receiverId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while sending the message: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Saves the encrypted message to the database.
     *
     * @param senderId         The sender's ID.
     * @param receiverId       The recipient's ID.
     * @param encryptedMessage The encrypted message.
     * @throws SQLException If database operation fails.
     */
    private void saveEncryptedMessage(int senderId, int receiverId, String encryptedMessage) throws SQLException {
        String query = "INSERT INTO messages (sender_id, receiver_id, message) VALUES (?, ?, ?)";
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/chatapp", "root", "Ausnet@1975");
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.setString(3, encryptedMessage);
            stmt.executeUpdate();
        }
    }
}
