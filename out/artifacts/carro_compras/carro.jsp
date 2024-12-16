<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="models.*" %>
<%
    Carro carro = (Carro) session.getAttribute("carro");
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carro de Compras</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin-top: 20px;
        }
        .table-container {
            max-width: 900px;
            margin: 0 auto;
        }
    </style>
</head>
<body>

<div class="container table-container">
    <h1 class="text-center">Carro de Compras</h1>

    <% if (carro == null || carro.getItems().isEmpty()) { %>
    <div class="alert alert-warning">
        <p>Lo sentimos, no hay productos en el carro de compras.</p>
    </div>
    <% } else { %>

    <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>ID Producto</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <% for (ItemCarro item : carro.getItems()) { %>
        <tr>
            <td><%= item.getProductos().getIdProducto() %></td>
            <td><%= item.getProductos().getNombre() %></td>
            <td><%= item.getProductos().getPrecio() %></td>
            <td><%= item.getCantidad() %></td>
            <td><%= item.getSbtotal() %></td>
        </tr>
        <% } %>
        <tr class="table-success">
            <td colspan="4" style="text-align: right;"><strong>Total</strong></td>
            <td><%= carro.getTotal() %></td>
        </tr>
        </tbody>
    </table>

    <% } %>

    <div class="text-center">
        <p><a href="<%= request.getContextPath() %>/productos" class="btn btn-info">Seguir Comprando</a></p>
        <p><a href="<%= request.getContextPath() %>/index.html" class="btn btn-primary">Ir al Inicio</a></p>
        <button onclick="window.print();" class="btn btn-secondary">Imprimir Factura</button>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
