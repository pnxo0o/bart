<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Inicio</title>
	<link href="default.css" rel="stylesheet" type="text/css" media="all" />
	<link href="fonts.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
	<div id="header-wrapper">
	<div id="header" class="container">
		<div id="logo">
			<h1><a href="#">Gestor de POI's</a></h1>
		</div>
	</div>
	<div id="welcome">
	<div class="container">
		<div class="title">
			<h2>Inicio de Sesión</h2>
		</div>
		<form method="post" action="login.jsp">
			<table border="0" align="center">
			<tr>
				<td>Usuario:</td>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<td>Contraseña:</td>
				<td><input type="password" name="password"/></td>
			</tr>
			</table>
			<ul class="actions">
				<li><input type="submit" class="button" value="Ingresar"/></li>
			</ul>
		</form>
	</div>
</div>
	
	</div>
	<div id="copyright" class="container">
	<p>© Untitled. All rights reserved. | Photos by <a href="http://fotogrph.com/">Fotogrph</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div>
</body>
</html>