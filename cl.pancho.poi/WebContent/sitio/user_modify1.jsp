<!--Francisco Rojas-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Modificar Contrase�a - Gestor POI</title>
	<link href="main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	function validardatos(formObj) {

        if ( (formObj.oldpass.value) == "") { 
        	alert ("No indic� su contrase�a");
        	return false;
        }
        
        if ( (formObj.newpass1.value) == "") { 
            alert ("No indic� la nueva contrase�a");
            return false;
        }
        
        if ( (formObj.newpass2.value) == "") { 
            alert ("No repiti� la nueva contrase�a");
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
		<h1>Gestor de Puntos de Inter�s</h1> <br/>
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
		<a href="#">Puntos de Inter�s<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="poi_add.jsp">A�adir Punto de Inter�s<span class="flecha">&#9660;</span></a></li>
			<li><a href="poi_modify.jsp">Modificar Punto de Inter�s<span class="flecha">&#9660;</span></a></li>
			<li><a href="poi_delete.jsp">Eliminar Punto de Inter�s<span class="flecha">&#9660;</span></a></li>
		</ul>
	</li>
	<li>
		<a href="#">Usuarios<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="user_add.jsp">A�adir Usuario<span class="flecha">&#9660;</span></a></li>
			<li><a href="#">Modificar Mi Contrase�a<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_modify2.jsp">Modificar Mi Nombre<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_delete.jsp">Eliminar Mi Usuario<span class="flecha">&#9660;</span></a></li>
		</ul>
	</li>
	<li>
		<a href="logout.jsp">Cerrar Sesi�n<span class="flecha">&#9660;</span></a>
	</li>
</ul>
</div>
<div id="main">
	<div id="main3">
	<form action="user_modify1_action.jsp" method="post" onsubmit="return validardatos(this);">
		<h2>Modificar Mi Contrase�a</h2>
		Ingrese su nueva contrase�a desde aqu�, con el resultado satisfactorio ser� desconectado del sistema:
		<br/>
		<br>
		<table border="0" align="center">
		<tr>
			<td>Antigua Contrase�a:</td>
			<td><input type="password" id="oldpass" name="oldpass" maxlength="8"></td>
		</tr>
		<tr>
			<td>Nueva Contrase�a:</td>
			<td><input type="password" id="newpass1" name="newpass1" maxlength="8"></td>
		</tr>
		<tr>
			<td>Reingrese Nueva Contrase�a:</td>
			<td><input type="password" id="newpass2" name="newpass2" maxlength="8"></td>
		</tr>
		</table>
		<p><input type="submit" value="Modificar Mi Contrase�a"></p>
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
