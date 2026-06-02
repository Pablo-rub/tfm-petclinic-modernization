package com.petclinic.vets.web;

import com.petclinic.vets.model.Vet;
import com.petclinic.vets.repository.VetRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/vets")
public class VetController {

    private final VetRepository vetRepository;

    public VetController(VetRepository vetRepository) {
        this.vetRepository = vetRepository;
    }

    @GetMapping
    public List<Vet> getAllVets() {
        return vetRepository.findAll();
    }
}
