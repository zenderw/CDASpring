<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Candle Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Hero Section -->
<section class="hero bg-light py-5 text-center">
    <div class="container">
        <h1 class="display-4">Welcome to CandleStore</h1>
        <p class="lead">Find the perfect candle to brighten your space.</p>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">Browse Candles</a>
    </div>
</section>

<!-- Featured Products -->
<section class="featured-products py-5">
    <div class="container">
        <h2 class="text-center mb-4">Our Best-Selling Candles</h2>
        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}">
                        <div class="card-body text-center">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">${product.description}</p>
                            <span class="price fw-bold">${product.price} €</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>

<!-- JS -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
