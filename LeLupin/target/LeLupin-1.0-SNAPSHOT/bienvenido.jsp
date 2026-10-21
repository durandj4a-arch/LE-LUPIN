<%-- 
    Document   : bienvenido
    Created on : 7 oct. 2026, 11:53:10 p. m.
    Author     : Joshua
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Le Lupin - Panel de Ventas e Inventario</title>
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
            max-width: 900px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            flex: 1;
            width: 100%;
            box-sizing: border-box;
        }
        h2 {
            font-family: serif;
            border-bottom: 2px solid #16221f;
            padding-bottom: 10px;
            margin-top: 0;
            color: #16221f;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-size: 0.8rem;
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
            font-size: 1rem;
            box-sizing: border-box;
        }
        button {
            background-color: #16221f;
            color: white;
            border: none;
            padding: 12px 20px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 4px;
            letter-spacing: 1px;
            width: 100%;
            transition: background 0.2s;
        }
        button:hover {
            background-color: #2b3d38;
        }
        .success-msg {
            background-color: #e2f0d9;
            color: #385723;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #b7e1cd;
        }
    </style>
</head>
<body>

    <header>
        <h1>Le Lupin — Panel de Control</h1>
        <a href="index.jsp" class="logout">Cerrar Sesión</a>
    </header>

    <div class="main-container">
        <h2>Módulo de Registro de Ventas (Cabecera y Detalle)</h2>
        <p>Complete los datos para procesar una nueva venta de libros y actualizar el stock en TiDB Cloud.</p>

        <!-- Formulario que conecta con un Servlet o lógica de procesamiento -->
        <form action="SvVenta" method="POST">
            <div class="form-group">
                <label>NOMBRE DEL CLIENTE</label>
                <input type="text" name="cliente" placeholder="Ej. Juan Pérez" required>
            </div>

            <div class="form-group">
                <label>ID DEL LIBRO (Catálogo)</label>
                <input type="number" name="idLibro" placeholder="Ej. 1" required>
            </div>

            <div class="form-group">
                <label>CANTIDAD</label>
                <input type="number" name="cantidad" placeholder="Ej. 2" min="1" required>
            </div>

            <div class="form-group">
                <label>SUBTOTAL / TOTAL A PAGAR (S/)</label>
                <input type="number" step="0.01" name="total" placeholder="Ej. 45.00" required>
            </div>

            <button type="submit">Registrar Venta en Sistema</button>
        </form>
    </div>

</body>
</html>