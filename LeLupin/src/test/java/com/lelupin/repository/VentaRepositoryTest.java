package com.lelupin.repository;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Joshua
 */
import com.lelupin.model.DetalleVenta;
import com.lelupin.model.Venta;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.junit.Test;
import static org.junit.Assert.*;

public class VentaRepositoryTest {

    @Test
    public void testRegistrarVenta() {

        Venta venta = new Venta();
        venta.setCliente("Cliente Test JUnit");
        venta.setFecha(new Date());
        venta.setTotal(49.90);

        List<DetalleVenta> detalles = new ArrayList<>();
        detalles.add(new DetalleVenta(0, 0, 1, 1, 49.90));
        venta.setDetalles(detalles);

        IVentaRepository repo = new VentaRepositoryImpl();
        boolean resultado = repo.registrarVenta(venta);


        assertTrue("La venta debió registrarse con éxito en TiDB Cloud", resultado);
    }
}