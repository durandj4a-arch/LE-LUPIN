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

@WebServlet("/SvLibro")
public class SvLibro extends HttpServlet {

    private LibroRepositoryImpl libroRepo = new LibroRepositoryImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
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

            libroRepo.save(libro);


            response.sendRedirect("bienvenido.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("bienvenido.jsp?error=1");
        }
    }
}