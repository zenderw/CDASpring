<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Page Not Found | CandleStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        .error-page {
            min-height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .error-code {
            font-size: 12rem;
            font-weight: 700;
            color: #d46a6a;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            line-height: 1;
            margin-bottom: 20px;
        }

        .error-message {
            font-size: 2rem;
            color: #7b3f00;
            margin-bottom: 30px;
        }

        .error-description {
            font-size: 1.1rem;
            color: #666;
            max-width: 500px;
            margin: 0 auto 40px;
        }

        .candle-icon {
            font-size: 5rem;
            color: #d46a6a;
            margin-bottom: 30px;
            animation: flicker 2s infinite alternate;
        }

        @keyframes flicker {
            0%, 18%, 22%, 25%, 53%, 57%, 100% {
                text-shadow: 0 0 7px #d46a6a, 0 0 10px #d46a6a, 0 0 21px #d46a6a;
            }
            20%, 24%, 55% {
                text-shadow: none;
            }
        }

        .btn-candle {
            background-color: #d46a6a;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 5px;
            font-weight: 600;
            transition: background-color 0.3s;
        }

        .btn-candle:hover {
            background-color: #b04f4f;
            color: white;
        }

        .error-page-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .error-actions {
            margin-top: 20px;
        }

        .suggested-links {
            margin-top: 50px;
            border-top: 1px solid #f0e0d6;
            padding-top: 30px;
        }

        .suggested-links h5 {
            color: #7b3f00;
            margin-bottom: 20px;
        }

        .suggested-link-card {
            border: 1px solid #f0e0d6;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .suggested-link-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .suggested-link-img {
            height: 150px;
            object-fit: cover;
        }

        /* Navbar Styles (Inlined for error page) */
        .navbar {
            background-color: #fff8f4;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: #7b3f00;
        }

        .navbar-brand:hover {
            color: #d46a6a;
        }

        .nav-link {
            color: #7b3f00;
            font-weight: 500;
            margin: 0 5px;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            color: #d46a6a;
            background-color: rgba(212, 106, 106, 0.1);
        }

        /* Footer Styles (Inlined for error page) */
        .footer {
            background-color: #fff8f4;
            color: #7b3f00;
            padding: 30px 0;
            margin-top: 50px;
        }

        .footer-title {
            color: #7b3f00;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .footer-contact li, .footer-links li {
            margin-bottom: 10px;
        }

        .footer-contact a, .footer-links a {
            color: #7b3f00;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-contact a:hover, .footer-links a:hover {
            color: #d46a6a;
        }

        .social-icon {
            font-size: 1.5rem;
            margin-right: 15px;
            color: #7b3f00;
            transition: color 0.3s;
        }

        .social-icon:hover {
            color: #d46a6a;
        }

        .footer-bottom {
            background-color: #f8e8dd;
            padding: 15px 0;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<!-- Custom Inline Navbar (simplified version) -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-fire text-candle me-2"></i>CandleStore
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain"
                aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">Shop</a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <div class="nav-icon-wrapper me-3">
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-shopping-cart me-1"></i>Cart
                    </a>
                </div>

                <sec:authorize access="isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary btn-sm me-2">
                        <i class="fas fa-user me-1"></i>Profile
                    </a>
                </sec:authorize>

                <sec:authorize access="!isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-candle">
                        <i class="fas fa-sign-in-alt me-1"></i> Login
                    </a>
                </sec:authorize>
            </div>
        </div>
    </div>
</nav>

<!-- 404 Error Content -->
<div class="container">
    <div class="error-page">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <i class="fas fa-fire-alt candle-icon"></i>
                <h1 class="error-code">404</h1>
                <h2 class="error-message">Page Not Found</h2>
                <p class="error-description">
                    We're sorry, but the page you're looking for seems to have melted away.
                    It might have been moved, deleted, or never existed.
                </p>
                <div class="error-actions">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-candle me-3">
                        <i class="fas fa-home me-2"></i>Return Home
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                        <i class="fas fa-shopping-bag me-2"></i>Browse Products
                    </a>
                </div>

                <!-- Suggested Links -->
                <div class="suggested-links">
                    <h5>You might be interested in:</h5>
                    <div class="row">
                        <div class="col-md-4 mb-4">
                            <div class="card suggested-link-card h-100">
                                <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top suggested-link-img" alt="Bestsellers">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Bestsellers</h5>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-secondary">Shop Now</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="card suggested-link-card h-100">
                                <img src="https://images.unsplash.com/photo-1635925088776-99f13c1d5198?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top suggested-link-img" alt="New Arrivals">
                                <div class="card-body text-center">
                                    <h5 class="card-title">New Arrivals</h5>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-secondary">Explore</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="card suggested-link-card h-100">
                                <img src="https://images.unsplash.com/photo-1574263816432-bfcb9eb9344c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top suggested-link-img" alt="Gift Sets">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Gift Sets</h5>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-sm btn-outline-secondary">View All</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Custom Inline Footer (simplified version) -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h4 class="footer-title">CandleStore</h4>
                <p>Bringing warmth and ambiance to your space</p>
                <div class="mt-3 mb-4">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-pinterest-p"></i></a>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <p class="mb-0">&copy; 2025 CandleStore. All rights reserved.</p>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>