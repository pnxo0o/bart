<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modificar Contraseņa - Gestor POI</title>
<script type="text/javascript">
function load()
{
alert("Contraseņa incorrecta");
}
</script>
</head>
<body onload="load()">
<%
	getServletContext().getRequestDispatcher("/sitio/user_delete.jsp").include(request, response);
%>
</body>
</html>