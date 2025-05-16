<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart | CandleStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Common styles for the cart page */
        .cart-header {
            background-color: #fff0e6;
            padding: 40px 0;
            margin-bottom: 40px;
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

        .section-title {
            color: #7b3f00;
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background-color: #d46a6a;
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

        .btn-outline-candle {
            color: #d46a6a;
            background-color: transparent;
            border: 1px solid #d46a6a;
            transition: all 0.3s;
        }

        .btn-outline-candle:hover {
            background-color: #d46a6a;
            color: white;
        }

        /* Specific cart item styles */
        .cart-table {
            margin-bottom: 30px;
        }

        .cart-table th {
            background-color: #fff8f4;
            color: #7b3f00;
            font-weight: 600;
            padding: 15px;
            border-bottom: 2px solid #f0e0d6;
        }

        .cart-table td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f0e0d6;
        }

        .cart-product {
            display: flex;
            align-items: center;
        }

        .cart-product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
        }

        .cart-product-info {
            flex-grow: 1;
        }

        .cart-product-name {
            font-weight: 600;
            color: #7b3f00;
            margin-bottom: 5px;
            font-size: 1.1rem;
        }

        .cart-product-meta {
            font-size: 0.85rem;
            color: #999;
        }

        .cart-price {
            font-weight: 600;
            color: #7b3f00;
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-btn {
            width: 30px;
            height: 30px;
            border-radius: 4px;
            background-color: #f0e0d6;
            color: #7b3f00;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .quantity-btn:hover {
            background-color: #d46a6a;
            color: white;
        }

        .quantity-input {
            width: 50px;
            height: 30px;
            text-align: center;
            margin: 0 10px;
            border: 1px solid #f0e0d6;
            border-radius: 4px;
        }

        .subtotal {
            font-weight: 600;
            color: #d46a6a;
            font-size: 1.1rem;
        }

        .remove-btn {
            color: #999;
            cursor: pointer;
            transition: color 0.3s;
        }

        .remove-btn:hover {
            color: #dc3545;
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
        }

        .coupon-form {
            display: flex;
            gap: 10px;
        }

        .text-candle {
            color: #d46a6a;
        }

        /* Product card styles for recommendations */
        .product-card {
            border: 1px solid #f0e0d6;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 30px;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .card-img-top {
            height: 200px;
            object-fit: cover;
        }

        .card-title {
            color: #7b3f00;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card-text {
            color: #666;
            margin-bottom: 15px;
            font-size: 0.9rem;
        }

        .card-price {
            color: #d46a6a;
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Cart Header -->
<section class="cart-header">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item active">Shopping Cart</li>
            </ol>
        </nav>
        <h1 class="mt-4 text-candle">Your Shopping Cart</h1>
    </div>
</section>

<!-- Cart Section -->
<section class="container mb-5">
    <div class="row">
        <div class="col-lg-8">
            <!-- If cart is not empty -->
            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div id="cart-items">
                        <table class="table cart-table">
                            <thead>
                            <tr>
                                <th style="width: 50%">Product</th>
                                <th style="width: 15%">Price</th>
                                <th style="width: 15%">Quantity</th>
                                <th style="width: 15%">Subtotal</th>
                                <th style="width: 5%"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr data-product-id="${item.product.id}">
                                    <td>
                                        <div class="cart-product">
                                            <c:choose>
                                                <c:when test="${not empty item.product.image}">
                                                    <img src="${item.product.image}" class="cart-product-img" alt="${item.product.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://images.unsplash.com/photo-1603006905393-eecb2d01d909?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80"
                                                         class="cart-product-img" alt="${item.product.name}">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="cart-product-info">
                                                <div class="cart-product-name">${item.product.name}</div>
                                                <div class="cart-product-meta">${item.product.description}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="cart-price">€<fmt:formatNumber value="${item.product.price}" pattern="#0.00"/></div>
                                    </td>
                                    <td>
                                        <div class="quantity-selector">
                                            <button class="quantity-btn" onclick="decrementQuantity(${item.product.id})">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                            <input type="number" value="${item.quantity}" min="1" max="${item.product.stock}"
                                                   class="quantity-input" id="quantity-${item.product.id}"
                                                   onchange="updateCartItem(${item.product.id})">
                                            <button class="quantity-btn" onclick="incrementQuantity(${item.product.id})">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="subtotal" id="subtotal-${item.product.id}">
                                            €<fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#0.00"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="remove-btn" onclick="removeCartItem(${item.product.id})">
                                            <i class="fas fa-times"></i>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <!-- Cart Actions -->
                        <div class="cart-actions">
                            <div class="coupon-form">
                                <input type="text" class="form-control" placeholder="Coupon code">
                                <button class="btn btn-outline-candle">Apply Coupon</button>
                            </div>
                            <button class="btn btn-outline-candle" onclick="updateAllCartItems()">Update Cart</button>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- If cart is empty -->
                    <div id="empty-cart" class="text-center py-5">
                        <i class="fas fa-shopping-cart fa-4x text-candle mb-3"></i>
                        <h3>Your cart is empty</h3>
                        <p class="text-muted mb-4">Looks like you haven't added any items to your cart yet.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-candle">Browse Products</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="card shadow-sm" style="border-color: #f0e0d6; border-radius: 10px;">
                <div class="card-header bg-white" style="border-bottom: 2px solid #f0e0d6;">
                    <h4 class="mb-0 py-2 text-candle">Order Summary</h4>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-3">
                        <span>Subtotal</span>
                        <span class="fw-bold" id="cart-subtotal">€<fmt:formatNumber value="${subtotal}" pattern="#0.00"/></span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span>Shipping</span>
                        <span class="fw-bold" id="shipping-cost">€4.99</span>
                    </div>

                    <!-- Shipping Options -->
                    <div class="mb-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="shipping" id="standard-shipping" checked onclick="updateShipping('standard')">
                            <label class="form-check-label d-flex justify-content-between w-100" for="standard-shipping">
                                <span>Standard Shipping (3-5 days)</span>
                                <span>€4.99</span>
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="shipping" id="express-shipping" onclick="updateShipping('express')">
                            <label class="form-check-label d-flex justify-content-between w-100" for="express-shipping">
                                <span>Express Shipping (1-2 days)</span>
                                <span>€9.99</span>
                            </label>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between mb-3" id="discount-container" style="display: none !important;">
                        <span>Discount</span>
                        <span class="fw-bold text-success" id="discount-amount">-€0.00</span>
                    </div>

                    <hr style="border-color: #f0e0d6; opacity: 0.5;">

                    <div class="d-flex justify-content-between mb-4">
                        <span class="fw-bold">Total</span>
                        <span class="fw-bold fs-5 text-candle" id="cart-total">
                            €<fmt:formatNumber value="${subtotal + 4.99}" pattern="#0.00"/>
                        </span>
                    </div>

                    <div class="d-grid gap-2">
                        <c:choose>
                            <c:when test="${not empty cartItems}">
                                <button class="btn btn-candle" id="checkout-btn" onclick="proceedToCheckout()">
                                    Proceed to Checkout
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-candle" disabled>
                                    Your cart is empty
                                </button>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-candle">
                            Continue Shopping
                        </a>
                    </div>
                </div>
                <div class="card-footer bg-white text-center py-3" style="border-top: 1px solid #f0e0d6; border-radius: 0 0 10px 10px;">
                    <span>We Accept</span>
                    <div class="mt-2">
                        <i class="fab fa-cc-visa fs-4 mx-1 text-secondary"></i>
                        <i class="fab fa-cc-mastercard fs-4 mx-1 text-secondary"></i>
                        <i class="fab fa-cc-amex fs-4 mx-1 text-secondary"></i>
                        <i class="fab fa-cc-paypal fs-4 mx-1 text-secondary"></i>
                    </div>
                </div>
            </div>

            <!-- Secure Checkout Info -->
            <div class="card mt-4 shadow-sm" style="border-color: #f0e0d6; border-radius: 10px;">
                <div class="card-body">
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-shield-alt text-candle fs-2 me-3"></i>
                        <div>
                            <h5 class="mb-0">Secure Checkout</h5>
                            <p class="mb-0 small text-muted">SSL Encrypted payment processing</p>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-truck text-candle fs-2 me-3"></i>
                        <div>
                            <h5 class="mb-0">Free Shipping</h5>
                            <p class="mb-0 small text-muted">On orders over €50</p>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-box-open text-candle fs-2 me-3"></i>
                        <div>
                            <h5 class="mb-0">Easy Returns</h5>
                            <p class="mb-0 small text-muted">30-day hassle-free returns</p>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-question-circle text-candle fs-2 me-3"></i>
                        <div>
                            <h5 class="mb-0">Need Help?</h5>
                            <p class="mb-0 small text-muted">Call us at <a href="tel:+33123456789" class="text-candle">+33 1 23 45 67 89</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Recommended Products -->
<section class="container mb-5">
    <h2 class="section-title">You May Also Like</h2>
    <div class="row">
        <!-- Product 1 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1631999690079-da39c89d5be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Cozy Fireside">
                <div class="card-body text-center">
                    <h5 class="card-title">Cozy Fireside</h5>
                    <p class="card-text">Warm and cozy scent of burning wood with hints of cinnamon and clove.</p>
                    <div class="card-price">€24.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>

        <!-- Product 2 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1574263816432-bfcb9eb9344c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Ocean Breeze">
                <div class="card-body text-center">
                    <h5 class="card-title">Ocean Breeze</h5>
                    <p class="card-text">Fresh and invigorating scent inspired by the sea and coastal air.</p>
                    <div class="card-price">€23.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>

        <!-- Product 3 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1635925088776-99f13c1d5198?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Fresh Linen">
                <div class="card-body text-center">
                    <h5 class="card-title">Fresh Linen</h5>
                    <p class="card-text">Clean and crisp scent of freshly washed linens dried in the sun.</p>
                    <div class="card-price">€17.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>

        <!-- Product 4 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1602910344008-22f323cc1817?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Autumn Spice">
                <div class="card-body text-center">
                    <h5 class="card-title">Autumn Spice</h5>
                    <p class="card-text">Warm blend of cinnamon, nutmeg, and clove perfect for fall evenings.</p>
                    <div class="card-price">€22.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Recently Viewed Products -->
<section class="container mb-5">
    <h2 class="section-title">Recently Viewed</h2>
    <div class="row">
        <!-- Product 1 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Lavender Dreams">
                <div class="card-body text-center">
                    <h5 class="card-title">Lavender Dreams</h5>
                    <p class="card-text">Calming lavender scent with hints of vanilla to help you relax and unwind.</p>
                    <div class="card-price">€19.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>

        <!-- Product 2 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1603006905393-eecb2d01d909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Vanilla Bean">
                <div class="card-body text-center">
                    <h5 class="card-title">Vanilla Bean</h5>
                    <p class="card-text">Rich vanilla scent that creates a warm and inviting atmosphere.</p>
                    <div class="card-price">€18.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>

        <!-- Product 3 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1608181831718-c9ffdbd5e2ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Citrus Burst">
                <div class="card-body text-center">
                    <h5 class="card-title">Citrus Burst</h5>
                    <p class="card-text">A refreshing blend of lemon, lime, and grapefruit to energize your space.</p>
                    <div class="card-price">€21.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>

        <!-- Product 4 -->
        <div class="col-md-3 col-sm-6">
            <div class="card product-card h-100">
                <img src="https://images.unsplash.com/photo-1627384113972-f4c91eec4670?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                     class="card-img-top" alt="Eucalyptus Mint">
                <div class="card-body text-center">
                    <h5 class="card-title">Eucalyptus Mint</h5>
                    <p class="card-text">Refreshing blend of eucalyptus and mint for clarity and energy.</p>
                    <div class="card-price">€20.99</div>
                    <button class="btn btn-sm btn-candle">Add to Cart</button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Cart Functions JavaScript -->
<script>
    // CSRF token pour les requêtes AJAX
    const csrfToken = '${_csrf.token}';
    const csrfHeader = '${_csrf.headerName}';

    // Cart Item Functions
    function incrementQuantity(productId) {
        const quantityInput = document.getElementById(`quantity-${productId}`);
        const currentValue = parseInt(quantityInput.value);
        const maxValue = parseInt(quantityInput.max);

        if (currentValue < maxValue) {
            quantityInput.value = currentValue + 1;
            updateCartItem(productId);
        } else {
            alert('Cannot add more items. Stock limit reached.');
        }
    }

    function decrementQuantity(productId) {
        const quantityInput = document.getElementById(`quantity-${productId}`);
        const currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
            updateCartItem(productId);
        }
    }

    function updateCartItem(productId) {
        const quantityInput = document.getElementById(`quantity-${productId}`);
        const quantity = parseInt(quantityInput.value);

        fetch('${pageContext.request.contextPath}/cart/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                [csrfHeader]: csrfToken
            },
            body: `productId=${productId}&quantity=${quantity}`
        })
            .then(response => response.text())
            .then(data => {
                if (data.startsWith('success:')) {
                    // Recharge la page pour mettre à jour les totaux
                    location.reload();
                } else {
                    alert(data.substring(6)); // Affiche le message d'erreur
                    // Restaurer la valeur précédente en cas d'erreur
                    location.reload();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Erreur lors de la mise à jour du panier');
                location.reload();
            });
    }

    function removeCartItem(productId) {
        if (confirm('Êtes-vous sûr de vouloir supprimer ce produit du panier ?')) {
            fetch('${pageContext.request.contextPath}/cart/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    [csrfHeader]: csrfToken
                },
                body: `productId=${productId}`
            })
                .then(response => response.text())
                .then(data => {
                    if (data.startsWith('success:')) {
                        // Recharge la page pour mettre à jour le panier
                        location.reload();
                    } else {
                        alert(data.substring(6)); // Affiche le message d'erreur
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Erreur lors de la suppression du produit');
                });
        }
    }

    function updateAllCartItems() {
        // Récupère tous les éléments du panier et les met à jour
        const quantityInputs = document.querySelectorAll('.quantity-input');

        quantityInputs.forEach(input => {
            const productId = input.id.split('-')[1];
            updateCartItem(productId);
        });

        alert('Panier mis à jour !');
    }

    function updateShipping(type) {
        let shippingCost = 4.99;
        if (type === 'express') {
            shippingCost = 9.99;
        }

        document.getElementById('shipping-cost').textContent = `€${shippingCost.toFixed(2)}`;

        // Recalculer le total
        const subtotalElement = document.getElementById('cart-subtotal');
        const subtotal = parseFloat(subtotalElement.textContent.replace('€', ''));
        const total = subtotal + shippingCost;

        document.getElementById('cart-total').textContent = `€${total.toFixed(2)}`;
    }

    function proceedToCheckout() {
        // Rediriger vers la page de checkout
        window.location.href = '${pageContext.request.contextPath}/checkout';
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Rien à faire ici pour le moment
    });
</script>

<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>