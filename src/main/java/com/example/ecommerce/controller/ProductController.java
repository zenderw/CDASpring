package com.example.ecommerce.controller;

import com.example.ecommerce.model.Product;
import com.example.ecommerce.service.ProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService service;

    @GetMapping
    public String listProducts(Model model) {
        model.addAttribute("products", service.getAll());
        return "products";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("product", new Product());
        return "products/add";
    }

    @PostMapping("/save")
    public String saveProduct(@ModelAttribute @Valid Product product, BindingResult result) {
        if (result.hasErrors()) {
            return "products/add"; // ou une autre vue si erreur
        }
        service.save(product);
        return "redirect:/products";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/products";
    }
}
