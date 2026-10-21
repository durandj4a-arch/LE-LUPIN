/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.repository;

/**
 *
 * @author Joshua
 */
import com.lelupin.conexion.Conexion;
import com.lelupin.model.Libro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibroRepositoryImpl implements ILibroRepository {

    @Override
    public Libro save(Libro libro) {
        String sql = "INSERT INTO libro (isbn, titulo, autor, precio, stock, stockMinimo) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, libro.getIsbn());
            ps.setString(2, libro.getTitulo());
            ps.setString(3, libro.getAutor());
            ps.setDouble(4, libro.getPrecio());
            ps.setInt(5, libro.getStock());
            ps.setInt(6, libro.getStockMinimo());
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    libro.setIdLibro(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return libro;
    }

    @Override
    public Libro findById(int id) {

        return null;
    }

    @Override
    public Libro findByIsbn(String isbn) {

        return null;
    }

    @Override
    public List<Libro> findByStockLessThan(int stockMinimo) {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libro WHERE stock < ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, stockMinimo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Libro l = new Libro(
                        rs.getInt("idLibro"),
                        rs.getString("isbn"),
                        rs.getString("titulo"),
                        rs.getString("autor"),
                        rs.getDouble("precio"),
                        rs.getInt("stock"),
                        rs.getInt("stockMinimo")
                    );
                    lista.add(l);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}