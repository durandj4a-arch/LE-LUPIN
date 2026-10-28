/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "gateway01.ap-northeast-1.prod.aws.tidbcloud.com";
    private static final String PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "4000";
    private static final String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "lelupin";
    private static final String USER = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "2XC1gsiHF4wss75.root";
    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "V55HT5YmAHfi8PJ3";

    private Conexion() {}

    public static Connection getConexion() {
        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME 
                    + "?useSSL=true&trustServerCertificate=true&allowPublicKeyRetrieval=true";
            
            conexion = DriverManager.getConnection(url, USER, PASSWORD);
            System.out.println(">>> [Le Lupin] ¡CONEXIÓN EXITOSA A TIDB CLOUD! <<<");
        } catch (ClassNotFoundException e) {
            System.err.println(">>> ERROR: Driver de MySQL no encontrado: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println(">>> ERROR DE SQL AL CONECTAR A TIDB: " + e.getMessage());
            e.printStackTrace();
        }
        return conexion;
    }
}