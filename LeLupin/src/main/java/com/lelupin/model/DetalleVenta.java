/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.model;

/**
 *
 * @author Joshua
 */

import com.lelupin.model.Venta;
import com.lelupin.model.DetalleVenta;
public class DetalleVenta {
    private int idDetalle;
    private int idVenta;
    private int idLibro;
    private int cantidad;
    private double subtotal;

    public DetalleVenta() {}

    public DetalleVenta(int idDetalle, int idVenta, int idLibro, int cantidad, double subtotal) {
        this.idDetalle = idDetalle;
        this.idVenta = idVenta;
        this.idLibro = idLibro;
        this.cantidad = cantidad;
        this.subtotal = subtotal;
    }

    public int getIdDetalle() { return idDetalle; }
    public void setIdDetalle(int idDetalle) { this.idDetalle = idDetalle; }
    public int getIdVenta() { return idVenta; }
    public void setIdVenta(int idVenta) { this.idVenta = idVenta; }
    public int getIdLibro() { return idLibro; }
    public void setIdLibro(int idLibro) { this.idLibro = idLibro; }
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
}