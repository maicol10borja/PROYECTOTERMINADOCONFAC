<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*,models.*" %>
<%
  List<Categoria> categorias = (List<Categoria>) request.getAttribute("categoria");

  // Obtener los atributos 'username' y 'role' de la solicitud y la sesión
  Optional<String> username = (Optional<String>) request.getAttribute("username");
  String role = (String) request.getSession().getAttribute("role"); // Verificar que el rol esté en la sesión

  // Si el 'role' es null o vacío, asignamos un valor predeterminado para evitar errores
  if (role == null) {
    role = "usuario"; // Valor predeterminado si no está configurado
  }
%>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lista de Categorías</title>
  <!-- Vincula Bootstrap desde un CDN -->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
  <!-- Estilos adicionales si son necesarios -->
  <style>
    body {
      margin-top: 20px;
    }
    table {
      margin-top: 20px;
    }
  </style>
</head>
<body>

<div class="container">
  <h1 class="text-center">Listado de Categorías</h1>

  <%
    // Verificar si username no es null y está presente
    if (username != null && username.isPresent()) {
  %>
  <div class="alert alert-info">
    Hola <%= username.get() %>, bienvenido a la sección de categorías.
  </div>
  <%
    }
  %>

  <table class="table table-bordered table-striped">
    <thead class="thead-dark">
    <tr>
      <th>ID PEDIDO </th>
      <th>NOMBRE PEDIDO</th>
      <th>ESTADO</th>
      <% if ("admin".equals(role)) { %>  <!-- Solo muestra la columna Opciones para admin -->
      <th>OPCIONES</th>
      <% } %>
    </tr>
    </thead>
    <tbody>
    <%
      for (Categoria p: categorias) {
    %>
    <tr>
      <td><%= p.getIdCategoria() %></td>
      <td><%= p.getNombre() %></td>
      <td>
        <%
          // Mostrar "Activo" si el estado es 1, de lo contrario "Inactivo"
          String estadoTexto = (p.getEstado() == 1) ? "Activo" : "Inactivo";
        %>
        <%= estadoTexto %>
      </td>

      <% if ("admin".equals(role)) { %>  <!-- Solo muestra los botones si el usuario es admin -->
      <td>
        <a href="<%= request.getContextPath() %>/categoria/form?idCategoria=<%= p.getIdCategoria() %>" class="btn btn-warning btn-sm">Editar</a>
        <a href="<%= request.getContextPath() %>/categoria/eliminar?idCategoria=<%= p.getIdCategoria() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de cambiar el estado de esta Categoria?');">Cambiar Estado</a>
      </td>
      <% } %>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>

  <div><p><a href="${pageContext.request.contextPath}/index.html" class="btn btn-warning">Volver</a></p></div>

</div>

<!-- Vincula los scripts de Bootstrap para funcionalidades como los botones (opcional) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
