package com.example.ecommerce.service;

import com.example.ecommerce.exception.ResourceNotFoundException;
import com.example.ecommerce.exception.StockException;
import com.example.ecommerce.model.Order;
import com.example.ecommerce.model.OrderLine;
import com.example.ecommerce.model.OrderLineId;
import com.example.ecommerce.model.Product;
import com.example.ecommerce.repository.OrderLineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderLineService {

    @Autowired
    private OrderLineRepository repository;

    @Autowired
    private ProductService productService;

    public List<OrderLine> getAll() {
        return repository.findAll();
    }

    public OrderLine getById(OrderLineId id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("OrderLine not found for orderId=" + id.getOrderId() + " and productId=" + id.getProductId()));
    }

    public OrderLine save(OrderLine orderLine) {
        return repository.save(orderLine);
    }

    public void delete(OrderLineId id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Cannot delete. OrderLine not found for ID=" + id);
        }
        repository.deleteById(id);
    }

    public OrderLine addOrderLine(Order order, Product product, int quantity) {
        if (product.getStock() < quantity) {
            throw new StockException(product, quantity);
        }

        // décrémenter le stock
        product.setStock(product.getStock() - quantity);
        productService.save(product); // maj stock

        OrderLine line = new OrderLine();
        OrderLineId id = new OrderLineId();
        id.setOrderId(order.getId());
        id.setProductId(product.getId());

        line.setId(id);
        line.setOrder(order);
        line.setProduct(product);
        line.setQuantity(quantity);

        return repository.save(line);
    }
}

