<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .error-container {
            text-align: center;
            padding: 50px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #e74c3c;
        }
        p {
            color: #555;
            font-size: 18px;
        }
        .error-details {
            font-size: 14px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Error</h1>
        <p><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error occurred." %></p>
        <div class="error-details">
            <p><%= request.getAttribute("javax.servlet.error.exception") != null ? request.getAttribute("javax.servlet.error.exception").toString() : "No additional details available." %></p>
        </div>
    </div>
</body>
</html>
