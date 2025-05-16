<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CandleStore - Finest Candles for Every Occasion</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Additional styles for home page */
        .carousel-item {
            height: 65vh;
            min-height: 300px;
            background: no-repeat center center scroll;
            background-size: cover;
        }

        .carousel-caption {
            background-color: rgba(0, 0, 0, 0.5);
            padding: 20px;
            border-radius: 10px;
        }

        .feature-icon {
            font-size: 4rem;
            color: #d46a6a;
            margin-bottom: 1rem;
        }

        .collection-card {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 30px;
            height: 300px;
        }

        .collection-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .collection-card:hover img {
            transform: scale(1.05);
        }

        .collection-text {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            background: linear-gradient(transparent, rgba(123, 63, 0, 0.8));
            color: white;
        }

        .testimonial {
            background-color: #fff0e6;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .testimonial-name {
            color: #d46a6a;
            font-weight: bold;
        }

        .btn-candle {
            background-color: #d46a6a;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn-candle:hover {
            background-color: #b04f4f;
            color: white;
        }

        .section-title {
            color: #b04f4f;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 25%;
            right: 25%;
            height: 3px;
            background-color: #d46a6a;
            border-radius: 3px;
        }

        .subscribe-form {
            background-color: #fff0e6;
            padding: 30px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Hero Carousel -->
<div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active" style="background-image: url('https://images.unsplash.com/photo-1603006905393-eecb2d01d909?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')">
            <div class="carousel-caption">
                <h1>Welcome to CandleStore</h1>
                <p>Discover our handcrafted candles made with love</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-candle">Shop Now</a>
            </div>
        </div>
        <div class="carousel-item" style="background-image: url('https://images.unsplash.com/photo-1635925088776-99f13c1d5198?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')">
            <div class="carousel-caption">
                <h1>NEW: Spring Collection</h1>
                <p>Fresh and floral scents to brighten your home</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-candle">Explore Collection</a>
            </div>
        </div>
        <div class="carousel-item" style="background-image: url('https://images.unsplash.com/photo-1574263816432-bfcb9eb9344c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')">
            <div class="carousel-caption">
                <h1>Gift Sets Available</h1>
                <p>Perfect presents for any occasion</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-candle">View Gift Sets</a>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<!-- Features Section -->
<section class="py-5 bg-white">
    <div class="container">
        <h2 class="section-title text-center">Why Choose Our Candles?</h2>
        <div class="row g-4">
            <div class="col-md-4 text-center">
                <div class="feature-icon">
                    <i class="fas fa-leaf"></i>
                </div>
                <h3>100% Natural</h3>
                <p>Our candles are made with natural soy wax and essential oils for a clean, non-toxic burn.</p>
            </div>
            <div class="col-md-4 text-center">
                <div class="feature-icon">
                    <i class="fas fa-heart"></i>
                </div>
                <h3>Handcrafted</h3>
                <p>Each candle is handcrafted with care, ensuring quality and uniqueness in every product.</p>
            </div>
            <div class="col-md-4 text-center">
                <div class="feature-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <h3>Long-Lasting</h3>
                <p>Our candles burn for up to 50 hours, providing long-lasting ambiance for your home.</p>
            </div>
        </div>
    </div>
</section>

<!-- Featured Products -->
<section class="featured-products py-5">
    <div class="container">
        <h2 class="section-title text-center">Our Best-Selling Candles</h2>
        <div class="row">
            <!-- Product 1 -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="https://images.unsplash.com/photo-1602528495711-f98bc3c8f8f8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" class="card-img-top" alt="Lavender Dreams">
                    <div class="card-body text-center">
                        <h5 class="card-title">Lavender Dreams</h5>
                        <p class="card-text">Calming lavender scent with hints of vanilla to help you relax and unwind.</p>
                        <span class="price fw-bold">19.99 €</span>
                        <div class="mt-3">
                            <a href="#" class="btn btn-candle">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Product 2 -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="https://images.unsplash.com/photo-1608181831718-c9ffdbd5e2ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" class="card-img-top" alt="Citrus Burst">
                    <div class="card-body text-center">
                        <h5 class="card-title">Citrus Burst</h5>
                        <p class="card-text">A refreshing blend of lemon, lime, and grapefruit to energize your space.</p>
                        <span class="price fw-bold">21.99 €</span>
                        <div class="mt-3">
                            <a href="#" class="btn btn-candle">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Product 3 -->
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="https://images.unsplash.com/photo-1631999690079-da39c89d5be6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" class="card-img-top" alt="Cozy Fireside">
                    <div class="card-body text-center">
                        <h5 class="card-title">Cozy Fireside</h5>
                        <p class="card-text">Warm and cozy scent of burning wood with hints of cinnamon and clove.</p>
                        <span class="price fw-bold">24.99 €</span>
                        <div class="mt-3">
                            <a href="#" class="btn btn-candle">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-lg btn-candle">View All Products</a>
        </div>
    </div>
</section>

<!-- Collections -->
<section class="py-5 bg-white">
    <div class="container">
        <h2 class="section-title text-center">Shop by Collection</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="collection-card">
                    <img src="https://images.unsplash.com/photo-1597843786411-a7fa8ad44a95?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" alt="Aromatherapy Collection">
                    <div class="collection-text">
                        <h3>Aromatherapy Collection</h3>
                        <p>Essential oil-infused candles for well-being</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-candle btn-sm">Shop Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="collection-card">
                    <img src="https://images.unsplash.com/photo-1594897030005-5c72afb2d227?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80" alt="Luxury Collection">
                    <div class="collection-text">
                        <h3>Luxury Collection</h3>
                        <p>Premium candles in elegant glass containers</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-candle btn-sm">Shop Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials -->
<section class="py-5" style="background-color: #fff8f4;">
    <div class="container">
        <h2 class="section-title text-center">What Our Customers Say</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="testimonial">
                    <p><i class="fas fa-quote-left me-2"></i>These candles have completely transformed my living room atmosphere. The scents are divine and long-lasting!<i class="fas fa-quote-right ms-2"></i></p>
                    <p class="testimonial-name">- Marie L.</p>
                    <div class="text-warning">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial">
                    <p><i class="fas fa-quote-left me-2"></i>I bought the Lavender Dreams candle for my bedroom and I've been sleeping better ever since. The quality is exceptional!<i class="fas fa-quote-right ms-2"></i></p>
                    <p class="testimonial-name">- Thomas D.</p>
                    <div class="text-warning">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial">
                    <p><i class="fas fa-quote-left me-2"></i>I've tried many candle brands, but CandleStore is by far my favorite. Clean burning, amazing scents, and beautiful packaging!<i class="fas fa-quote-right ms-2"></i></p>
                    <p class="testimonial-name">- Sophie M.</p>
                    <div class="text-warning">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter -->
<section class="py-5 bg-white">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="subscribe-form text-center">
                    <h2 class="section-title">Stay Updated</h2>
                    <p>Subscribe to our newsletter to receive updates, exclusive offers, and candle care tips.</p>
                    <form class="row g-3 justify-content-center mt-3">
                        <div class="col-md-8">
                            <input type="email" class="form-control" placeholder="Your Email Address">
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-candle w-100">Subscribe</button>
                        </div>
                    </form>
                </div>
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