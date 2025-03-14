<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String status = (String) request.getAttribute("status");
    String name = (String) session.getAttribute("name");
    Integer userId = (Integer) session.getAttribute("userId"); // Get the logged-in user's ID as an Integer

    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <!-- Main CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f5f5; /* Light gray background */
            color: #333; /* Dark text color */
        }
        .content-container {
            max-width: 900px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 16px; /* Round the corners */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1); /* Soft shadow */
        }
        header {
            background: #007BFF; /* Blue background */
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            border-radius: 12px;
            margin-bottom: 20px;
        }
        h1 {
            margin: 0;
        }
        h2 {
            color: #007BFF; /* Blue color for subheading */
            margin-top: 20px;
            font-size: 22px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin: 15px 0;
            padding: 10px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        li:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
        li a {
            text-decoration: none;
            color: #007BFF; /* Link color */
            font-weight: bold;
            font-size: 18px;
        }
        li a:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .error {
            color: #D32F2F; /* Red color for error */
            font-weight: bold;
            background: #FFEBEE;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="content-container">
        <header>
            Welcome to ChatApp, <%= name %>!
        </header>
        <h2>Available Users</h2>
        <ul>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ChatApp", "root", "Ausnet@1975");

                    // Exclude the logged-in user's ID and display names
                    String query = "SELECT id, name FROM users WHERE id != ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setInt(1, userId); // Use the Integer userId
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String userFullName = rs.getString("name"); // Fetch name column
            %>
                        <li>
                            <a href="chat.jsp?receiverId=<%= id %>"><%= userFullName %></a>
                        </li>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </ul>
        <% if (status != null && status.equals("failed")) { %>
            <p class="error">Invalid username or password. Please try again.</p>
        <% } %>
    </div>
</body>
</html>
