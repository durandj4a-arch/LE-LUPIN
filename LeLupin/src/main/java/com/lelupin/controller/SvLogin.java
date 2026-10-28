/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.controller;


import com.lelupin.dao.UsuarioDao;
import com.lelupin.conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try (PrintWriter out = response.getWriter()) {
            // PROBANDO CONEXIÓN DIRECTAMENTE AQUÍ
            Connection testConn = Conexion.getConexion();
            if (testConn == null) {
                out.println("<h2>¡ALERTA! La conexión a TiDB Cloud devolvió NULL (Falló).</h2>");
                return;
            }
            
            UsuarioDao dao = new UsuarioDao();
            boolean autorizado = dao.validarLogin(username, password);
            
            if (autorizado) {
                response.sendRedirect("bienvenido.jsp");
            } else {
                out.println("<h3>Usuario o contraseña incorrectos en la BD.</h3>");
                out.println("<a href='index.jsp'>Volver</a>");
            }
        } catch (Exception e) {
            response.getWriter().println("<h2>Error crítico capturado: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        }
    }
}