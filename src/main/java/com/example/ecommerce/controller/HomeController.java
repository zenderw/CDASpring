package com.example.ecommerce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {


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
    public String viewCart() {
        return "cart";
    }

    @GetMapping("/profile")
    public String profile() {
        System.out.println("profile");
        return "profile";
    }
}
