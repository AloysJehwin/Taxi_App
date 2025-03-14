<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/dashboard-style.css">

    <style>
        /* Body Styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5; /* Lighter background color */
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333; /* Dark text color */
        }

        /* Login Container */
        .login-container {
            background: #ffffff; /* White background for the card */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
            overflow: hidden;
            width: 400px;
            padding: 30px;
        }

        /* Header */
        .login-header {
            background-color: #007BFF; /* Blue color for header */
            color: #fff; /* White text color */
            text-align: center;
            padding: 20px;
            font-size: 24px;
            font-weight: bold;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        /* Form Styling */
        .login-form {
            padding: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555; /* Slightly darker text */
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd; /* Light border color */
            border-radius: 5px;
            background-color: #f9f9f9; /* Light input background */
            color: #333; /* Input text color */
        }

        .form-group input:focus {
            border-color: #007BFF; /* Blue border when focused */
            outline: none;
        }

        .form-submit {
            background-color: #007BFF; /* Button color */
            color: #fff; /* Button text color */
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        .form-submit:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        /* Remember Me Checkbox */
        .form-remember {
            display: flex;
            align-items: center;
            gap: 5px; /* Adds space between checkbox and label */
            margin-bottom: 20px;
        }

        /* Sign Up Link */
        .signup-link {
            text-align: center;
            margin-top: 15px;
            display: block;
            font-size: 14px;
            color: #007BFF; /* Link color */
            text-decoration: none;
        }

        .signup-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

    <div class="login-container">
        <div class="login-header">
            Welcome Back!
        </div>
        <div class="login-form">
            <form method="post" action="login" id="login-form">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" placeholder="Enter your username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" placeholder="Enter your password" required>
                </div>
                <div class="form-remember">
                    <input type="checkbox" name="remember-me" id="remember-me">
                    <label for="remember-me">Remember me</label>
                </div>
                <button type="submit" class="form-submit">Login</button>
            </form>
            <div class="social-login">
                <span>Or login with</span>
            </div>
            <a href="registration.jsp" class="signup-link">Don't have an account? Sign up</a>
        </div>
    </div>

    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        var status = document.getElementById("status").value;
        if (status === "failed") {
            swal("Login Failed", "Invalid username or password", "error");
        }
    </script>
</body>
</html>
