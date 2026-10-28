/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.repository;

/**
 *
 * @author Joshua
 */
import com.lelupin.model.Venta;
import java.util.List;

public interface IVentaRepository {
    boolean registrarVenta(Venta venta);
    Venta buscarPorId(int idVenta);
    List<Venta> listarVentas();
}