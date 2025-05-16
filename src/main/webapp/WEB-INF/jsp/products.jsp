<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Our Candles | CandleStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Conserver tous les styles existants... */
        .product-header {
            background-color: #fff0e6;
            padding: 60px 0;
            margin-bottom: 40px;
        }

        .product-card {
            transition: transform 0.3s, box-shadow 0.3s;
            margin-bottom: 30px;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #f0e0d6;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .product-img {
            height: 250px;
            object-fit: cover;
        }

        .product-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #7b3f00;
        }

        .product-price {
            font-size: 1.3rem;
            font-weight: bold;
            color: #d46a6a;
            margin: 10px 0;
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

        /* Add to cart animations */
        .btn-loading {
            opacity: 0.7;
            pointer-events: none;
        }

        .alert-popup {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
        }
    </style>
</head>
<body>
<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Alert container for notifications -->
<div id="alert-container" style="position: fixed; top: 80px; right: 20px; z-index: 9999;"></div>

<!-- Product Header -->
<section class="product-header">
    <div class="container text-center">
        <h1 class="display-4">Our Candle Collection</h1>
        <p class="lead">Handcrafted with care, our candles bring warmth and ambiance to any space</p>
    </div>
</section>

<!-- Main Products Section -->
<section class="container mb-5">
    <div class="row">
        <!-- Products Grid -->
        <div class="col-lg-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <c:choose>
                        <c:when test="${not empty products}">
                            Showing <strong>${products.size()}</strong> products
                        </c:when>
                        <c:otherwise>
                            Showing <strong>sample</strong> products
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="row">
                <c:choose>
                    <c:when test="${not empty products}">
                        <!-- Render actual products from database -->
                        <c:forEach var="product" items="${products}">
                            <div class="col-md-4 col-sm-6">
                                <div class="card product-card h-100">
                                    <c:if test="${product.stock < 5 && product.stock > 0}">
                                        <div class="position-absolute top-0 start-0 m-2">
                                            <span class="badge bg-warning">Low Stock</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${product.stock == 0}">
                                        <div class="position-absolute top-0 start-0 m-2">
                                            <span class="badge bg-danger">Sold Out</span>
                                        </div>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img src="${product.image}" class="card-img-top product-img" alt="${product.name}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://images.unsplash.com/photo-1603006905393-eecb2d01d909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                                 class="card-img-top product-img" alt="${product.name}">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="card-body text-center">
                                        <h5 class="product-title">${product.name}</h5>
                                        <p class="product-description">${product.description}</p>
                                        <div class="product-price">€<fmt:formatNumber value="${product.price}" pattern="#0.00"/></div>
                                        <button class="btn btn-candle w-100"
                                                onclick="addToCart(${product.id})"
                                            ${product.stock == 0 ? 'disabled' : ''}
                                                id="btn-${product.id}">
                                            <i class="fas fa-shopping-cart me-2"></i>
                                            <c:choose>
                                                <c:when test="${product.stock == 0}">Out of Stock</c:when>
                                                <c:otherwise>Add to Cart</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Message si aucun produit -->
                        <div class="col-12 text-center">
                            <h4>No products available</h4>
                            <p>Please check back later.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- JavaScript for Add to Cart functionality -->
<script>
    // CSRF token pour les requêtes AJAX
    const csrfToken = '${_csrf.token}';
    const csrfHeader = '${_csrf.headerName}';

    function addToCart(productId) {
        const button = document.getElementById(`btn-${productId}`);
        const originalText = button.innerHTML;

        // Désactiver le bouton et afficher le loading
        button.classList.add('btn-loading');
        button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Adding...';
        button.disabled = true;

        fetch('${pageContext.request.contextPath}/cart/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                [csrfHeader]: csrfToken
            },
            body: `productId=${productId}&quantity=1`
        })
            .then(response => response.text())
            .then(data => {
                // Restaurer le bouton
                button.classList.remove('btn-loading');
                button.innerHTML = originalText;
                button.disabled = false;

                if (data.startsWith('success:')) {
                    showAlert('Product added to cart successfully!', 'success');
                    // Optionnel: mettre à jour le compteur du panier dans la navbar
                    updateCartCount();
                } else if (data.startsWith('error:')) {
                    const errorMessage = data.substring(6);
                    if (errorMessage.includes('connecté')) {
                        // Rediriger vers la page de connexion
                        if (confirm('You need to be logged in to add products to cart. Go to login page?')) {
                            window.location.href = '${pageContext.request.contextPath}/login';
                        }
                    } else {
                        showAlert(errorMessage, 'danger');
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                button.classList.remove('btn-loading');
                button.innerHTML = originalText;
                button.disabled = false;
                showAlert('Error adding product to cart', 'danger');
            });
    }

    function showAlert(message, type) {
        const alertContainer = document.getElementById('alert-container');
        const alertId = 'alert-' + Date.now();

        const alertHtml = `
            <div id="${alertId}" class="alert alert-${type} alert-dismissible fade show shadow" role="alert">
                <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        `;

        alertContainer.insertAdjacentHTML('beforeend', alertHtml);

        // Auto-dismiss after 5 seconds
        setTimeout(() => {
            const alert = document.getElementById(alertId);
            if (alert) {
                alert.remove();
            }
        }, 5000);
    }

    function updateCartCount() {
        // Cette fonction peut être utilisée pour mettre à jour le compteur du panier
        // dans la navbar si vous en avez un
        // Pour l'instant, elle ne fait rien mais peut être étendue plus tard
    }
</script>

<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>