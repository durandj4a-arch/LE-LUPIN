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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvVenta", urlPatterns = {"/SvVenta"})
public class SvVenta extends HttpServlet {

    private final VentaRepositoryImpl ventaRepo = new VentaRepositoryImpl();

    private String codificar(String texto) {
        return URLEncoder.encode(texto, StandardCharsets.UTF_8);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        if (accion == null || accion.trim().isEmpty()) {
            accion = "registrar";
        }

        try {
            switch (accion) {
                case "actualizar": {
                    int idVenta = Integer.parseInt(request.getParameter("idVenta"));
                    String cliente = request.getParameter("cliente");
                    double total = Double.parseDouble(request.getParameter("total"));
                    String estado = request.getParameter("estado");

                    Venta venta = new Venta();
                    venta.setIdVenta(idVenta);
                    venta.setCliente(cliente);
                    venta.setTotal(total);
                    venta.setEstado(estado);

                    boolean ok = ventaRepo.actualizar(venta);
                    String msg = ok
                            ? "Venta #" + idVenta + " actualizada correctamente."
                            : "No se pudo actualizar la venta #" + idVenta + ".";
                    response.sendRedirect("bienvenido.jsp?tab=historial-ventas&msg=" + codificar(msg));
                    break;
                }
                case "eliminar": {
                    int idVenta = Integer.parseInt(request.getParameter("idVenta"));
                    boolean ok = ventaRepo.eliminar(idVenta);
                    String msg = ok
                            ? "Venta #" + idVenta + " eliminada correctamente."
                            : "No se pudo eliminar la venta #" + idVenta + ".";
                    response.sendRedirect("bienvenido.jsp?tab=historial-ventas&msg=" + codificar(msg));
                    break;
                }
                case "registrar":
                default: {
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

                    boolean ok = ventaRepo.registrarVenta(venta);
                    String msg = ok
                            ? "Venta registrada y stock actualizado correctamente."
                            : "No se pudo registrar la venta.";
                    response.sendRedirect("bienvenido.jsp?tab=historial-ventas&msg=" + codificar(msg));
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "Error en la operación de venta: " + (e.getMessage() != null ? e.getMessage() : "revisa los datos");
            response.sendRedirect("bienvenido.jsp?tab=historial-ventas&msg=" + codificar(msg));
        }
    }
}