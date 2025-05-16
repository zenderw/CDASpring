package com.example.ecommerce.controller;

import com.example.ecommerce.model.Client;
import com.example.ecommerce.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/clients")
public class ClientController {

    @Autowired
    private ClientService service;

    public ClientController(ClientService service) {
        this.service = service;
    }

    @GetMapping
    public String listClients(Model model) {
        model.addAttribute("clients", service.getAll());
        return "clients/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("client", new Client());
        return "clients/add";
    }

    @PostMapping("/save")
    public String saveClient(@ModelAttribute Client client) {
        service.save(client);
        return "redirect:/clients";
    }

    @GetMapping("/delete/{id}")
    public String deleteClient(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/clients";
    }
}
