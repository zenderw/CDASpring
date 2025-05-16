<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="collectionsDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Collections
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="collectionsDropdown">
                        <li><a class="dropdown-item" href="#">Aromatherapy</a></li>
                        <li><a class="dropdown-item" href="#">Seasonal</a></li>
                        <li><a class="dropdown-item" href="#">Luxury</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Gift Sets</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <!-- Search Icon -->
                <div class="nav-icon-wrapper me-3">
                    <a href="#" class="nav-icon" data-bs-toggle="modal" data-bs-target="#searchModal">
                        <i class="fas fa-search"></i>
                    </a>
                </div>

                <!-- Cart Icon -->
                <div class="nav-icon-wrapper me-3">
                    <a href="${pageContext.request.contextPath}/cart" class="nav-icon position-relative">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="cart-badge">2</span>
                    </a>
                </div>

                <!-- Authentication -->
                <sec:authorize access="isAuthenticated()">
                    <!-- User Dropdown (for authenticated users) -->
                    <div class="dropdown">
                        <a class="nav-greeting dropdown-toggle" href="#" id="userDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle me-1"></i>
                            <span>Hello, <sec:authentication property="name" /></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                <i class="fas fa-user me-2 text-muted"></i>My Profile
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile#orders">
                                <i class="fas fa-shopping-bag me-2 text-muted"></i>My Orders
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile#wishlist">
                                <i class="fas fa-heart me-2 text-muted"></i>Wishlist
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <!-- Remplacer le lien simple par un formulaire pour la déconnexion -->
                                <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;padding:0;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="dropdown-item text-danger" style="background:none;border:none;width:100%;text-align:left;">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </sec:authorize>

                <sec:authorize access="!isAuthenticated()">
                    <!-- Login Button (for non-authenticated users) -->
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-candle">
                        <i class="fas fa-sign-in-alt me-1"></i> Login
                    </a>
                </sec:authorize>
            </div>
        </div>
    </div>
</nav>

<!-- Search Modal -->
<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="searchModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="btn-close position-absolute top-0 end-0 mt-3 me-3" data-bs-dismiss="modal" aria-label="Close"></button>
                <h5 class="modal-title text-center mb-4" id="searchModalLabel">Search Our Store</h5>
                <form class="search-form">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search for candles, scents, collections...">
                        <button class="btn btn-candle" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
                <div class="mt-4">
                    <h6 class="text-muted">Popular Searches:</h6>
                    <div class="d-flex flex-wrap gap-2 mt-2">
                        <a href="#" class="badge bg-light text-dark text-decoration-none">Lavender</a>
                        <a href="#" class="badge bg-light text-dark text-decoration-none">Gift Sets</a>
                        <a href="#" class="badge bg-light text-dark text-decoration-none">Aromatherapy</a>
                        <a href="#" class="badge bg-light text-dark text-decoration-none">Vanilla</a>
                        <a href="#" class="badge bg-light text-dark text-decoration-none">Spring Collection</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Navbar Styles */
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

    .dropdown-menu {
        border-color: #f0e0d6;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        border-radius: 10px;
        overflow: hidden;
    }

    .dropdown-item {
        color: #7b3f00;
        padding: 10px 20px;
    }

    .dropdown-item:hover, .dropdown-item:focus {
        background-color: #fff0e6;
        color: #d46a6a;
    }

    .dropdown-divider {
        border-color: #f0e0d6;
    }

    /* Icon styles */
    .nav-icon-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .nav-icon {
        width: 38px;
        height: 38px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        color: #7b3f00;
        background-color: rgba(123, 63, 0, 0.05);
        transition: all 0.3s ease;
    }

    .nav-icon:hover {
        background-color: rgba(212, 106, 106, 0.15);
        color: #d46a6a;
    }

    .cart-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background-color: #d46a6a;
        color: white;
        font-size: 0.7rem;
        font-weight: 600;
        height: 18px;
        min-width: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        padding: 0 4px;
    }

    /* Authentication styles */
    .nav-greeting {
        display: flex;
        align-items: center;
        padding: 8px 15px;
        border-radius: 20px;
        background-color: rgba(212, 106, 106, 0.1);
        color: #7b3f00;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .nav-greeting:hover {
        background-color: rgba(212, 106, 106, 0.2);
        color: #d46a6a;
    }

    .btn-candle {
        background-color: #d46a6a;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 20px;
        font-weight: 500;
        transition: background-color 0.3s;
    }

    .btn-candle:hover {
        background-color: #b04f4f;
        color: white;
    }

    /* Responsive adjustments */
    @media (max-width: 992px) {
        .navbar-collapse {
            background-color: #fff8f4;
            padding: 15px;
            border-radius: 10px;
            margin-top: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
    }

    /* Text color for candle brand identity */
    .text-candle {
        color: #d46a6a !important;
    }

    /* Search modal styles */
    .modal-content {
        border: none;
        border-radius: 15px;
    }

    .modal-body {
        padding: 2rem;
    }

    .search-form .form-control {
        padding: 12px 20px;
        border-color: #f0e0d6;
        border-radius: 25px 0 0 25px;
    }

    .search-form .btn {
        border-radius: 0 25px 25px 0;
        padding-left: 20px;
        padding-right: 20px;
    }

    .navbar-toggler {
        border: none;
        color: #7b3f00;
        padding: 8px;
    }

    .navbar-toggler:focus {
        box-shadow: none;
    }
</style>