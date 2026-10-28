<%-- 
    Document   : bienvenido
    Created on : 7 oct. 2026, 11:53:10 p. m.
    Author     : Joshua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            max-width: 950px;
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
        }
        .tab-btn {
            background: none;
            border: none;
            padding: 12px 24px;
            font-size: 0.95rem;
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
                    <tr>
                        <td><strong>1</strong></td>
                        <td>978-8420653281</td>
                        <td>Arsène Lupin, caballero ladrón</td>
                        <td>Maurice Leblanc</td>
                        <td>Novela</td>
                        <td>S/ 49.90</td>
                        <td><span class="badge-stock">15 un.</span></td>
                    </tr>
                    <tr>
                        <td><strong>2</strong></td>
                        <td>978-8499890982</td>
                        <td>La naranja mecánica</td>
                        <td>Anthony Burgess</td>
                        <td>Novela</td>
                        <td>S/ 42.50</td>
                        <td><span class="badge-stock">10 un.</span></td>
                    </tr>
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
                            <option value="manga">Manga</option>
                            <option value="comic">Cómic</option>
                            <option value="drama">Drama</option>
                            <option value="novela">Novela</option>
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
            <h2>Módulo de Registro de Ventas (Cabecera y Detalle)</h2>
            <p>Complete los datos para procesar una nueva venta y emitir la transacción.</p>
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