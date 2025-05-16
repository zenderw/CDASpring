<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | CandleStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Additional styles for profile page */
        .profile-header {
            background-color: #fff0e6;
            padding: 60px 0 40px;
            margin-bottom: 40px;
        }

        .profile-section {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
        }

        .avatar-container {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border: 4px solid white;
        }

        .avatar-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-username {
            font-size: 1.5rem;
            font-weight: 600;
            color: #7b3f00;
            margin-top: 15px;
        }

        .profile-since {
            color: #999;
            font-size: 0.9rem;
        }

        .profile-nav .nav-link {
            color: #7b3f00;
            padding: 12px 20px;
            border-radius: 5px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }

        .profile-nav .nav-link:hover,
        .profile-nav .nav-link.active {
            background-color: #ffe9dc;
            color: #d46a6a;
        }

        .profile-nav .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .section-title {
            color: #7b3f00;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ffe9dc;
        }

        .order-card {
            border: 1px solid #f0e0d6;
            border-radius: 10px;
            margin-bottom: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .order-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.07);
        }

        .order-header {
            background-color: #fff8f4;
            padding: 15px;
            border-radius: 10px 10px 0 0;
            border-bottom: 1px solid #f0e0d6;
        }

        .order-id {
            font-weight: 600;
            color: #7b3f00;
        }

        .order-date {
            color: #999;
        }

        .order-status {
            font-weight: 600;
        }

        .status-pending {
            color: #ffc107;
        }

        .status-shipped {
            color: #17a2b8;
        }

        .status-delivered {
            color: #28a745;
        }

        .status-cancelled {
            color: #dc3545;
        }

        .order-body {
            padding: 15px;
        }

        .order-product {
            display: flex;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f0e0d6;
        }

        .order-product:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .order-product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
        }

        .order-product-details {
            flex-grow: 1;
        }

        .order-product-name {
            font-weight: 600;
            color: #7b3f00;
            margin-bottom: 5px;
        }

        .order-product-price {
            color: #d46a6a;
            font-weight: 600;
        }

        .order-footer {
            background-color: #fff8f4;
            padding: 15px;
            border-top: 1px solid #f0e0d6;
            border-radius: 0 0 10px 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-total {
            font-weight: 600;
            color: #7b3f00;
            font-size: 1.1rem;
        }

        .btn-candle {
            background-color: #d46a6a;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
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

        .form-control:focus {
            border-color: #d46a6a;
            box-shadow: 0 0 0 0.25rem rgba(212, 106, 106, 0.25);
        }

        .address-card {
            border: 1px solid #f0e0d6;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            position: relative;
        }

        .address-card.default {
            border: 2px solid #d46a6a;
        }

        .address-default-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #d46a6a;
            color: white;
            font-size: 0.8rem;
            padding: 3px 8px;
            border-radius: 10px;
        }

        .address-actions {
            margin-top: 10px;
        }

        .tab-pane {
            display: none;
        }

        .tab-pane.active {
            display: block;
        }

        .text-candle {
            color: #d46a6a;
        }

        .product-img {
            height: 200px;
            object-fit: cover;
        }

        .product-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .product-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #7b3f00;
        }

        .product-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #d46a6a;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Profile Header -->
<section class="profile-header">
    <div class="container text-center">
        <div class="avatar-container">
            <img src="https://ui-avatars.com/api/?name=John+Doe&background=d46a6a&color=fff&size=200" alt="Profile Avatar">
        </div>
        <h2 class="profile-username mt-3">Welcome, <sec:authentication property="name" /></h2>
        <p class="profile-since">Member since May 2024</p>
    </div>
</section>

