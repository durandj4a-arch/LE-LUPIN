/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.dao;

import com.lelupin.conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDao {

    public boolean validarLogin(String username, String password) {
        boolean esValido = false;
        // Cambiamos "correo" por "username" que es como lo creamos en la BD de TiDB
        String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";

        try {
            // Llamada directa al método estático de tu clase Conexion (Patrón Singleton)
            Connection con = Conexion.getConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                esValido = true;
            }
        } catch (SQLException e) {
            System.out.println("Error en la consulta de login: " + e.getMessage());
        }

        return esValido;
    }
}