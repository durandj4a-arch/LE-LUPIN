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
import com.lelupin.model.DetalleVenta;
import com.lelupin.model.Venta;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VentaRepositoryImpl implements IVentaRepository {

    @Override
    public boolean registrarVenta(Venta venta) {
        String sqlVenta = "INSERT INTO venta (cliente, fecha, total, estado) VALUES (?, NOW(), ?, 'ACTIVA')";
        String sqlDetalle = "INSERT INTO detalle_venta (id_venta, id_libro, cantidad, subtotal) VALUES (?, ?, ?, ?)";
        String sqlUpdateStock = "UPDATE libro SET stock = stock - ? WHERE id_libro = ?";
        
        Connection con = null;
        try {
            con = Conexion.getConexion();
            con.setAutoCommit(false);

            PreparedStatement psVenta = con.prepareStatement(sqlVenta, Statement.RETURN_GENERATED_KEYS);
            psVenta.setString(1, venta.getCliente());
            psVenta.setDouble(2, venta.getTotal());
            psVenta.executeUpdate();

            ResultSet rsKeys = psVenta.getGeneratedKeys();
            int idVentaGenerado = 0;
            if (rsKeys.next()) {
                idVentaGenerado = rsKeys.getInt(1);
            }

            PreparedStatement psDetalle = con.prepareStatement(sqlDetalle);
            PreparedStatement psStock = con.prepareStatement(sqlUpdateStock);

            for (DetalleVenta det : venta.getDetalles()) {
                psDetalle.setInt(1, idVentaGenerado);
                psDetalle.setInt(2, det.getIdLibro());
                psDetalle.setInt(3, det.getCantidad());
                psDetalle.setDouble(4, det.getSubtotal());
                psDetalle.executeUpdate();

                psStock.setInt(1, det.getCantidad());
                psStock.setInt(2, det.getIdLibro());
                psStock.executeUpdate();
            }

            con.commit();
            return true;

        } catch (SQLException e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    @Override
    public List<Venta> listarVentas() {
        List<Venta> lista = new ArrayList<>();
        String sql = "SELECT * FROM venta";
        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Venta v = new Venta();
                v.setIdVenta(rs.getInt("id_venta"));
                v.setCliente(rs.getString("cliente"));
                v.setFecha(rs.getTimestamp("fecha"));
                v.setTotal(rs.getDouble("total"));
                v.setEstado(rs.getString("estado"));
                lista.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Venta buscarPorId(int idVenta) {
        return null;
    }
}