<!-- Main Content -->
<section class="container mb-5">
    <div class="row">
        <!-- Profile Navigation -->
        <div class="col-lg-3 mb-4">
            <div class="profile-section">
                <ul class="nav flex-column profile-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="#dashboard" data-bs-toggle="tab" onclick="toggleTab('dashboard')">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#orders" data-bs-toggle="tab" onclick="toggleTab('orders')">
                            <i class="fas fa-shopping-bag"></i> My Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#addresses" data-bs-toggle="tab" onclick="toggleTab('addresses')">
                            <i class="fas fa-map-marker-alt"></i> My Addresses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#wishlist" data-bs-toggle="tab" onclick="toggleTab('wishlist')">
                            <i class="fas fa-heart"></i> Wishlist
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#account" data-bs-toggle="tab" onclick="toggleTab('account')">
                            <i class="fas fa-user-cog"></i> Account Settings
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Profile Content -->
        <div class="col-lg-9">
            <div class="tab-content">
                <!-- Dashboard -->
                <div class="tab-pane active" id="dashboard">
                    <div class="profile-section">
                        <h3 class="section-title">Dashboard</h3>
                        <div class="row">
                            <div class="col-md-4 text-center mb-4">
                                <div class="p-3 bg-light rounded">
                                    <div class="display-5 mb-2 text-candle">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <h4>3</h4>
                                    <p class="text-muted">Total Orders</p>
                                </div>
                            </div>
                            <div class="col-md-4 text-center mb-4">
                                <div class="p-3 bg-light rounded">
                                    <div class="display-5 mb-2 text-candle">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <h4>5</h4>
                                    <p class="text-muted">Wishlist Items</p>
                                </div>
                            </div>
                            <div class="col-md-4 text-center mb-4">
                                <div class="p-3 bg-light rounded">
                                    <div class="display-5 mb-2 text-candle">
                                        <i class="fas fa-box"></i>
                                    </div>
                                    <h4>1</h4>
                                    <p class="text-muted">Pending Delivery</p>
                                </div>
                            </div>
                        </div>

                        <h4 class="mt-4">Recent Orders</h4>
                        <div class="order-card">
                            <div class="order-header d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="order-id">#ORD-2024-001</span>
                                    <span class="order-date ms-3">May 12, 2024</span>
                                </div>
                                <div class="order-status status-shipped">Shipped</div>
                            </div>
                            <div class="order-body">
                                <div class="order-product">
                                    <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="order-product-img" alt="Lavender Dreams">
                                    <div class="order-product-details">
                                        <div class="order-product-name">Lavender Dreams</div>
                                        <div class="d-flex justify-content-between">
                                            <div class="text-muted">Qty: 2</div>
                                            <div class="order-product-price">€39.98</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-footer">
                                <div class="order-total">Total: €39.98</div>
                                <a href="#" class="btn btn-sm btn-outline-candle">View Details</a>
                            </div>
                        </div>

                        <a href="#orders" class="btn btn-candle mt-3" onclick="toggleTab('orders')">View All Orders</a>
                    </div>

                    <div class="profile-section mt-4">
                        <h3 class="section-title">Featured Recommendations</h3>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="card h-100">
                                    <img src="https://images.unsplash.com/photo-1635925088776-99f13c1d5198?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="card-img-top" alt="Spring Collection">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Spring Collection</h5>
                                        <p class="card-text">Fresh floral scents for the season.</p>
                                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-candle btn-sm">View Collection</a>
                                    </div>
                                </div>
                            </div><div class="col-md-4 mb-3">
                            <div class="card h-100">
                                <img src="https://images.unsplash.com/photo-1603006905393-eecb2d01d909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top" alt="Relaxation Bundle">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Relaxation Bundle</h5>
                                    <p class="card-text">Create a spa experience at home.</p>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-candle btn-sm">Shop Now</a>
                                </div>
                            </div>
                        </div>
                            <div class="col-md-4 mb-3">
                                <div class="card h-100">
                                    <img src="https://images.unsplash.com/photo-1574263816432-bfcb9eb9344c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="card-img-top" alt="Gift Sets">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">Gift Sets</h5>
                                        <p class="card-text">Perfect presents for any occasion.</p>
                                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-candle btn-sm">Explore</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Orders Tab -->
                <div class="tab-pane" id="orders">
                    <div class="profile-section">
                        <h3 class="section-title">My Orders</h3>

                        <!-- Order 1 -->
                        <div class="order-card">
                            <div class="order-header d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="order-id">#ORD-2024-001</span>
                                    <span class="order-date ms-3">May 12, 2024</span>
                                </div>
                                <div class="order-status status-shipped">Shipped</div>
                            </div>
                            <div class="order-body">
                                <div class="order-product">
                                    <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="order-product-img" alt="Lavender Dreams">
                                    <div class="order-product-details">
                                        <div class="order-product-name">Lavender Dreams</div>
                                        <div class="d-flex justify-content-between">
                                            <div class="text-muted">Qty: 2</div>
                                            <div class="order-product-price">€39.98</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-footer">
                                <div class="order-total">Total: €39.98</div>
                                <a href="#" class="btn btn-sm btn-outline-candle">View Details</a>
                            </div>
                        </div>

                        <!-- Order 2 -->
                        <div class="order-card">
                            <div class="order-header d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="order-id">#ORD-2024-002</span>
                                    <span class="order-date ms-3">April 28, 2024</span>
                                </div>
                                <div class="order-status status-delivered">Delivered</div>
                            </div>
                            <div class="order-body">
                                <div class="order-product">
                                    <img src="https://images.unsplash.com/photo-1608181831718-c9ffdbd5e2ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="order-product-img" alt="Citrus Burst">
                                    <div class="order-product-details">
                                        <div class="order-product-name">Citrus Burst</div>
                                        <div class="d-flex justify-content-between">
                                            <div class="text-muted">Qty: 1</div>
                                            <div class="order-product-price">€21.99</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-product">
                                    <img src="https://images.unsplash.com/photo-1631999690079-da39c89d5be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="order-product-img" alt="Cozy Fireside">
                                    <div class="order-product-details">
                                        <div class="order-product-name">Cozy Fireside</div>
                                        <div class="d-flex justify-content-between">
                                            <div class="text-muted">Qty: 1</div>
                                            <div class="order-product-price">€24.99</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-footer">
                                <div class="order-total">Total: €46.98</div>
                                <a href="#" class="btn btn-sm btn-outline-candle">View Details</a>
                            </div>
                        </div>

                        <!-- Order 3 -->
                        <div class="order-card">
                            <div class="order-header d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="order-id">#ORD-2024-003</span>
                                    <span class="order-date ms-3">March 15, 2024</span>
                                </div>
                                <div class="order-status status-delivered">Delivered</div>
                            </div>
                            <div class="order-body">
                                <div class="order-product">
                                    <img src="https://images.unsplash.com/photo-1635925088776-99f13c1d5198?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="order-product-img" alt="Fresh Linen">
                                    <div class="order-product-details">
                                        <div class="order-product-name">Fresh Linen</div>
                                        <div class="d-flex justify-content-between">
                                            <div class="text-muted">Qty: 3</div>
                                            <div class="order-product-price">€53.97</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-footer">
                                <div class="order-total">Total: €53.97</div>
                                <a href="#" class="btn btn-sm btn-outline-candle">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Addresses Tab -->
                <div class="tab-pane" id="addresses">
                    <div class="profile-section">
                        <h3 class="section-title d-flex justify-content-between align-items-center">
                            My Addresses
                            <button class="btn btn-sm btn-candle" data-bs-toggle="modal" data-bs-target="#addressModal">
                                <i class="fas fa-plus"></i> Add New Address
                            </button>
                        </h3>

                        <div class="row">
                            <!-- Default Address -->
                            <div class="col-md-6 mb-4">
                                <div class="address-card default">
                                    <span class="address-default-badge">Default</span>
                                    <h5>Home</h5>
                                    <p>John Doe<br>
                                        123 Candle Street<br>
                                        Apt 4B<br>
                                        Paris, 75001<br>
                                        France<br>
                                        Phone: +33 1 23 45 67 89</p>

                                    <div class="address-actions">
                                        <button class="btn btn-sm btn-outline-candle me-2">Edit</button>
                                        <button class="btn btn-sm btn-outline-danger" disabled>Delete</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Second Address -->
                            <div class="col-md-6 mb-4">
                                <div class="address-card">
                                    <h5>Work</h5>
                                    <p>John Doe<br>
                                        456 Business Avenue<br>
                                        Office Building, Floor 5<br>
                                        Paris, 75002<br>
                                        France<br>
                                        Phone: +33 1 98 76 54 32</p>

                                    <div class="address-actions">
                                        <button class="btn btn-sm btn-outline-secondary me-2">Make Default</button>
                                        <button class="btn btn-sm btn-outline-candle me-2">Edit</button>
                                        <button class="btn btn-sm btn-outline-danger">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Wishlist Tab -->
                <div class="tab-pane" id="wishlist">
                    <div class="profile-section">
                        <h3 class="section-title">My Wishlist</h3>

                        <div class="row">
                            <!-- Wishlist Item 1 -->
                            <div class="col-md-4 mb-4">
                                <div class="card product-card h-100">
                                    <div class="position-absolute top-0 end-0 p-2">
                                        <button class="btn btn-sm btn-outline-danger rounded-circle">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="card-img-top product-img" alt="Lavender Dreams">
                                    <div class="card-body text-center">
                                        <h5 class="product-title">Lavender Dreams</h5>
                                        <div class="product-price mb-3">€19.99</div>
                                        <button class="btn btn-candle w-100">
                                            <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Wishlist Item 2 -->
                            <div class="col-md-4 mb-4">
                                <div class="card product-card h-100">
                                    <div class="position-absolute top-0 end-0 p-2">
                                        <button class="btn btn-sm btn-outline-danger rounded-circle">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <img src="https://images.unsplash.com/photo-1574263816432-bfcb9eb9344c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="card-img-top product-img" alt="Ocean Breeze">
                                    <div class="card-body text-center">
                                        <h5 class="product-title">Ocean Breeze</h5>
                                        <div class="product-price mb-3">€23.99</div>
                                        <button class="btn btn-candle w-100">
                                            <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Wishlist Item 3 -->
                            <div class="col-md-4 mb-4">
                                <div class="card product-card h-100">
                                    <div class="position-absolute top-0 end-0 p-2">
                                        <button class="btn btn-sm btn-outline-danger rounded-circle">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <img src="https://images.unsplash.com/photo-1602910344008-22f323cc1817?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                         class="card-img-top product-img" alt="Autumn Spice">
                                    <div class="card-body text-center">
                                        <h5 class="product-title">Autumn Spice</h5>
                                        <div class="product-price mb-3">€22.99</div>
                                        <button class="btn btn-candle w-100">
                                            <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Account Settings Tab -->
                <div class="tab-pane" id="account">
                    <div class="profile-section">
                        <h3 class="section-title">Account Settings</h3>

                        <form>
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" value="John Doe">
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" value="john.doe@example.com">
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" value="+33 1 23 45 67 89">
                            </div>

                            <button type="submit" class="btn btn-candle">Update Profile</button>
                        </form>

                        <hr class="my-4">

                        <h4>Change Password</h4>
                        <form>
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword">
                            </div>

                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword">
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword">
                            </div>

                            <button type="submit" class="btn btn-candle">Change Password</button>
                        </form>

                        <hr class="my-4">

                        <h4>Notification Preferences</h4>
                        <form>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="emailNotifications" checked>
                                <label class="form-check-label" for="emailNotifications">Email Notifications</label>
                                <div class="form-text">Receive updates about your orders, promotions, and new products.</div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="smsNotifications">
                                <label class="form-check-label" for="smsNotifications">SMS Notifications</label>
                                <div class="form-text">Receive SMS updates about your orders and delivery status.</div>
                            </div>

                            <button type="submit" class="btn btn-candle">Save Preferences</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- New Address Modal -->
