/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.controller;

/**
 *
 * @author Joshua
 */
import com.lelupin.model.DetalleVenta;
import com.lelupin.model.Venta;
import com.lelupin.repository.VentaRepositoryImpl;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvVenta", urlPatterns = {"/SvVenta"})
public class SvVenta extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");


        String cliente = request.getParameter("cliente");
        int idLibro = Integer.parseInt(request.getParameter("idLibro"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        double total = Double.parseDouble(request.getParameter("total"));


        Venta venta = new Venta();
        venta.setCliente(cliente);
        venta.setTotal(total);

        List<DetalleVenta> detalles = new ArrayList<>();
        DetalleVenta detalle = new DetalleVenta();
        detalle.setIdLibro(idLibro);
        detalle.setCantidad(cantidad);
        detalle.setSubtotal(total);
        detalles.add(detalle);

        venta.setDetalles(detalles);


        VentaRepositoryImpl ventaRepo = new VentaRepositoryImpl();
        ventaRepo.registrarVenta(venta);


        response.sendRedirect("bienvenido.jsp");
    }
}