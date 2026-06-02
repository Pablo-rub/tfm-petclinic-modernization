package com.petclinic.vets.model;

import jakarta.persistence.*;
import java.util.*;

@Entity
@Table(name = "vets")
public class Vet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "vet_specialties",
        joinColumns = @JoinColumn(name = "vet_id"),
        inverseJoinColumns = @JoinColumn(name = "specialty_id"))
    private Set<Specialty> specialties = new HashSet<>();

    public Integer getId() { return id; }
    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }

    public List<Specialty> getSpecialties() {
        List<Specialty> sorted = new ArrayList<>(specialties);
        sorted.sort(Comparator.comparing(Specialty::getName, String.CASE_INSENSITIVE_ORDER));
        return Collections.unmodifiableList(sorted);
    }
}
