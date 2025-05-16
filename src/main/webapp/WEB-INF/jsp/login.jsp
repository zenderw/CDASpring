<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | CandleStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Login page specific styles */
        .login-header {
            background-color: #fff0e6;
            padding: 40px 0;
            margin-bottom: 40px;
        }

        .login-container {
            max-width: 500px;
            margin: 0 auto;
        }

        .login-card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: none;
            overflow: hidden;
        }

        .login-card .card-header {
            background-color: #fff8f4;
            border-bottom: 2px solid #f0e0d6;
            padding: 20px;
        }

        .login-card .card-title {
            color: #7b3f00;
            font-weight: 600;
            margin-bottom: 0;
        }

        .login-card .card-body {
            padding: 40px;
        }

        .form-label {
            color: #7b3f00;
            font-weight: 500;
        }

        .form-control {
            padding: 12px;
            border-color: #f0e0d6;
            border-radius: 8px;
        }

        .form-control:focus {
            border-color: #d46a6a;
            box-shadow: 0 0 0 0.25rem rgba(212, 106, 106, 0.25);
        }

        .btn-candle {
            background-color: #d46a6a;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .btn-candle:hover {
            background-color: #b04f4f;
            color: white;
        }

        .btn-outline-candle {
            color: #d46a6a;
            background-color: transparent;
            border: 1px solid #d46a6a;
        }

        .btn-outline-candle:hover {
            background-color: #d46a6a;
            color: white;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
            color: #999;
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #f0e0d6;
        }

        .divider::before {
            margin-right: 15px;
        }

        .divider::after {
            margin-left: 15px;
        }

        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
        }

        .social-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #f8f9fa;
            border: 1px solid #f0e0d6;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
        }

        .social-btn:hover {
            background-color: #f0e0d6;
            color: #d46a6a;
        }

        .social-btn i {
            font-size: 1.2rem;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }

        .register-link a {
            color: #d46a6a;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .alert-login {
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            border-left: 4px solid #dc3545;
        }

        .form-check-input:checked {
            background-color: #d46a6a;
            border-color: #d46a6a;
        }

        .breadcrumb-item + .breadcrumb-item::before {
            color: #d46a6a;
        }

        .breadcrumb-item a {
            color: #7b3f00;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #d46a6a;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Login Header -->
<section class="login-header">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item active">Login</li>
            </ol>
        </nav>
        <h1 class="mt-4 text-candle">Sign In to Your Account</h1>
    </div>
</section>

<!-- Login Form -->
<section class="container mb-5">
    <div class="login-container">
        <div class="card login-card">
            <div class="card-header">
                <h4 class="card-title">Welcome Back</h4>
            </div>
            <div class="card-body">
                <!-- Error Message (shown if login fails) -->
                <c:if test="${param.error != null}">
                    <div class="alert alert-login bg-light">
                        <i class="fas fa-exclamation-circle text-danger me-2"></i>
                        Invalid username or password. Please try again.
                    </div>
                </c:if>

                <!-- Logout Message (shown after logout) -->
                <c:if test="${param.logout != null}">
                    <div class="alert alert-info">
                        <i class="fas fa-check-circle me-2"></i>
                        You have been logged out successfully.
                    </div>
                </c:if>

                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-user text-muted"></i>
                            </span>
                            <input type="text" class="form-control border-start-0" id="username" name="username" required autofocus>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-lock text-muted"></i>
                            </span>
                            <input type="password" class="form-control border-start-0" id="password" name="password" required>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="remember-me" name="remember-me">
                            <label class="form-check-label" for="remember-me">
                                Remember me
                            </label>
                        </div>
                        <a href="#" class="text-decoration-none" style="color: #d46a6a; font-weight: 500;">Forgot password?</a>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-candle btn-lg" >Sign In</button>
                    </div>

                    <div class="divider">Or sign in with</div>

                    <div class="social-login">
                        <a href="#" class="social-btn">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-btn">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-btn">
                            <i class="fab fa-apple"></i>
                        </a>
                    </div>

                    <div class="register-link">
                        Don't have an account? <a href="${pageContext.request.contextPath}/register">Sign Up</a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Security Notice -->
        <div class="mt-4 text-center">
            <div class="d-flex justify-content-center mb-2">
                <i class="fas fa-shield-alt text-success me-2"></i>
                <span>Secure login with 256-bit encryption</span>
            </div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>