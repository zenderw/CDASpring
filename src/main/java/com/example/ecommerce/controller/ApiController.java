package com.example.ecommerce.controller;

import com.example.ecommerce.model.Client;
import com.example.ecommerce.model.Order;
import com.example.ecommerce.service.ClientService;
import com.example.ecommerce.service.OrderService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private ClientService clientService;

    @Autowired
    private OrderService orderService;

    // All clients
    @GetMapping("/clients")
    public List<Client> getAllClients() {
        return clientService.getAll();
    }

    // Find a client by username (admin only)
    @Secured("ROLE_ADMIN")
    @GetMapping("/client")
    public Client getClientByUsername(@RequestParam String username) {
        User current = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println("Current user: " + current.getUsername());
        return clientService.findByUsername(username);
    }

    // All orders (admin only)
    @Secured("ROLE_ADMIN")
    @GetMapping("/orders")
    public List<Order> getAllOrders() {
        return orderService.getAll();
    }

    // Get one client by ID (admin only)
    @Secured("ROLE_ADMIN")
    @GetMapping("/clients/{clientId}")
    public Client getClient(@PathVariable long clientId) {
        return clientService.getById(clientId);
    }

    // Orders of a client (public, but use carefully)
    @GetMapping("/clients/{clientId}/orders")
    public List<Order> getClientOrders(@PathVariable long clientId) {
        Client client = clientService.getById(clientId);
        return orderService.getOrdersByClient(client);
    }
}
