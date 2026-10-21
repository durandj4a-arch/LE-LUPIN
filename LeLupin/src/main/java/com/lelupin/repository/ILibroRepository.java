/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.repository;

/**
 *
 * @author Joshua
 */
import com.lelupin.model.Libro;
import java.util.List;

public interface ILibroRepository {
    Libro save(Libro libro);
    Libro findById(int id);
    Libro findByIsbn(String isbn);
    List<Libro> findByStockLessThan(int stockMinimo);
}