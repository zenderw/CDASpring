package com.example.ecommerce.service;

import com.example.ecommerce.exception.ResourceNotFoundException;
import com.example.ecommerce.model.Client;
import com.example.ecommerce.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClientService {

    @Autowired
    private ClientRepository repository;

    public List<Client> getAll() {
        return repository.findAll();
    }

    public Client getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Client with ID " + id + " not found"));
    }

    public Client save(Client client) {
        return repository.save(client);
    }

    public void delete(Long id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Cannot delete. Client with ID " + id + " not found");
        }
        repository.deleteById(id);
    }



public Client findByUsername(String username) {
    return repository.findByUsername(username)
            .orElseThrow(() -> new RuntimeException("Client not found with username: " + username));
}



}
