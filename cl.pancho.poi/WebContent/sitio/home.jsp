<!--Francisco Rojas-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Gestor POI</title>
	<link href="main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	
    
    function validardatos(formObj) {

        if ( (formObj.iduser.value) == "") { 
        	alert ("No indicó su nombre de usuario");
        	return false;
        }
        
        if ( (formObj.pass.value) == "") { 
            alert ("No indicó su contraseña");
            return false;
        }
        
    }
	</script>
</head>
<body>
<center>
<div id="header">
	<div id="head1">
		<img src="./resources/icono.png"  width="130" height="130">
	</div>
	<div id="head2">
		<div id="headtexto1">
		<h1>Gestor de Puntos de Interés</h1> <br/>
		</div>
	</div>
</div>
<div id="main">
	<div id="main3">
		<h2>Inicio de Sesión</h2>
		<form action="login.jsp" method="post" onsubmit="return validardatos(this);">
		<table border="0" align="center">
		<tr>
			<td>Usuario:</td>
			<td><input type="text" id="iduser" name="iduser" maxlength="8"></td>
		</tr>
		<tr>
			<td>Contraseña:</td> 
			<td><input type="password" id="pass" name="pass" maxlength="8"></td>
		</tr>
		</table>
		<p><input type="submit" value="Ingresar"></p>
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