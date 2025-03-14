<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Welcome to Our Website</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/dashboard-style.css">

    <style>
        /* Global Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7fafc;
            color: #333;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
        }

        /* Main Container */
        .main {
            width: 90%;
            max-width: 1000px;
            text-align: center;
            padding: 20px;
        }

        /* Welcome Section */
        .welcome {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .welcome h1 {
            font-size: 40px;
            font-weight: 700;
            color: #4a90e2;
            margin-bottom: 20px;
        }

        .welcome p {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
        }

        .welcome a {
            display: inline-block;
            padding: 12px 24px;
            background-color: #4a90e2;
            color: #ffffff;
            font-size: 18px;
            border-radius: 5px;
            text-decoration: none;
            margin: 10px;
            transition: 0.3s;
        }

        .welcome a:hover {
            background-color: #357ab7;
        }

        /* Features Section */
        .features {
            display: flex;
            justify-content: space-between;
            gap: 10px;  /* Reduced gap between boxes */
            flex-wrap: nowrap;  /* Ensure the boxes stay in a single row */
            padding: 0 20px;
            margin-top: 30px;
        }

        .feature-item {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 32%;  /* Slightly reduced width */
            text-align: center;
            transition: 0.3s ease;
        }

        .feature-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .feature-item h3 {
            font-size: 24px;
            color: #4a90e2;
            margin-bottom: 15px;
        }

        .feature-item p {
            font-size: 16px;
            color: #666;
        }

        /* Footer */
        .footer {
            font-size: 14px;
            color: #666;
            margin-top: 50px;
        }

        .footer a {
            color: #4a90e2;
            text-decoration: none;
            transition: 0.3s;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .features {
                flex-direction: column;
                align-items: center;
            }

            .feature-item {
                width: 80%;  /* Make the boxes take more width on small screens */
                margin-bottom: 30px;
            }

            .welcome {
                padding: 30px;
            }
        }
    </style>
</head>
<body>

    <div class="main">
        <!-- Welcome Section -->
        <section class="welcome">
            <h1>Welcome to Our Website!</h1>
            <p>We are here to provide you with an amazing experience. Explore our features, register, and start your journey.</p>
            <div>
                <a href="login.jsp">Login</a>
                <a href="registration.jsp">Sign Up</a>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features">
            <div class="feature-item">
                <h3>Easy Registration</h3>
                <p>Sign up in just a few minutes and get started. Our registration process is quick, easy, and secure.</p>
            </div>
            <div class="feature-item">
                <h3>Secure Login</h3>
                <p>Your security is our top priority. Log in securely and access your personalized content anytime.</p>
            </div>
            <div class="feature-item">
                <h3>Responsive Design</h3>
                <p>Whether you are on mobile or desktop, our website adapts to give you the best experience.</p>
            </div>
        </section>

        <!-- Footer -->
        <section class="footer">
            <p>&copy; 2025 Our Website | <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a></p>
        </section>
    </div>

</body>
</html>
