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
        String sqlVenta = "INSERT INTO venta (cliente, fecha, total) VALUES (?, NOW(), ?)";
        String sqlDetalle = "INSERT INTO detalle_venta (id_venta, id_libro, cantidad, subtotal) VALUES (?, ?, ?, ?)";
        
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
            for (DetalleVenta det : venta.getDetalles()) {
                psDetalle.setInt(1, idVentaGenerado);
                psDetalle.setInt(2, det.getIdLibro());
                psDetalle.setInt(3, det.getCantidad());
                psDetalle.setDouble(4, det.getSubtotal());
                psDetalle.executeUpdate();
            }

            con.commit();
            return true;

        } catch (SQLException e) {
            if (con != null) {
                try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Venta buscarPorId(int idVenta) {
        return null;
    }

    @Override
    public List<Venta> listarVentas() {
        return new ArrayList<>();
    }
}