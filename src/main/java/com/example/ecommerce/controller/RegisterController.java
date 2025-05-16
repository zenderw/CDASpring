package com.example.ecommerce.controller;

import com.example.ecommerce.model.Client;
import com.example.ecommerce.model.Role;
import com.example.ecommerce.repository.RoleRepository;
import com.example.ecommerce.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class RegisterController {

    @Autowired
    private ClientService clientService;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               Model model) {

        try {
            // Vérification si l'utilisateur existe déjà
            if (clientService.findByUsername(username) != null) {
                model.addAttribute("error", "Username already exists!");
                return "register";
            }

            // Création d'un nouveau client
            Client client = new Client();
            client.setUsername(username);
            client.setPassword(passwordEncoder.encode(password));

            // Attribution du rôle USER
            Role userRole = roleRepository.findByRoleName("ROLE_USER")
                    .orElseThrow(() -> new RuntimeException("ROLE_USER not found"));
            client.setRoles(List.of(userRole));

            // Sauvegarde du client
            clientService.save(client);

            model.addAttribute("success", "Registration successful! You can now log in.");
            return "login";

        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "register";
        }
    }
}