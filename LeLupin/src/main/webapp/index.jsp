<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Le Lupin - Iniciar Sesión</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f2eb;
            color: #1a1a1a;
            height: 100vh;
            display: flex;
        }

        .page-container {
            display: flex;
            width: 100%;
            height: 100vh;
        }

        .left-column {
            background-color: #16221f; /* Verde oscuro elegante */
            width: 50%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            padding: 40px;
            box-sizing: border-box;
        }

        .image-box {
            position: relative;
            width: 440px;
            height: 440px;
            margin-bottom: 25px;
        }

        .img-libros {
            width: 370px;
            height: 350px;
            object-fit: cover;
            border-radius: 10px;
            position: absolute;
            top: 0;
            left: 0;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6);
            transition: transform 0.3s ease;
        }

        .img-lupin {
            width: 190px;
            height: auto;
            object-fit: cover;
            position: absolute;
            bottom: 0px;
            right: 0px;
            border: 4px solid #16221f;
            border-radius: 8px;
            background-color: #16221f;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.7);
            z-index: 2;
        }

        .quote {
            color: #f5f2eb;
            font-style: italic;
            font-family: 'Georgia', serif;
            font-size: 1.15rem;
            max-width: 420px;
            text-align: left;
            border-left: 2px solid #e2d9c8;
            padding-left: 18px;
            line-height: 1.5;
            opacity: 0.9;
        }

        .right-column {
            width: 50%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #f5f2eb;
        }

        .login-container {
            width: 350px;
        }

        h2 {
            font-family: serif;
            font-size: 2.5rem;
            margin-bottom: 5px;
        }

        p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 30px;
        }

        label {
            font-size: 0.7rem;
            font-weight: bold;
            letter-spacing: 1.5px;
            color: #444;
        }

        input {
            width: 100%;
            padding: 10px 0;
            margin: 8px 0 25px 0;
            border: none;
            border-bottom: 1px solid #999;
            background: transparent;
            font-size: 1rem;
            outline: none;
        }

        input:focus {
            border-bottom: 2px solid #000;
        }

        button {
            width: 100%;
            background-color: #1a1a1a;
            color: white;
            border: none;
            padding: 14px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            letter-spacing: 1px;
            transition: background 0.2s;
        }

        button:hover {
            background-color: #333;
        }
    </style>
</head>
<body>

    <div class="page-container">

        <div class="left-column">
            <div class="image-box">
                <img src="${pageContext.request.contextPath}/images/libros.jpg" alt="Libros antiguos" class="img-libros">
                <img src="${pageContext.request.contextPath}/images/lupin.jpg" alt="Le Lupin" class="img-lupin">
            </div>
            <div class="quote">
                "¡Qué viaje tan extraño! Sin embargo había comenzado tan bien."
            </div>
        </div>

        <div class="right-column">
            <div class="login-container">
                <span style="font-size: 0.7rem; letter-spacing: 2px; color: #777; font-weight: bold;">ÁREA DE VENDEDORES</span>
                <h2>Bienvenido</h2>
                <p>Inicia sesión para volver a tus libros.</p>
                

                <form action="SvLogin" method="POST">
                    <label>USUARIO</label><br>
                    <!-- Cambiado a type="text" y name="username" para calzar con la BD -->
                    <input type="text" name="username" placeholder="admin" value="admin" required><br>
                    
                    <label>CONTRASEÑA</label><br>
                    <input type="password" name="password" placeholder="********" value="123456" required><br>
                    
                    <button type="submit">Entrar</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>