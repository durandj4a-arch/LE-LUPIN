/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.controller;

/**
 *
 * @author Joshua
 */
import com.lelupin.model.Libro;
import com.lelupin.repository.LibroRepositoryImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/SvLibro")
public class SvLibro extends HttpServlet {

    private final LibroRepositoryImpl libroRepo = new LibroRepositoryImpl();

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
                    int idLibro = Integer.parseInt(request.getParameter("idLibro"));
                    Libro libro = construirLibroDesdeRequest(request);
                    libro.setIdLibro(idLibro);

                    boolean ok = libroRepo.actualizar(libro);
                    String msg = ok
                            ? "Libro #" + idLibro + " actualizado correctamente."
                            : "No se pudo actualizar el libro #" + idLibro + ".";
                    response.sendRedirect("bienvenido.jsp?tab=catalogo&msg=" + codificar(msg));
                    break;
                }
                case "eliminar": {
                    int idLibro = Integer.parseInt(request.getParameter("idLibro"));
                    boolean ok = libroRepo.eliminar(idLibro);
                    String msg = ok
                            ? "Libro #" + idLibro + " eliminado correctamente."
                            : "No se pudo eliminar el libro #" + idLibro + ".";
                    response.sendRedirect("bienvenido.jsp?tab=catalogo&msg=" + codificar(msg));
                    break;
                }
                case "registrar":
                default: {
                    Libro libro = construirLibroDesdeRequest(request);
                    libroRepo.save(libro);
                    String msg = "Libro registrado correctamente en el catálogo.";
                    response.sendRedirect("bienvenido.jsp?tab=catalogo&msg=" + codificar(msg));
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            String msg = "Error al procesar el libro: " + (e.getMessage() != null ? e.getMessage() : "revisa los datos");
            response.sendRedirect("bienvenido.jsp?tab=catalogo&msg=" + codificar(msg));
        }
    }

    private Libro construirLibroDesdeRequest(HttpServletRequest request) {
        String isbn = request.getParameter("isbn");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String etiqueta = request.getParameter("etiqueta");

        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int stockMinimo = Integer.parseInt(request.getParameter("stockMinimo"));

        Libro libro = new Libro();
        libro.setIsbn(isbn);
        libro.setTitulo(titulo);
        libro.setAutor(autor);
        libro.setPrecio(precio);
        libro.setStock(stock);
        libro.setStockMinimo(stockMinimo);
        libro.setEtiqueta(etiqueta);
        return libro;
    }
}