<%@ page import="java.sql.*" %>
<%@ page import="com.aloysjehwin.taxiApp.RSAUtility" %>
<%@ page session="true" %>
<%
    String status = (String) request.getAttribute("status");
    String name = (String) session.getAttribute("name");
    Integer userId = (Integer) session.getAttribute("userId");

    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int receiverId = 0;
    String receiverName = null;
    String receiverPrivateKey = null;

    // Safely retrieve and parse receiverId parameter
    String receiverIdParam = request.getParameter("receiverId");
    if (receiverIdParam != null && !receiverIdParam.isEmpty()) {
        try {
            receiverId = Integer.parseInt(receiverIdParam);

            // Fetch the receiver's details (name and private key) from the database
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chatapp", "root", "Ausnet@1975")) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String query = "SELECT name, private_key FROM users WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, receiverId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            receiverName = rs.getString("name");
                            receiverPrivateKey = rs.getString("private_key");
                        } else {
                            out.println("<p>Error: User not found.</p>");
                        }
                    }
                }
            }
        } catch (NumberFormatException e) {
            out.println("<p>Error: Invalid receiver ID provided.</p>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving receiver details. Please try again later.</p>");
        }
    } else {
        out.println("<p>Error: No receiver ID provided.</p>");
    }

    // Fetch the sender's private key from session
    String senderPrivateKey = (String) session.getAttribute("private_key");
    if (senderPrivateKey == null) {
        out.println("<p>Error: Private key for sender not available. Please login again.</p>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="content-container">
        <header>
            Chat with <%= receiverName %>
        </header>
        <div class="chat-box">
            <%
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chatapp", "root", "Ausnet@1975")) {
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Query to fetch messages between the user and the receiver
                    String query = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) " +
                                   "OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp";
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setInt(1, userId);
                        stmt.setInt(2, receiverId);
                        stmt.setInt(3, receiverId);
                        stmt.setInt(4, userId);

                        try (ResultSet rs = stmt.executeQuery()) {
                            boolean hasMessages = false;

                            while (rs.next()) {
                                hasMessages = true;
                                String encryptedMessage = rs.getString("message");
                                int sender = rs.getInt("sender_id");

                                String displayedMessage = null;
                                try {
                                    String normalizedKey; // Placeholder for the normalized key
                                    if (sender != userId && receiverPrivateKey != null) {
                                        // Use RSA to decrypt the message using the receiver's private key
                                        normalizedKey = RSAUtility.adjustKey(receiverPrivateKey);
                                        displayedMessage = RSAUtility.decrypt(encryptedMessage, RSAUtility.stringToPrivateKey(receiverPrivateKey));
                                    } else if (sender == userId) {
                                        // Use RSA to decrypt the message sent by the user using their private key
                                        normalizedKey = RSAUtility.adjustKey(senderPrivateKey);
                                        displayedMessage = RSAUtility.decrypt(encryptedMessage, RSAUtility.stringToPrivateKey(senderPrivateKey));
                                    } else {
                                        displayedMessage = "[Private key not available]";
                                    }
                                } catch (Exception e) {
                                    // Log error details to troubleshoot decryption failure
                                    out.println("<p>Error decrypting message: " + e.getMessage() + "</p>");
                                    displayedMessage = "[Decryption failed: " + e.getMessage() + "]";
                                    e.printStackTrace();
                                }
            %>
                                <p class="<%= (sender == userId ? "sender" : "receiver") %>">
                                    <strong><%= (sender == userId ? "You" : receiverName) %>:</strong> <%= displayedMessage %>
                                </p>
            <%
                            }

                            if (!hasMessages) {
            %>
                                <p>No messages found. Start the conversation!</p>
            <%
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error loading messages. Please try again later.</p>");
                }
            %>
        </div>
        <div class="chat-box">
            <form action="ChatServlet" method="post">
                <input type="hidden" name="receiverId" value="<%= receiverId %>">
                <textarea name="message" placeholder="Type your message..." required></textarea><br>
                <button type="submit">Send</button>
            </form>
        </div>
    </div>
</body>
</html>
