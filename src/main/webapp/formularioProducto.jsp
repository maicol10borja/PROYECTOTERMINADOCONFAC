<%--
  Created by IntelliJ IDEA.
  User: ADMIN-ITQ
  Date: 6/12/2024
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, models.*" %>
<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
%>
<html>

<head>
    <title>Ingreso de Productos</title>
</head>
<body>

<h1>FORMULARIO PRODUCTOS</h1>
<div>
    <form action="<%=request.getContextPath()%>/productos/form" method="post">
        <div>
            <label for="nombre">Ingrese el nombre del producto:</label>
            <div>
                <input type="text" id="nombre" name="nombre">
            </div>
        </div>
        <div>
            <label for="categoria">Ingrese la categoria</label>
            <div>
                <select name="categoria" id="categoria">
                    <option value="">---Seleccione una Categoria---</option>
                    <%for (Categoria c : categorias) {%>
                    <option value="<%=c.getIdCategoria()%>"><%=c.getNombre()%></option>
                    <%}%>
                </select>
            </div>
        </div>
        <div>
            <label for="precio">Ingrese el precio</label>
            <div>
                <input type="number" name="precio" id="precio" step="0.01">
            </div>
        </div>
        <div>
            <input type="submit" value="ENVIAR">
        </div>
    </form>
</div>
</body>
</html>