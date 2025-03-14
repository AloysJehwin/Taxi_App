<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Register</title>

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

        /* Register Container */
        .register-container {
            background: #ffffff; /* White background for the card */
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
            overflow: hidden;
            width: 400px;
            padding: 30px;
        }

        /* Header */
        .register-header {
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
        .register-form {
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

        /* Sign In Link */
        .signin-link {
            text-align: center;
            margin-top: 15px;
            display: block;
            font-size: 14px;
            color: #007BFF; /* Link color */
            text-decoration: none;
        }

        .signin-link:hover {
            text-decoration: underline;
        }

        /* Align checkbox to the right of the text */
        .label-agree-term {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .label-agree-term input {
            margin-left: 10px;
            margin-top: 0; /* Remove any top margin */
        }

        .agree-term-text {
            display: inline; /* Ensure the text stays on the same line */
        }

    </style>
</head>
<body>
    <input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

    <div class="register-container">
        <div class="register-header">
            Create an Account
        </div>
        <div class="register-form">
            <form method="post" action="register" id="register-form">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" name="name" id="name" placeholder="Your Name" required>
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="email" name="username" id="username" placeholder="Your Username" required>
                </div>
                <div class="form-group">
                    <label for="pass">Password</label>
                    <input type="password" name="pass" id="pass" placeholder="Password" required>
                </div>
                <div class="form-group">
                    <label for="re-pass">Repeat Password</label>
                    <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password" required>
                </div>
                <div class="form-group">
                    <label for="contact">Contact</label>
                    <input type="text" name="contact" id="contact" placeholder="Contact No" required>
                </div>
                <div class="form-group">
                    <label for="agree-term" class="label-agree-term">
                        <span class="agree-term-text">I agree all statements in <a href="#" class="term-service">Terms of service</a></span>
                        <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" required />
                    </label>
                </div>
                <div class="form-group form-button">
                    <input type="submit" name="signup" id="signup" class="form-submit" value="Register" />
                </div>
            </form>
            <a href="login.jsp" class="signin-link">Already have an account? Sign In</a>
        </div>
    </div>

    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script>
        var status = document.getElementById("status").value;
        if (status === "success") {
            swal("Congrats", "Account Created Successfully", "success");
        }
    </script>
</body>
</html>
