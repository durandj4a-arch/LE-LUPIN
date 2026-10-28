<%-- 
    Document   : bienvenido
    Created on : 7 oct. 2026, 11:53:10 p. m.
    Author     : Joshua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lelupin.repository.LibroRepositoryImpl" %>
<%@ page import="com.lelupin.repository.VentaRepositoryImpl" %>
<%@ page import="com.lelupin.model.Libro" %>
<%@ page import="com.lelupin.model.Venta" %>
<%@ page import="java.util.List" %>

<%
    LibroRepositoryImpl libroRepo = new LibroRepositoryImpl();
    List<Libro> listaLibros = libroRepo.findAll();

    VentaRepositoryImpl ventaRepo = new VentaRepositoryImpl();
    List<Venta> listaVentas = ventaRepo.listarVentas();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Le Lupin — Panel de Control</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f2eb;
            color: #1a1a1a;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        header {
            background-color: #16221f;
            color: #f5f2eb;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        header h1 {
            margin: 0;
            font-family: serif;
            font-size: 1.8rem;
        }
        .logout {
            color: #f5f2eb;
            text-decoration: none;
            border: 1px solid #f5f2eb;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background 0.2s;
        }
        .logout:hover {
            background-color: #f5f2eb;
            color: #16221f;
        }
        .main-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            flex: 1;
            width: 100%;
            box-sizing: border-box;
        }
        .nav-tabs {
            display: flex;
            border-bottom: 2px solid #16221f;
            margin-bottom: 25px;
            gap: 5px;
        }
        .tab-btn {
            background: none;
            border: none;
            padding: 12px 20px;
            font-size: 0.9rem;
            font-weight: bold;
            color: #666;
            cursor: pointer;
            border-radius: 4px 4px 0 0;
            transition: all 0.2s;
            width: auto;
        }
        .tab-btn.active {
            background-color: #16221f;
            color: #f5f2eb;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-row {
            display: flex;
            gap: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
        label {
            display: block;
            font-size: 0.75rem;
            font-weight: bold;
            letter-spacing: 1px;
            color: #444;
            margin-bottom: 5px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 0.95rem;
            box-sizing: border-box;
        }
        .btn-submit {
            background-color: #16221f;
            color: white;
            border: none;
            padding: 12px 20px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 4px;
            letter-spacing: 1px;
            width: 100%;
            margin-top: 10px;
            transition: background 0.2s;
        }
        .btn-submit:hover {
            background-color: #2b3d38;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #16221f;
            color: white;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }
        tr:hover {
            background-color: #f9f7f2;
        }
        .badge-stock {
            background-color: #2e7d32;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .badge-warning {
            background-color: #e65100;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .badge-danger {
            background-color: #c62828;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        .badge-status {
            background-color: #1565c0;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <header>
        <h1>Le Lupin — Panel de Control</h1>
        <a href="index.jsp" class="logout">Cerrar Sesión</a>
    </header>

    <div class="main-container">

        <div class="nav-tabs">
            <button class="tab-btn active" onclick="showTab('catalogo')">📚 Catálogo de Libros</button>
            <button class="tab-btn" onclick="showTab('registrar-libro')">➕ Registrar Nuevo Libro</button>
            <button class="tab-btn" onclick="showTab('registrar-venta')">🛒 Registrar Venta</button>
            <button class="tab-btn" onclick="showTab('historial-ventas')">📜 Historial de Ventas</button>
        </div>

        <div id="catalogo" class="tab-content active">
            <h2>Catálogo de Libros Disponibles</h2>
            <p>Lista de ejemplares registrados en la base de datos de TiDB Cloud.</p>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>ISBN</th>
                        <th>TÍTULO</th>
                        <th>AUTOR</th>
                        <th>GÉNERO</th>
                        <th>PRECIO (S/)</th>
                        <th>STOCK</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (listaLibros != null && !listaLibros.isEmpty()) {
                            for (Libro lib : listaLibros) {
                    %>
                    <tr>
                        <td><strong><%= lib.getIdLibro() %></strong></td>
                        <td><%= lib.getIsbn() %></td>
                        <td><%= lib.getTitulo() %></td>
                        <td><%= lib.getAutor() %></td>
                        <td><%= lib.getEtiqueta() != null ? lib.getEtiqueta() : "Sin Género" %></td>
                        <td>S/ <%= String.format("%.2f", lib.getPrecio()) %></td>
                        <td>
                            <% if (lib.getStock() <= 0) { %>
                                <span class="badge-danger">Agotado (0)</span>
                            <% } else if (lib.getStock() <= lib.getStockMinimo()) { %>
                                <span class="badge-warning"><%= lib.getStock() %> un. (Bajo)</span>
                            <% } else { %>
                                <span class="badge-stock"><%= lib.getStock() %> un.</span>
                            <% } %>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align: center; color: #888;">No hay libros registrados en el inventario.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div id="registrar-libro" class="tab-content">
            <h2>Registrar Nuevo Libro al Catálogo</h2>
            <p>Ingrese los datos bibliográficos para añadir una obra al inventario.</p>
            <form action="SvLibro" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label>ISBN</label>
                        <input type="text" name="isbn" placeholder="Ej. 978-1234567890" required>
                    </div>
                    <div class="form-group">
                        <label>PRECIO (S/)</label>
                        <input type="number" step="0.01" name="precio" placeholder="Ej. 35.00" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>TÍTULO DEL LIBRO</label>
                    <input type="text" name="titulo" placeholder="Ej. El conde de Montecristo" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>AUTOR</label>
                        <input type="text" name="autor" placeholder="Ej. Alexandre Dumas" required>
                    </div>
                    <div class="form-group">
                        <label>GÉNERO / ETIQUETA</label>
                        <select name="etiqueta" required>
                            <option value="" disabled selected>Seleccione un género</option>
                            <option value="Manga">Manga</option>
                            <option value="Cómic">Cómic</option>
                            <option value="Drama">Drama</option>
                            <option value="Novela">Novela</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>STOCK INICIAL</label>
                        <input type="number" name="stock" placeholder="Ej. 20" required>
                    </div>
                    <div class="form-group">
                        <label>STOCK MÍNIMO</label>
                        <input type="number" name="stockMinimo" placeholder="Ej. 3" required>
                    </div>
                </div>
                <button type="submit" class="btn-submit">Añadir Libro a la Base de Datos</button>
            </form>
        </div>

        <div id="registrar-venta" class="tab-content">
            <h2>Módulo de Registro de Ventas</h2>
            <p>Complete los datos para procesar una nueva venta y actualizar el stock automáticamente.</p>
            <form action="SvVenta" method="POST">
                <div class="form-group">
                    <label>NOMBRE DEL CLIENTE</label>
                    <input type="text" name="cliente" placeholder="Ej. Juan Pérez" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>ID DEL LIBRO (Ver Catálogo)</label>
                        <input type="number" name="idLibro" placeholder="Ej. 1" required>
                    </div>
                    <div class="form-group">
                        <label>CANTIDAD</label>
                        <input type="number" name="cantidad" placeholder="Ej. 2" min="1" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>TOTAL A PAGAR (S/)</label>
                    <input type="number" step="0.01" name="total" placeholder="Ej. 99.80" required>
                </div>
                <button type="submit" class="btn-submit">Registrar Venta en Sistema</button>
            </form>
        </div>

        <div id="historial-ventas" class="tab-content">
            <h2>Historial de Ventas Registradas</h2>
            <p>Registro de transacciones generadas en el sistema.</p>
            <table>
                <thead>
                    <tr>
                        <th>ID VENTA</th>
                        <th>CLIENTE</th>
                        <th>FECHA</th>
                        <th>TOTAL (S/)</th>
                        <th>ESTADO</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (listaVentas != null && !listaVentas.isEmpty()) {
                            for (Venta v : listaVentas) {
                    %>
                    <tr>
                        <td><strong>#<%= v.getIdVenta() %></strong></td>
                        <td><%= v.getCliente() %></td>
                        <td><%= v.getFecha() != null ? v.getFecha().toString() : "Reciente" %></td>
                        <td>S/ <%= String.format("%.2f", v.getTotal()) %></td>
                        <td><span class="badge-status"><%= v.getEstado() != null ? v.getEstado() : "ACTIVA" %></span></td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #888;">No se han registrado ventas aún.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>

    <script>
        function showTab(tabId) {
            const contents = document.querySelectorAll('.tab-content');
            contents.forEach(c => c.classList.remove('active'));

            const buttons = document.querySelectorAll('.tab-btn');
            buttons.forEach(b => b.classList.remove('active'));

            document.getElementById(tabId).classList.add('active');
            event.currentTarget.classList.add('active');
        }
    </script>
</body>
</html>