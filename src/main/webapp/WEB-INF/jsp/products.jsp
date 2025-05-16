<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Our Candles</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%@ include file="fragments/navbar.jsp" %>

<section class="container mt-5">
    <h2 class="text-center mb-4 text-candle">Our Best Candles</h2>
    <div class="row">
        <c:forEach var="product" items="${products}">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}">
                    <div class="card-body text-center">
                        <h5 class="card-title">${product.name}</h5>
                        <p class="card-text">${product.description}</p>
                        <p class="price-tag">${product.price} €</p>
                        <a href="#" class="btn btn-candle">Add to Cart</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<%@ include file="fragments/footer.jsp" %>

<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</body>
</html>

