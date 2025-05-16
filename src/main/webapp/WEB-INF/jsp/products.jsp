<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        /* Additional styles for product page */
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

        .product-rating {
            color: #ffc107;
            margin-bottom: 15px;
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

        .filters {
            background-color: #fff8f4;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .filter-title {
            color: #7b3f00;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .badge-candle {
            background-color: #ffe9dc;
            color: #7b3f00;
            margin-right: 5px;
            margin-bottom: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .badge-candle:hover, .badge-candle.active {
            background-color: #d46a6a;
            color: white;
        }

        .pagination .page-link {
            color: #7b3f00;
        }

        .pagination .page-item.active .page-link {
            background-color: #d46a6a;
            border-color: #d46a6a;
        }

        .product-status {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 1;
        }

        .product-action {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 1;
            visibility: hidden;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .product-card:hover .product-action {
            visibility: visible;
            opacity: 1;
        }

        .action-icon {
            background-color: white;
            color: #d46a6a;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .action-icon:hover {
            background-color: #d46a6a;
            color: white;
        }

        .product-description {
            color: #666;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 48px;
        }
    </style>
</head>
<body>
<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>
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
        <!-- Filters Sidebar -->
        <div class="col-lg-3 mb-4">
            <div class="filters shadow-sm">
                <h4 class="filter-title">Search</h4>
                <div class="input-group mb-4">
                    <input type="text" class="form-control" placeholder="Search candles...">
                    <button class="btn btn-candle" type="button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <h4 class="filter-title">Categories</h4>
                <div class="mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="category1" checked>
                        <label class="form-check-label" for="category1">
                            All Candles
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="category2">
                        <label class="form-check-label" for="category2">
                            Scented Candles
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="category3">
                        <label class="form-check-label" for="category3">
                            Pillar Candles
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="category4">
                        <label class="form-check-label" for="category4">
                            Votive Candles
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="category5">
                        <label class="form-check-label" for="category5">
                            Jar Candles
                        </label>
                    </div>
                </div>

                <h4 class="filter-title">Price Range</h4>
                <div class="mb-4">
                    <input type="range" class="form-range" min="5" max="50" value="25" id="priceRange">
                    <div class="d-flex justify-content-between">
                        <span>€5</span>
                        <span id="priceValue">€25</span>
                        <span>€50</span>
                    </div>
                </div>

                <h4 class="filter-title">Scents</h4>
                <div class="mb-4">
                    <span class="badge badge-candle p-2 active">All</span>
                    <span class="badge badge-candle p-2">Floral</span>
                    <span class="badge badge-candle p-2">Fruity</span>
                    <span class="badge badge-candle p-2">Spicy</span>
                    <span class="badge badge-candle p-2">Woody</span>
                    <span class="badge badge-candle p-2">Vanilla</span>
                    <span class="badge badge-candle p-2">Fresh</span>
                </div>

                <button class="btn btn-candle w-100">Apply Filters</button>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <c:choose>
                        <c:when test="${not empty products}">
                            Showing <strong>${products.size()}</strong> products
                        </c:when>
                        <c:otherwise>
                            Showing <strong>9</strong> products
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex align-items-center">
                    <label for="sortOrder" class="me-2">Sort by:</label>
                    <select class="form-select" id="sortOrder">
                        <option selected>Featured</option>
                        <option>Price: Low to High</option>
                        <option>Price: High to Low</option>
                        <option>Newest</option>
                        <option>Best Selling</option>
                    </select>
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
                                        <div class="product-status">
                                            <span class="badge bg-warning">Low Stock</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${product.stock == 0}">
                                        <div class="product-status">
                                            <span class="badge bg-danger">Sold Out</span>
                                        </div>
                                    </c:if>
                                    <div class="product-action">
                                        <div class="action-icon">
                                            <i class="fas fa-heart"></i>
                                        </div>
                                        <div class="action-icon">
                                            <i class="fas fa-eye"></i>
                                        </div>
                                    </div>
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
                                        <div class="product-rating">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star-half-alt"></i>
                                            <span class="ms-1 text-muted">(4.5)</span>
                                        </div>
                                        <div class="product-price">${product.price} €</div>
                                        <button class="btn btn-candle w-100" ${product.stock == 0 ? 'disabled' : ''}>
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
                        <!-- Display demo products -->

                        <!-- Product 1 -->
                        <div class="col-md-4 col-sm-6">
                            <div class="card product-card h-100">
                                <div class="product-status">
                                    <span class="badge bg-danger">Sale</span>
                                </div>
                                <div class="product-action">
                                    <div class="action-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="action-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                                <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top product-img" alt="Lavender Dreams">
                                <div class="card-body text-center">
                                    <h5 class="product-title">Lavender Dreams</h5>
                                    <p class="product-description">Calming lavender scent with hints of vanilla to help you relax and unwind.</p>
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span class="ms-1 text-muted">(4.5)</span>
                                    </div>
                                    <div class="product-price">19.99 €</div>
                                    <button class="btn btn-candle w-100">
                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Product 2 -->
                        <div class="col-md-4 col-sm-6">
                            <div class="card product-card h-100">
                                <div class="product-status">
                                    <span class="badge bg-success">New</span>
                                </div>
                                <div class="product-action">
                                    <div class="action-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="action-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                                <img src="https://images.unsplash.com/photo-1608181831718-c9ffdbd5e2ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top product-img" alt="Citrus Burst">
                                <div class="card-body text-center">
                                    <h5 class="product-title">Citrus Burst</h5>
                                    <p class="product-description">A refreshing blend of lemon, lime, and grapefruit to energize your space.</p>
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <span class="ms-1 text-muted">(4.0)</span>
                                    </div>
                                    <div class="product-price">21.99 €</div>
                                    <button class="btn btn-candle w-100">
                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Product 3 -->
                        <div class="col-md-4 col-sm-6">
                            <div class="card product-card h-100">
                                <div class="product-action">
                                    <div class="action-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="action-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                                <img src="https://images.unsplash.com/photo-1631999690079-da39c89d5be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top product-img" alt="Cozy Fireside">
                                <div class="card-body text-center">
                                    <h5 class="product-title">Cozy Fireside</h5>
                                    <p class="product-description">Warm and cozy scent of burning wood with hints of cinnamon and clove.</p>
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <span class="ms-1 text-muted">(5.0)</span>
                                    </div>
                                    <div class="product-price">24.99 €</div>
                                    <button class="btn btn-candle w-100">
                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Product 4 -->
                        <div class="col-md-4 col-sm-6">
                            <div class="card product-card h-100">
                                <div class="product-action">
                                    <div class="action-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="action-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                                <img src="https://images.unsplash.com/photo-1603006905393-eecb2d01d909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top product-img" alt="Vanilla Bean">
                                <div class="card-body text-center">
                                    <h5 class="product-title">Vanilla Bean</h5>
                                    <p class="product-description">Rich and creamy vanilla scent that creates a warm and inviting atmosphere.</p>
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <span class="ms-1 text-muted">(4.5)</span>
                                    </div>
                                    <div class="product-price">18.99 €</div>
                                    <button class="btn btn-candle w-100">
                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Product 5 -->
                        <div class="col-md-4 col-sm-6">
                            <div class="card product-card h-100">
                                <div class="product-status">
                                    <span class="badge bg-danger">Sale</span>
                                </div>
                                <div class="product-action">
                                    <div class="action-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="action-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                                <img src="https://images.unsplash.com/photo-1635925088776-99f13c1d5198?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top product-img" alt="Fresh Linen">
                                <div class="card-body text-center">
                                    <h5 class="product-title">Fresh Linen</h5>
                                    <p class="product-description">Clean and crisp scent of freshly washed linens dried in the sun.</p>
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                        <i class="far fa-star"></i>
                                        <span class="ms-1 text-muted">(3.5)</span>
                                    </div>
                                    <div class="product-price">
                                        <span class="text-decoration-line-through text-muted me-2">22.99 €</span>
                                        17.99 €
                                    </div>
                                    <button class="btn btn-candle w-100">
                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Product 6 -->
                        <div class="col-md-4 col-sm-6">
                            <div class="card product-card h-100">
                                <div class="product-status">
                                    <span class="badge bg-success">New</span>
                                </div>
                                <div class="product-action">
                                    <div class="action-icon">
                                        <i class="fas fa-heart"></i>
                                    </div>
                                    <div class="action-icon">
                                        <i class="fas fa-eye"></i>
                                    </div>
                                </div>
                                <img src="https://images.unsplash.com/photo-1574263816432-bfcb9eb9344c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"
                                     class="card-img-top product-img" alt="Ocean Breeze">
                                <div class="card-body text-center">
                                    <h5 class="product-title">Ocean Breeze</h5>
                                    <p class="product-description">Fresh and invigorating scent inspired by the sea and coastal air.</p>
                                    <div class="product-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <span class="ms-1 text-muted">(4.0)</span>
                                    </div>
                                    <div class="product-price">23.99 €</div>
                                    <button class="btn btn-candle w-100">
                                        <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination -->
            <nav class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1"><i class="fas fa-chevron-left"></i></a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</section>
<!-- Footer Information -->
<section class="py-5 bg-white">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="mb-3">
                    <i class="fas fa-shipping-fast text-candle" style="font-size: 2.5rem;"></i>
                </div>
                <h4>Free Shipping</h4>
                <p class="text-muted">On all orders over €50</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="mb-3">
                    <i class="fas fa-redo-alt text-candle" style="font-size: 2.5rem;"></i>
                </div>
                <h4>Easy Returns</h4>
                <p class="text-muted">30-day return policy</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="mb-3">
                    <i class="fas fa-shield-alt text-candle" style="font-size: 2.5rem;"></i>
                </div>
                <h4>Secure Payments</h4>
                <p class="text-muted">100% secure checkout</p>
            </div>
        </div>
    </div>
</section>
<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>
<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Price Range Script -->
<script>
    // Update price value display when slider changes
    document.getElementById('priceRange').addEventListener('input', function() {
        document.getElementById('priceValue').textContent = '€' + this.value;
    });

    // Handle scent badges
    const badges = document.querySelectorAll('.badge-candle');
    badges.forEach(badge => {
        badge.addEventListener('click', function() {
            // If clicking "All", make it the only active badge
            if (this.textContent.trim() === 'All') {
                badges.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            } else {
                // If clicking another badge, remove active from "All"
                const allBadge = [...badges].find(b => b.textContent.trim() === 'All');
                allBadge.classList.remove('active');

                // Toggle active state on clicked badge
                this.classList.toggle('active');

                // If no badges are active, make "All" active again
                const anyActive = [...badges].some(b => b !== allBadge && b.classList.contains('active'));
                if (!anyActive) {
                    allBadge.classList.add('active');
                }
            }
        });
    });
</script>
</body>
</html>