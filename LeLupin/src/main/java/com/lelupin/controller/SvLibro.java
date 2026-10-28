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
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvLibro", urlPatterns = {"/SvLibro"})
public class SvLibro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");


        String isbn = request.getParameter("isbn");
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int stockMinimo = Integer.parseInt(request.getParameter("stockMinimo"));
        String etiqueta = request.getParameter("etiqueta");


        Libro libro = new Libro();
        libro.setIsbn(isbn);
        libro.setTitulo(titulo);
        libro.setAutor(autor);
        libro.setPrecio(precio);
        libro.setStock(stock);
        libro.setStockMinimo(stockMinimo);
        libro.setEtiqueta(etiqueta);

        LibroRepositoryImpl libroRepo = new LibroRepositoryImpl();
        libroRepo.save(libro);


        response.sendRedirect("bienvenido.jsp");
    }
}