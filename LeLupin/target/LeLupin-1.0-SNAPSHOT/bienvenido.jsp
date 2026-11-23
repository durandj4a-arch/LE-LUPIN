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

    String msg = request.getParameter("msg");
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
            max-width: 1120px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            flex: 1;
            width: 95%;
            box-sizing: border-box;
        }
        .alert-banner {
            background-color: #e8f5e9;
            color: #1b5e20;
            border-left: 4px solid #2e7d32;
            padding: 12px 16px;
            border-radius: 4px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .nav-tabs {
            display: flex;
            border-bottom: 2px solid #16221f;
            margin-bottom: 25px;
            gap: 5px;
            flex-wrap: wrap;
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
        /* Barra de filtros */
        .filter-bar {
            display: flex;
            gap: 15px;
            background-color: #f9f7f2;
            padding: 15px;
            border-radius: 6px;
            border: 1px solid #e5e0d5;
            margin-bottom: 18px;
            align-items: flex-end;
            flex-wrap: wrap;
        }
        .filter-item {
            flex: 1;
            min-width: 200px;
        }
        .filter-tags {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }
        .tag-chip {
            background-color: #efece4;
            color: #16221f;
            border: 1px solid #d5cfc2;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s;
        }
        .tag-chip:hover, .tag-chip.active {
            background-color: #16221f;
            color: #f5f2eb;
            border-color: #16221f;
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
            margin-top: 10px;
        }
        th, td {
            padding: 12px 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 0.9rem;
        }
        th {
            background-color: #16221f;
            color: white;
            font-size: 0.8rem;
            letter-spacing: 1px;
        }
        tr:hover {
            background-color: #f9f7f2;
        }
        .badge-stock {
            background-color: #2e7d32;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.78rem;
            font-weight: bold;
            white-space: nowrap;
            display: inline-block;
        }
        .badge-warning {
            background-color: #e65100;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.78rem;
            font-weight: bold;
            white-space: nowrap;
            display: inline-block;
        }
        .badge-danger {
            background-color: #c62828;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.78rem;
            font-weight: bold;
            white-space: nowrap;
            display: inline-block;
        }
        .badge-status {
            background-color: #1565c0;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.78rem;
            font-weight: bold;
            white-space: nowrap;
            display: inline-block;
        }
        .badge-tag {
            background-color: #ece8df;
            color: #16221f;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        /* Botones de acción en tabla */
        .actions-cell {
            display: flex;
            gap: 6px;
            align-items: center;
        }
        .btn-edit {
            background-color: #1565c0;
            color: white;
            border: none;
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 0.78rem;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-edit:hover {
            background-color: #0d47a1;
        }
        .btn-delete {
            background-color: #c62828;
            color: white;
            border: none;
            padding: 6px 10px;
            border-radius: 4px;
            font-size: 0.78rem;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-delete:hover {
            background-color: #8e0000;
        }
        /* Ventanas Modales para Editar */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.55);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-box {
            background: white;
            padding: 25px 30px;
            border-radius: 8px;
            width: 90%;
            max-width: 520px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.25);
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 18px;
        }
        .modal-header h3 {
            margin: 0;
            color: #16221f;
        }
        .close-modal {
            background: none;
            border: none;
            font-size: 1.4rem;
            cursor: pointer;
            color: #666;
        }
    </style>
</head>
<body>

    <header>
        <h1>Le Lupin — Panel de Control</h1>
        <a href="index.jsp?logout=1" class="logout">Cerrar Sesión</a>
    </header>

    <div class="main-container">

        <% if (msg != null && !msg.isEmpty()) { %>
            <div class="alert-banner">✅ <%= msg %></div>
        <% } %>

        <div class="nav-tabs">
            <button class="tab-btn active" onclick="showTab('catalogo', this)">📚 Catálogo de Libros</button>
            <button class="tab-btn" onclick="showTab('registrar-libro', this)">➕ Registrar Nuevo Libro</button>
            <button class="tab-btn" onclick="showTab('registrar-venta', this)">🛒 Registrar Venta</button>
            <button class="tab-btn" onclick="showTab('historial-ventas', this)">📜 Historial de Ventas</button>
        </div>

        <!-- ==================== PESTAÑA 1: CATÁLOGO DE LIBROS ==================== -->
        <div id="catalogo" class="tab-content active">
            <h2>Catálogo de Libros Disponibles</h2>
            <p>Lista de ejemplares registrados en la base de datos de TiDB Cloud. Filtre por etiqueta o busque por título/autor.</p>

            <!-- Chips rápidos de etiquetas -->
            <div class="filter-tags">
                <button type="button" class="tag-chip active" onclick="filtrarPorChip('TODOS', this)">Todos</button>
                <button type="button" class="tag-chip" onclick="filtrarPorChip('Manga', this)">Manga</button>
                <button type="button" class="tag-chip" onclick="filtrarPorChip('Cómic', this)">Cómic</button>
                <button type="button" class="tag-chip" onclick="filtrarPorChip('Novela', this)">Novela</button>
                <button type="button" class="tag-chip" onclick="filtrarPorChip('Drama', this)">Drama</button>
                <button type="button" class="tag-chip" onclick="filtrarPorChip('Sin Género', this)">Sin Género</button>
            </div>

            <!-- Barra de búsqueda combinada -->
            <div class="filter-bar">
                <div class="filter-item">
                    <label>BUSCAR POR TÍTULO, AUTOR O ISBN</label>
                    <input type="text" id="buscadorLibros" onkeyup="filtrarLibros()" placeholder="Ej. Arsène Lupin, Alan Moore, 978...">
                </div>
                <div class="filter-item" style="max-width: 240px;">
                    <label>FILTRAR POR ETIQUETA / GÉNERO</label>
                    <select id="filtroEtiqueta" onchange="filtrarLibros()">
                        <option value="TODOS">Todas las etiquetas</option>
                        <option value="Manga">Manga</option>
                        <option value="Cómic">Cómic</option>
                        <option value="Novela">Novela</option>
                        <option value="Drama">Drama</option>
                        <option value="Sin Género">Sin Género</option>
                    </select>
                </div>
            </div>

            <table id="tablaLibros">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>ISBN</th>
                        <th>TÍTULO</th>
                        <th>AUTOR</th>
                        <th>ETIQUETA</th>
                        <th>PRECIO (S/)</th>
                        <th>STOCK</th>
                        <th>ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (listaLibros != null && !listaLibros.isEmpty()) {
                            for (Libro lib : listaLibros) {
                                String etiquetaActual = (lib.getEtiqueta() != null && !lib.getEtiqueta().trim().isEmpty()) 
                                                        ? lib.getEtiqueta() : "Sin Género";
                    %>
                    <tr data-etiqueta="<%= etiquetaActual %>">
                        <td><strong><%= lib.getIdLibro() %></strong></td>
                        <td><%= lib.getIsbn() %></td>
                        <td><%= lib.getTitulo() %></td>
                        <td><%= lib.getAutor() %></td>
                        <td><span class="badge-tag"><%= etiquetaActual %></span></td>
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
                        <td>
                            <div class="actions-cell">
                                <button type="button" class="btn-edit"
                                    onclick="abrirModalEditarLibro(
                                        '<%= lib.getIdLibro() %>',
                                        '<%= lib.getIsbn().replace("'", "\\'") %>',
                                        '<%= lib.getTitulo().replace("'", "\\'") %>',
                                        '<%= lib.getAutor().replace("'", "\\'") %>',
                                        '<%= etiquetaActual %>',
                                        '<%= lib.getPrecio() %>',
                                        '<%= lib.getStock() %>',
                                        '<%= lib.getStockMinimo() %>'
                                    )">✏️ Editar</button>

                                <form action="SvLibro" method="POST" style="margin:0;"
                                      onsubmit="return confirm('¿Seguro que deseas eliminar el libro «<%= lib.getTitulo().replace("'", "") %>»?');">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idLibro" value="<%= lib.getIdLibro() %>">
                                    <button type="submit" class="btn-delete">🗑️ Borrar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" style="text-align: center; color: #888;">No hay libros registrados en el inventario.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- ==================== PESTAÑA 2: REGISTRAR NUEVO LIBRO ==================== -->
        <div id="registrar-libro" class="tab-content">
            <h2>Registrar Nuevo Libro al Catálogo</h2>
            <p>Ingrese los datos bibliográficos para añadir una obra al inventario.</p>
            <form action="SvLibro" method="POST">
                <input type="hidden" name="accion" value="registrar">
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
                        <input type="number" name="stock" placeholder="Ej. 20" min="0" required>
                    </div>
                    <div class="form-group">
                        <label>STOCK MÍNIMO</label>
                        <input type="number" name="stockMinimo" placeholder="Ej. 3" min="0" required>
                    </div>
                </div>
                <button type="submit" class="btn-submit">Añadir Libro a la Base de Datos</button>
            </form>
        </div>

        <!-- ==================== PESTAÑA 3: REGISTRAR VENTA ==================== -->
        <div id="registrar-venta" class="tab-content">
            <h2>Módulo de Registro de Ventas</h2>
            <p>Complete los datos para procesar una nueva venta y actualizar el stock automáticamente.</p>
            <form action="SvVenta" method="POST">
                <input type="hidden" name="accion" value="registrar">
                <div class="form-group">
                    <label>NOMBRE DEL CLIENTE</label>
                    <input type="text" name="cliente" placeholder="Ej. Juan Pérez" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>SELECCIONAR LIBRO</label>
                        <select name="idLibro" id="selectLibroVenta" onchange="calcularTotalVenta()" required>
                            <option value="" data-precio="0" disabled selected>Seleccione un ejemplar...</option>
                            <% if (listaLibros != null) {
                                for (Libro lib : listaLibros) {
                                    if (lib.getStock() > 0) { %>
                                        <option value="<%= lib.getIdLibro() %>" data-precio="<%= lib.getPrecio() %>">
                                            [ID: <%= lib.getIdLibro() %>] <%= lib.getTitulo() %> — S/ <%= String.format("%.2f", lib.getPrecio()) %> (Disp: <%= lib.getStock() %>)
                                        </option>
                            <%      }
                                }
                            } %>
                        </select>
                    </div>
                    <div class="form-group" style="max-width: 180px;">
                        <label>CANTIDAD</label>
                        <input type="number" name="cantidad" id="cantidadVenta" value="1" min="1" oninput="calcularTotalVenta()" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>TOTAL A PAGAR (S/)</label>
                    <input type="number" step="0.01" name="total" id="totalVenta" placeholder="0.00" required>
                </div>
                <button type="submit" class="btn-submit">Registrar Venta en Sistema</button>
            </form>
        </div>

        <!-- ==================== PESTAÑA 4: HISTORIAL DE VENTAS ==================== -->
        <div id="historial-ventas" class="tab-content">
            <h2>Historial de Ventas Registradas</h2>
            <p>Registro de transacciones generadas en el sistema. Puede modificar o eliminar ventas registradas.</p>

            <div class="filter-bar">
                <div class="filter-item">
                    <label>BUSCAR POR CLIENTE O ID DE VENTA</label>
                    <input type="text" id="buscadorVentas" onkeyup="filtrarVentas()" placeholder="Ej. Juan Pérez, #1...">
                </div>
                <div class="filter-item" style="max-width: 220px;">
                    <label>FILTRAR POR ESTADO</label>
                    <select id="filtroEstadoVenta" onchange="filtrarVentas()">
                        <option value="TODOS">Todos los estados</option>
                        <option value="ACTIVA">ACTIVA</option>
                        <option value="ANULADA">ANULADA</option>
                    </select>
                </div>
            </div>

            <table id="tablaVentas">
                <thead>
                    <tr>
                        <th>ID VENTA</th>
                        <th>CLIENTE</th>
                        <th>FECHA</th>
                        <th>TOTAL (S/)</th>
                        <th>ESTADO</th>
                        <th>ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (listaVentas != null && !listaVentas.isEmpty()) {
                            for (Venta v : listaVentas) {
                                String estadoVenta = v.getEstado() != null ? v.getEstado() : "ACTIVA";
                    %>
                    <tr data-estado="<%= estadoVenta %>">
                        <td><strong>#<%= v.getIdVenta() %></strong></td>
                        <td><%= v.getCliente() %></td>
                        <td><%= v.getFecha() != null ? v.getFecha().toString() : "Reciente" %></td>
                        <td>S/ <%= String.format("%.2f", v.getTotal()) %></td>
                        <td>
                            <span class="<%= "ANULADA".equalsIgnoreCase(estadoVenta) ? "badge-danger" : "badge-status" %>">
                                <%= estadoVenta %>
                            </span>
                        </td>
                        <td>
                            <div class="actions-cell">
                                <button type="button" class="btn-edit"
                                    onclick="abrirModalEditarVenta(
                                        '<%= v.getIdVenta() %>',
                                        '<%= v.getCliente().replace("'", "\\'") %>',
                                        '<%= v.getTotal() %>',
                                        '<%= estadoVenta %>'
                                    )">✏️ Editar</button>

                                <form action="SvVenta" method="POST" style="margin:0;"
                                      onsubmit="return confirm('¿Seguro que deseas eliminar la venta #<%= v.getIdVenta() %>?');">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="idVenta" value="<%= v.getIdVenta() %>">
                                    <button type="submit" class="btn-delete">🗑️ Borrar</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center; color: #888;">No se han registrado ventas aún.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>

    <!-- ==================== MODAL EDITAR LIBRO ==================== -->
    <div id="modalEditarLibro" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>Modificar Libro #<span id="lblIdLibroModal"></span></h3>
                <button type="button" class="close-modal" onclick="cerrarModal('modalEditarLibro')">&times;</button>
            </div>
            <form action="SvLibro" method="POST">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idLibro" id="editIdLibro">

                <div class="form-row">
                    <div class="form-group">
                        <label>ISBN</label>
                        <input type="text" name="isbn" id="editIsbn" required>
                    </div>
                    <div class="form-group">
                        <label>PRECIO (S/)</label>
                        <input type="number" step="0.01" name="precio" id="editPrecio" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>TÍTULO DEL LIBRO</label>
                    <input type="text" name="titulo" id="editTitulo" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>AUTOR</label>
                        <input type="text" name="autor" id="editAutor" required>
                    </div>
                    <div class="form-group">
                        <label>ETIQUETA / GÉNERO</label>
                        <select name="etiqueta" id="editEtiqueta" required>
                            <option value="Manga">Manga</option>
                            <option value="Cómic">Cómic</option>
                            <option value="Drama">Drama</option>
                            <option value="Novela">Novela</option>
                            <option value="Sin Género">Sin Género</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>STOCK ACTUAL</label>
                        <input type="number" name="stock" id="editStock" min="0" required>
                    </div>
                    <div class="form-group">
                        <label>STOCK MÍNIMO</label>
                        <input type="number" name="stockMinimo" id="editStockMinimo" min="0" required>
                    </div>
                </div>
                <button type="submit" class="btn-submit">Guardar Cambios del Libro</button>
            </form>
        </div>
    </div>

    <!-- ==================== MODAL EDITAR VENTA ==================== -->
    <div id="modalEditarVenta" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>Modificar Venta #<span id="lblIdVentaModal"></span></h3>
                <button type="button" class="close-modal" onclick="cerrarModal('modalEditarVenta')">&times;</button>
            </div>
            <form action="SvVenta" method="POST">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="idVenta" id="editIdVenta">

                <div class="form-group">
                    <label>NOMBRE DEL CLIENTE</label>
                    <input type="text" name="cliente" id="editClienteVenta" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>TOTAL (S/)</label>
                        <input type="number" step="0.01" name="total" id="editTotalVenta" required>
                    </div>
                    <div class="form-group">
                        <label>ESTADO DE VENTA</label>
                        <select name="estado" id="editEstadoVenta" required>
                            <option value="ACTIVA">ACTIVA</option>
                            <option value="ANULADA">ANULADA</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn-submit">Guardar Cambios de la Venta</button>
            </form>
        </div>
    </div>

    <script>
        function showTab(tabId, btnElement) {
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));

            document.getElementById(tabId).classList.add('active');
            btnElement.classList.add('active');
        }

        // Filtro por chips de etiqueta
        function filtrarPorChip(etiqueta, chipBtn) {
            document.querySelectorAll('.tag-chip').forEach(c => c.classList.remove('active'));
            chipBtn.classList.add('active');
            document.getElementById('filtroEtiqueta').value = etiqueta;
            filtrarLibros();
        }

        // Filtro combinado de libros (texto + etiqueta)
        function filtrarLibros() {
            const texto = document.getElementById('buscadorLibros').value.toLowerCase();
            const etiquetaSeleccionada = document.getElementById('filtroEtiqueta').value;
            const filas = document.querySelectorAll('#tablaLibros tbody tr');

            filas.forEach(fila => {
                if (fila.cells.length < 2) return;
                const etiquetaFila = fila.getAttribute('data-etiqueta') || 'Sin Género';
                const contenidoFila = fila.textContent.toLowerCase();

                const coincideTexto = contenidoFila.includes(texto);
                const coincideEtiqueta = (etiquetaSeleccionada === 'TODOS') || (etiquetaFila === etiquetaSeleccionada);

                fila.style.display = (coincideTexto && coincideEtiqueta) ? '' : 'none';
            });
        }

        // Filtro de ventas
        function filtrarVentas() {
            const texto = document.getElementById('buscadorVentas').value.toLowerCase();
            const estadoSeleccionado = document.getElementById('filtroEstadoVenta').value;
            const filas = document.querySelectorAll('#tablaVentas tbody tr');

            filas.forEach(fila => {
                if (fila.cells.length < 2) return;
                const estadoFila = fila.getAttribute('data-estado') || 'ACTIVA';
                const contenidoFila = fila.textContent.toLowerCase();

                const coincideTexto = contenidoFila.includes(texto);
                const coincideEstado = (estadoSeleccionado === 'TODOS') || (estadoFila === estadoSeleccionado);

                fila.style.display = (coincideTexto && coincideEstado) ? '' : 'none';
            });
        }

        // Cálculo automático en Registrar Venta
        function calcularTotalVenta() {
            const select = document.getElementById('selectLibroVenta');
            const opcion = select.options[select.selectedIndex];
            const precio = parseFloat(opcion ? opcion.getAttribute('data-precio') : 0) || 0;
            const cantidad = parseInt(document.getElementById('cantidadVenta').value) || 0;
            document.getElementById('totalVenta').value = (precio * cantidad).toFixed(2);
        }

        // Modales
        function abrirModalEditarLibro(id, isbn, titulo, autor, etiqueta, precio, stock, stockMin) {
            document.getElementById('lblIdLibroModal').textContent = id;
            document.getElementById('editIdLibro').value = id;
            document.getElementById('editIsbn').value = isbn;
            document.getElementById('editTitulo').value = titulo;
            document.getElementById('editAutor').value = autor;
            document.getElementById('editEtiqueta').value = etiqueta;
            document.getElementById('editPrecio').value = precio;
            document.getElementById('editStock').value = stock;
            document.getElementById('editStockMinimo').value = stockMin;
            document.getElementById('modalEditarLibro').style.display = 'flex';
        }

        function abrirModalEditarVenta(id, cliente, total, estado) {
            document.getElementById('lblIdVentaModal').textContent = id;
            document.getElementById('editIdVenta').value = id;
            document.getElementById('editClienteVenta').value = cliente;
            document.getElementById('editTotalVenta').value = total;
            document.getElementById('editEstadoVenta').value = estado;
            document.getElementById('modalEditarVenta').style.display = 'flex';
        }

        function cerrarModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        window.onclick = function(e) {
            if (e.target.classList.contains('modal-overlay')) {
                e.target.style.display = 'none';
            }
        }
    </script>
</body>
</html>