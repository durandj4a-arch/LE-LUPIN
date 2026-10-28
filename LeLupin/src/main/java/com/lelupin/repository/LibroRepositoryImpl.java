/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.repository;

import com.lelupin.conexion.Conexion;
import com.lelupin.model.Libro;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class LibroRepositoryImpl implements ILibroRepository {

    private Libro mapear(ResultSet rs) throws SQLException {
        return new Libro(
            rs.getInt("id_libro"),
            rs.getString("isbn"),
            rs.getString("titulo"),
            rs.getString("autor"),
            rs.getDouble("precio"),
            rs.getInt("stock"),
            rs.getInt("stock_minimo"),
            rs.getString("etiqueta")
        );
    }

    @Override
    public Libro save(Libro libro) {
        String sql = "INSERT INTO libro (isbn, titulo, autor, precio, stock, stock_minimo, etiqueta) VALUES (?, ?, ?, ?, ?, ?, ?)";
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
            throw new RuntimeException("Error al guardar libro: " + e.getMessage(), e);
        }
        return libro;
    }

    @Override
    public Libro findById(int id) {
        String sql = "SELECT * FROM libro WHERE id_libro = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Libro findByIsbn(String isbn) {
        String sql = "SELECT * FROM libro WHERE isbn = ?";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, isbn);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
                    lista.add(mapear(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public List<Libro> findAll() {
        List<Libro> lista = new ArrayList<>();
        String sql = "SELECT * FROM libro";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}