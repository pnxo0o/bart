<!--Francisco Rojas-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Agrega Usuario - Gestor POI</title>
	<link href="main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	function validardatos(formObj) {

        if ( (formObj.idusuario.value) == "") { 
        	alert ("No indicó el identificador del nuevo usuario");
        	return false;
        }
        
        if ( (formObj.nombreusuario.value) == "") { 
            alert ("No indicó el nombre del nuevo usuario");
            return false;
        }
        
        if ( (formObj.passusuario.value) == "") { 
            alert ("No indicó la contraseña del nuevo usuario");
            return false;
        }

    }
	
	</script>
</head>
<body>
<% 
try { 
	if(session.getAttribute("iduser").equals("") || session.getAttribute("user").equals("") || session.getAttribute("pass").equals("")) response.sendRedirect("logout.jsp");
} 
catch(NullPointerException e){ 
	response.sendRedirect("logout.jsp");
}
%>
<center>
<div id="header">
	<div id="head1">
		<img src="./resources/icono.png"  width="130" height="130">
	</div>
	<div id="head2">
		<div id="headtexto1">
		<h1>Gestor de Puntos de Interés</h1> <br/>
		Hola!  <%= session.getAttribute("user")%>
		</div>
	</div>
</div>
<div id="menu">
<ul class="nav">
	<li>
		<a href="index.jsp">Inicio<span class="flecha">&#9660;</span></a>
	</li>
	<li>
		<a href="#">Puntos de Interés<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="poi_add.jsp">Añadir Punto de Interés<span class="flecha">&#9660;</span></a></li>
			<li><a href="poi_modify.jsp">Modificar Punto de Interés<span class="flecha">&#9660;</span></a></li>
			<li><a href="poi_delete.jsp">Eliminar Punto de Interés<span class="flecha">&#9660;</span></a></li>
		</ul>
	</li>
	<li>
		<a href="#">Usuarios<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="#">Añadir Usuario<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_modify1.jsp">Modificar Mi Contraseña<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_modify2.jsp">Modificar Mi Nombre<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_delete.jsp">Eliminar Mi Usuario<span class="flecha">&#9660;</span></a></li>
		</ul>
	</li>
	<li>
		<a href="logout.jsp">Cerrar Sesión<span class="flecha">&#9660;</span></a>
	</li>
</ul>
</div>
<div id="main">
	<div id="main3">
		<h2>Añadir Nuevo Usuario</h2>
		Llene el formulario con los siguientes datos y cree un nuevo administrador para el sistema:
		<br/>
		<br>
		<form action="user_add_action.jsp" method="post" onsubmit="return validardatos(this);">
		<table border="0" align="center">
		<tr>
			<td>Id. Usuario:</td>
			<td><input type="text" id="idusuario" name="idusuario" maxlength="8"></td>
		</tr>
		<tr>
			<td>Nombre de Usuario:</td>
			<td><input type="text" id="nombreusuario" name="nombreusuario"></td>
		</tr>
		<tr>
			<td>Contraseña:</td>
			<td><input type="password" id="passusuario" name="passusuario" maxlength="8"></td>
		</tr>
		</table>
		<p><input type="submit" value="Añadir Nuevo Usuario"></p>
	</form>
	</div>
</div>
<div id="footer">
<div id="textoplomo">
<br> Creado por Francisco Rojas <br>
</div>
</div>
</center>
</body>
</html>
