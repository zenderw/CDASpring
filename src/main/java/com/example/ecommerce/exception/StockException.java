package com.example.ecommerce.exception;

import com.example.ecommerce.model.Product;

public class StockException extends RuntimeException {
    public StockException(Product product, int quantity) {
        super("Product: " + product.getName() + " does not have enough stock: " + quantity);
    }

    public StockException(String message) {
        super(message);
    }
}
