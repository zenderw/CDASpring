package com.example.ecommerce.repository;

import com.example.ecommerce.model.OrderLine;
import com.example.ecommerce.model.OrderLineId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderLineRepository extends JpaRepository<OrderLine, OrderLineId> {
}
