<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cl.rojasycia.gpoi.data.ClientUsuario"%>
<%@ page import="cl.rojasycia.gpoi.model.Usuario;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Añadir Usuario - Gestor POI</title>
</head>
<body>
<%
	try { 
		if(session.getAttribute("iduser").equals("") || session.getAttribute("user").equals("") || session.getAttribute("pass").equals("")) response.sendRedirect("logout.jsp");
	} 
	catch(NullPointerException e){ 
		response.sendRedirect("logout.jsp");
	}
    ClientUsuario w = new ClientUsuario();
	if(w.insertarNuevoUsuario((String)request.getParameter("idusuario"), (String)request.getParameter("nombreusuario"), (String)request.getParameter("passusuario"))==1){
		response.sendRedirect("user_add_ok.jsp");	
	}
	else{
	response.sendRedirect("user_add_nok.jsp");	
	}
 %>

</body>
</html>