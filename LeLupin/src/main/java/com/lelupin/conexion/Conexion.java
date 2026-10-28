/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.lelupin.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static Connection conexion = null;

    private static final String HOST = "gateway01.ap-northeast-1.prod.aws.tidbcloud.com";
    private static final String PORT = "4000";
    private static final String DB_NAME = "lelupin";
    private static final String USER = "2XC1gsiHF4wss75.root";
    

    private static final String PASSWORD = "V55HT5YmAHfi8PJ3"; 

    private Conexion() {}

    public static Connection getConexion() {

        try {
            if (conexion == null || conexion.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                

                String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME 
                        + "?useSSL=true&requireSSL=true&sslMode=VERIFY_IDENTITY&enabledTLSProtocols=TLSv1.2,TLSv1.3";
                
                conexion = DriverManager.getConnection(url, USER, PASSWORD);
                System.out.println(">>> [Le Lupin] ¡CONEXIÓN EXITOSA A TIDB CLOUD! <<<");
            }
        } catch (ClassNotFoundException e) {
            System.err.println(">>> ERROR: Driver de MySQL no encontrado en las dependencias: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println(">>> ERROR DE SQL AL CONECTAR A TIDB:");
            e.printStackTrace();
        }
        return conexion;
    }
}