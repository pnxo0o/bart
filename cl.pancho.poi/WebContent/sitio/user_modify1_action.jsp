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
	<title>Modificar Contraseña - Gestor POI</title>
</head>
<body>
<%
	try { 
		if(session.getAttribute("iduser").equals("") || session.getAttribute("user").equals("") || session.getAttribute("pass").equals("")) response.sendRedirect("logout.jsp");
	} 
	catch(NullPointerException e){ 
		response.sendRedirect("logout.jsp");
	}
	
	String iduser = (String)session.getAttribute("iduser");
	String pass = (String)session.getAttribute("pass");
	String old1 = (String)request.getParameter("oldpass");
	String new1 = (String)request.getParameter("newpass1");
	String new2 = (String)request.getParameter("newpass2");
	
	
	if(pass.equals(old1)){
		if(new1.equals(new2)){
	ClientUsuario w = new ClientUsuario();
	if(w.modificarContrasena(iduser, new1) == 1){
		response.sendRedirect("user_modify1_ok.jsp");
	}
	else{
		response.sendRedirect("user_modify1_nok.jsp");
	}
		}
		else{
	response.sendRedirect("user_modify1_nok.jsp");
		}
	}
	else{
		response.sendRedirect("user_modify1_nok.jsp");
	}
	
//	if(session.getAttribute("pass").equals(old1) && new1.equals(new2)){
//	    ClientUsuario w = new ClientUsuario();
//		if(w.insertarNuevaContrasena((String)session.getAttribute("iduser"), new1) == 1){
//			response.sendRedirect("logout.jsp");
//		}
//		else{
//		response.sendRedirect("user_modify1_nok.jsp");	
//		}
//	}
//	else
//	{
//		response.sendRedirect("user_modify1_nok.jsp");
//	}
%>

</body>
</html>