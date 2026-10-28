/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.model;

/**
 *
 * @author Joshua
 */
import java.util.Date;
import java.util.List;

public class Venta {
    private int idVenta;
    private String cliente;
    private Date fecha;
    private double total;
    private String estado;
    private List<DetalleVenta> detalles;

    public Venta() {}

    public Venta(int idVenta, String cliente, Date fecha, double total, String estado) {
        this.idVenta = idVenta;
        this.cliente = cliente;
        this.fecha = fecha;
        this.total = total;
        this.estado = estado;
    }

    public int getIdVenta() { return idVenta; }
    public void setIdVenta(int idVenta) { this.idVenta = idVenta; }
    
    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }
    
    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }
    
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public List<DetalleVenta> getDetalles() { return detalles; }
    public void setDetalles(List<DetalleVenta> detalles) { this.detalles = detalles; }
}