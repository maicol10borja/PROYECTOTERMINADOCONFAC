<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*,models.*" %>
<%
    List<Productos> productos = (List<Productos>) request.getAttribute("productos");
    Optional<String> username = (Optional<String>) request.getAttribute("username");
    String role = (String) request.getSession().getAttribute("role"); // Obtener el rol del usuario desde la sesión
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Productos</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Tus estilos actuales */
        body {
            background-color: #eef2f7;
            font-family: 'Arial', sans-serif;
            color: #444;
            padding-top: 30px;
        }
        h1 {
            font-size: 2.5rem;
            color: #4CAF50;
            text-align: center;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
        }
        .alert {
            background-color: #27ae60;
            color: white;
            border-radius: 5px;
            padding: 12px;
            font-size: 1.3rem;
            font-weight: bold;
        }
        .table {
            margin-top: 30px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-collapse: separate;
            border-spacing: 0;
        }
        .thead-dark {
            background-color: #2980b9;
            color: white;
        }
        .table td, .table th {
            text-align: center;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .table a {
            font-size: 1rem;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            margin: 5px;
            transition: background-color 0.3s ease;
        }
        .table .btn-success {
            background-color: #2ecc71;
            border-color: #2ecc71;
        }
        .table .btn-warning {
            background-color: #f39c12;
            border-color: #f39c12;
        }
        .table .btn-danger {
            background-color: #e74c3c;
            border-color: #e74c3c;
        }
        .table .btn:hover {
            opacity: 0.85;
        }
        .container {
            width: 85%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }
        .btn-primary {
            background-color: #2980b9;
            border-color: #2980b9;
            font-size: 1rem;
            padding: 12px 25px;
        }
        .btn-primary:hover {
            background-color: #1f6d97;
            border-color: #1f6d97;
        }
        .btn-warning {
            background-color: #f39c12;
            border-color: #f39c12;
        }
        .btn-warning:hover {
            background-color: #e67e22;
            border-color: #e67e22;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Listado de Productos del Restaurante</h1>

    <% if(username.isPresent()) { %>
    <div class="alert">
        Hola <%= username.get() %>, bienvenido a la aplicación!
    </div>
    <% if ("admin".equals(role)) { %>
    <div><p><a href="${pageContext.request.contextPath}/productos/form" class="btn btn-primary">Ingrese el producto</a></p></div>
    <% } %>
    <% } %>

    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>ID PRODUCTO</th>
            <th>NOMBRE PRODUCTO</th>
            <th>CATEGORIA</th>
            <% if(username.isPresent()) { %>
            <th>STOCK</th>
            <th>PRECIO</th>
            <th>OPCIONES</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <%
            for (Productos p: productos) {
        %>
        <tr>
            <td><%= p.getIdProducto() %></td>
            <td><%= p.getNombre() %></td>
            <td><%= p.getCategoria().getNombre() %></td>
            <% if(username.isPresent()) { %>
            <td><%= p.getStock() %></td>
            <td><%= p.getPrecio() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/agregar-carro?idProducto=<%= p.getIdProducto() %>" class="btn btn-success btn-sm">Agregar</a>
                <% if ("admin".equals(role)) { %>
                <a href="<%= request.getContextPath() %>/productos/form?idProducto=<%= p.getIdProducto() %>" class="btn btn-warning btn-sm">Editar</a>
                <% } %>
            </td>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
    <div><p><a href="${pageContext.request.contextPath}/index.html" class="btn btn-warning">Volver</a></p></div>

</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>