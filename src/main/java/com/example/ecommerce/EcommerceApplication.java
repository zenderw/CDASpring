package com.example.ecommerce;

import com.example.ecommerce.model.Client;
import com.example.ecommerce.model.Role;
import com.example.ecommerce.repository.ClientRepository;
import com.example.ecommerce.repository.RoleRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;

@SpringBootApplication
public class EcommerceApplication {

    public static void main(String[] args) {
        SpringApplication.run(EcommerceApplication.class, args);
    }

    @Bean
    CommandLineRunner init(ClientRepository clientRepository, RoleRepository roleRepository, PasswordEncoder encoder) {
        return args -> {
            // Crée un rôle USER si inexistant
            Role userRole = roleRepository.findByRoleName("ROLE_USER")
                    .orElseGet(() -> {
                        Role role = new Role();
                        role.setRoleName("ROLE_USER");
                        return roleRepository.save(role);
                    });

            // Crée un utilisateur avec mot de passe encodé
            if (clientRepository.findByUsername("boss").isEmpty()) {
                Client client = new Client();
                client.setUsername("boss");
                client.setPassword(encoder.encode("1234"));
                client.setRoles(List.of(userRole));
                clientRepository.save(client);
            }
        };
    }

}
