package com.example.ecommerce.controller;

import com.example.ecommerce.model.OrderLine;
import com.example.ecommerce.model.OrderLineId;
import com.example.ecommerce.service.OrderLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/order-lines")
public class OrderLineController {

    @Autowired
    private OrderLineService service;

    @GetMapping
    public String listOrderLines(Model model) {
        model.addAttribute("orderLines", service.getAll());
        return "orderlines/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("orderLine", new OrderLine());
        return "orderlines/add";
    }

    @PostMapping("/save")
    public String saveOrderLine(@ModelAttribute OrderLine orderLine) {
        service.save(orderLine);
        return "redirect:/order-lines";
    }

    @GetMapping("/delete/{orderId}/{productId}")
    public String deleteOrderLine(@PathVariable Long orderId, @PathVariable Long productId) {
        OrderLineId id = new OrderLineId();
        id.setOrderId(orderId);
        id.setProductId(productId);
        service.delete(id);
        return "redirect:/order-lines";
    }
}
