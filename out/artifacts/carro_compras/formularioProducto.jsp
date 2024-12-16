<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, models.*" %>
<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    Productos productos = (Productos) request.getAttribute("productos");
%>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingreso de Productos</title>
    <!-- Vincula Bootstrap desde un CDN -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <!-- Estilos adicionales -->
    <style>
        body {
            margin-top: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>

<body>

<div class="container form-container">
    <h1 class="text-center">Formulario de el Restaurante - Local</h1>
    <form action="<%=request.getContextPath()%>/productos/form" method="post">
        <div class="form-group">
            <label for="nombre">Ingrese el nombre del producto que desea ingresar:</label>
            <input type="hidden" name="idProducto" value="<%=productos.getIdProducto()%>">
            <input type="text" id="nombre" name="nombre" class="form-control" value="<%=productos.getNombre() != null ? productos.getNombre() : ""%>" required>
        </div>

        <div class="form-group">
            <label for="categoria">Ingrese la categoria:</label>
            <select name="categoria" id="categoria" class="form-control" required>
                <option value="">---Seleccione una Categoria---</option>
                <% for (Categoria c : categorias) {
                    if (c.getEstado() != 0) { %> <!-- Solo mostrar categorías con estado diferente a 0 -->
                <option value="<%=c.getIdCategoria()%>" <%= c.getIdCategoria().equals(productos.getCategoria().getIdCategoria()) ? "selected" : "" %>><%= c.getNombre() %></option>
                <% }} %>
            </select>
        </div>

        <div class="form-group">
            <label for="stock">Ingrese el stock del producto:</label>
            <input type="number" name="stock" id="stock" class="form-control" value="<%= productos.getStock() > 0 ? productos.getStock() : "" %>" required>
        </div>

        <div class="form-group">
            <label for="precio">Ingrese el precio:</label>
            <input type="number" name="precio" id="precio" class="form-control" step="0.01" value="<%= productos.getPrecio() != 0 ? productos.getPrecio() : "" %>" required>
        </div>

        <div class="form-group text-center">
            <input type="submit" value="ENVIAR" class="btn btn-primary">
        </div>
    </form>
</div>

<!-- Vincula los scripts de Bootstrap (opcional para funcionalidades dinámicas) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