<div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addressModalLabel">Add New Address</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="addressLabel" class="form-label">Address Label</label>
                        <input type="text" class="form-control" id="addressLabel" placeholder="Home, Work, etc.">
                    </div>
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName">
                    </div>
                    <div class="mb-3">
                        <label for="address1" class="form-label">Address Line 1</label>
                        <input type="text" class="form-control" id="address1">
                    </div>
                    <div class="mb-3">
                        <label for="address2" class="form-label">Address Line 2 (Optional)</label>
                        <input type="text" class="form-control" id="address2">
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <label for="city" class="form-label">City</label>
                            <input type="text" class="form-control" id="city">
                        </div>
                        <div class="col">
                            <label for="postalCode" class="form-label">Postal Code</label>
                            <input type="text" class="form-control" id="postalCode">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="country" class="form-label">Country</label>
                        <select class="form-select" id="country">
                            <option selected>France</option>
                            <option>Germany</option>
                            <option>Italy</option>
                            <option>Spain</option>
                            <option>United Kingdom</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="phone">
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="defaultAddress">
                        <label class="form-check-label" for="defaultAddress">
                            Set as default address
                        </label>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-candle">Save Address</button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Tab Navigation -->
<script>
    function toggleTab(tabId) {
        // Hide all tabs
        document.querySelectorAll('.tab-pane').forEach(tab => {
            tab.classList.remove('active');
        });

        // Show selected tab
        document.getElementById(tabId).classList.add('active');

        // Update active nav link
        document.querySelectorAll('.profile-nav .nav-link').forEach(link => {
            link.classList.remove('active');
        });

        // Find and activate the link that points to the selected tab
        document.querySelector(`.profile-nav .nav-link[href="#${tabId}"]`).classList.add('active');
    }

    // Initialize tab functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Nothing needed here as the initial active tab is set in the HTML
    });
</script>

<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>