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
        String sql = "INSERT INTO libro (isbn, titulo, autor, precio, stock, stockMinimo, etiqueta) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, libro.getIsbn());
            ps.setString(2, libro.getTitulo());
            ps.setString(3, libro.getAutor());
            ps.setDouble(4, libro.getPrecio());
            ps.setInt(5, libro.getStock());
            ps.setInt(6, libro.getStockMinimo());
            ps.setString(7, libro.getEtiqueta());
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
        Libro libro = null;
        String sql = "SELECT * FROM libro WHERE idLibro = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    libro = new Libro(
                        rs.getInt("idLibro"),
                        rs.getString("isbn"),
                        rs.getString("titulo"),
                        rs.getString("autor"),
                        rs.getDouble("precio"),
                        rs.getInt("stock"),
                        rs.getInt("stockMinimo"),
                        rs.getString("etiqueta")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return libro;
    }

    @Override
    public Libro findByIsbn(String isbn) {
        Libro libro = null;
        String sql = "SELECT * FROM libro WHERE isbn = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, isbn);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    libro = new Libro(
                        rs.getInt("idLibro"),
                        rs.getString("isbn"),
                        rs.getString("titulo"),
                        rs.getString("autor"),
                        rs.getDouble("precio"),
                        rs.getInt("stock"),
                        rs.getInt("stockMinimo"),
                        rs.getString("etiqueta")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return libro;
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
                        rs.getInt("stockMinimo"),
                        rs.getString("etiqueta")
                    );
                    lista.add(l);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Libro> findByEtiqueta(String etiqueta) {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libro WHERE etiqueta = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, etiqueta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Libro l = new Libro(
                        rs.getInt("idLibro"),
                        rs.getString("isbn"),
                        rs.getString("titulo"),
                        rs.getString("autor"),
                        rs.getDouble("precio"),
                        rs.getInt("stock"),
                        rs.getInt("stockMinimo"),
                        rs.getString("etiqueta")
                    );
                    lista.add(l);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // <-- MÉTODO FALTANTE AÑADIDO AQUÍ -->
    @Override
    public List<Libro> findAll() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libro";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Libro l = new Libro(
                    rs.getInt("idLibro"),
                    rs.getString("isbn"),
                    rs.getString("titulo"),
                    rs.getString("autor"),
                    rs.getDouble("precio"),
                    rs.getInt("stock"),
                    rs.getInt("stockMinimo"),
                    rs.getString("etiqueta")
                );
                lista.add(l);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}