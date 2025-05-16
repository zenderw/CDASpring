package com.example.ecommerce.controller;

import com.example.ecommerce.model.Client;
import com.example.ecommerce.model.Order;
import com.example.ecommerce.model.OrderLine;
import com.example.ecommerce.model.Product;
import com.example.ecommerce.service.ClientService;
import com.example.ecommerce.service.OrderService;
import com.example.ecommerce.service.OrderLineService;
import com.example.ecommerce.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ClientService clientService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderLineService orderLineService;

    @GetMapping("/")
    public String index() {
        System.out.println("Home");
        return "home";
    }

    @GetMapping("/login")
    public String login() {
        System.out.println("Login");
        return "login";
    }

    @GetMapping("/logout")
    public String logout() {
        return "logout";
    }

    @GetMapping("/cart")
    public String viewCart(Model model) {
        // Récupérer l'utilisateur connecté
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth != null && auth.isAuthenticated() && !auth.getName().equals("anonymousUser")) {
            String username = auth.getName();
            Client client = clientService.findByUsername(username);

            if (client != null) {
                // Chercher le panier de l'utilisateur (commande avec statut "CART")
                List<Order> orders = orderService.getOrdersByClient(client);
                Order cartOrder = orders.stream()
                        .filter(order -> "CART".equals(order.getStatus()))
                        .findFirst()
                        .orElse(null);

                if (cartOrder != null && cartOrder.getOrderLines() != null) {
                    List<OrderLine> cartItems = cartOrder.getOrderLines();
                    model.addAttribute("cartItems", cartItems);

                    // Calculer les totaux
                    double subtotal = cartItems.stream()
                            .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                            .sum();
                    model.addAttribute("subtotal", subtotal);
                    model.addAttribute("cartOrder", cartOrder);
                } else {
                    model.addAttribute("cartItems", new ArrayList<>());
                    model.addAttribute("subtotal", 0.0);
                }
            }
        } else {
            // Utilisateur non connecté - panier vide
            model.addAttribute("cartItems", new ArrayList<>());
            model.addAttribute("subtotal", 0.0);
        }

        return "cart";
    }

    @GetMapping("/profile")
    public String profile() {
        System.out.println("profile");
        return "profile";
    }

    // Ajouter un produit au panier
    @PostMapping("/cart/add")
    @ResponseBody
    public String addToCart(@RequestParam Long productId, @RequestParam(defaultValue = "1") int quantity) {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();

            if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
                return "error:Vous devez être connecté pour ajouter des produits au panier";
            }

            String username = auth.getName();
            Client client = clientService.findByUsername(username);
            Product product = productService.getById(productId);

            if (client == null) {
                return "error:Utilisateur non trouvé";
            }

            if (product == null) {
                return "error:Produit non trouvé";
            }

            // Vérifier le stock
            if (product.getStock() < quantity) {
                return "error:Stock insuffisant";
            }

            // Chercher ou créer le panier (commande avec statut "CART")
            List<Order> orders = orderService.getOrdersByClient(client);
            Order cartOrder = orders.stream()
                    .filter(order -> "CART".equals(order.getStatus()))
                    .findFirst()
                    .orElse(null);

            if (cartOrder == null) {
                // Créer une nouvelle commande panier
                cartOrder = new Order();
                cartOrder.setClient(client);
                cartOrder.setStatus("CART");
                cartOrder.setDate(LocalDate.now());
                cartOrder = orderService.save(cartOrder);
            }

            // Vérifier si le produit est déjà dans le panier
            OrderLine existingLine = null;
            if (cartOrder.getOrderLines() != null) {
                for (OrderLine line : cartOrder.getOrderLines()) {
                    if (line.getProduct().getId().equals(productId)) {
                        existingLine = line;
                        break;
                    }
                }
            }

            if (existingLine != null) {
                // Mettre à jour la quantité
                int newQuantity = existingLine.getQuantity() + quantity;
                if (product.getStock() < newQuantity) {
                    return "error:Stock insuffisant pour cette quantité";
                }
                existingLine.setQuantity(newQuantity);
                orderLineService.save(existingLine);
            } else {
                // Ajouter une nouvelle ligne
                orderLineService.addOrderLine(cartOrder, product, quantity);
            }

            return "success:Produit ajouté au panier";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Mettre à jour la quantité d'un produit dans le panier
    @PostMapping("/cart/update")
    @ResponseBody
    public String updateCartItem(@RequestParam Long productId, @RequestParam int quantity) {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();

            if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
                return "error:Vous devez être connecté";
            }

            String username = auth.getName();
            Client client = clientService.findByUsername(username);

            // Chercher le panier
            List<Order> orders = orderService.getOrdersByClient(client);
            Order cartOrder = orders.stream()
                    .filter(order -> "CART".equals(order.getStatus()))
                    .findFirst()
                    .orElse(null);

            if (cartOrder == null) {
                return "error:Panier non trouvé";
            }

            // Trouver la ligne à mettre à jour
            OrderLine lineToUpdate = null;
            if (cartOrder.getOrderLines() != null) {
                for (OrderLine line : cartOrder.getOrderLines()) {
                    if (line.getProduct().getId().equals(productId)) {
                        lineToUpdate = line;
                        break;
                    }
                }
            }

            if (lineToUpdate == null) {
                return "error:Produit non trouvé dans le panier";
            }

            if (quantity <= 0) {
                // Supprimer l'item
                orderLineService.delete(lineToUpdate.getId());
                return "success:Produit supprimé du panier";
            } else {
                // Vérifier le stock
                if (lineToUpdate.getProduct().getStock() < quantity) {
                    return "error:Stock insuffisant";
                }
                // Mettre à jour la quantité
                lineToUpdate.setQuantity(quantity);
                orderLineService.save(lineToUpdate);
                return "success:Quantité mise à jour";
            }
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }

    // Supprimer un produit du panier
    @PostMapping("/cart/remove")
    @ResponseBody
    public String removeFromCart(@RequestParam Long productId) {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();

            if (auth == null || !auth.isAuthenticated() || auth.getName().equals("anonymousUser")) {
                return "error:Vous devez être connecté";
            }

            String username = auth.getName();
            Client client = clientService.findByUsername(username);

            // Chercher le panier
            List<Order> orders = orderService.getOrdersByClient(client);
            Order cartOrder = orders.stream()
                    .filter(order -> "CART".equals(order.getStatus()))
                    .findFirst()
                    .orElse(null);

            if (cartOrder == null) {
                return "error:Panier non trouvé";
            }

            // Trouver et supprimer la ligne
            OrderLine lineToRemove = null;
            if (cartOrder.getOrderLines() != null) {
                for (OrderLine line : cartOrder.getOrderLines()) {
                    if (line.getProduct().getId().equals(productId)) {
                        lineToRemove = line;
                        break;
                    }
                }
            }

            if (lineToRemove == null) {
                return "error:Produit non trouvé dans le panier";
            }

            orderLineService.delete(lineToRemove.getId());
            return "success:Produit supprimé du panier";
        } catch (Exception e) {
            return "error:" + e.getMessage();
        }
    }
}