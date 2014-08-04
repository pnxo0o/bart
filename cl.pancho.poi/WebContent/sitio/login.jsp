<!--Francisco Rojas-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cl.rojasycia.gpoi.data.DownloadUsuario"%>
<%@ page import="cl.rojasycia.gpoi.model.Usuario;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
<% 
	int i = 0;
	String iduser = request.getParameter("iduser");
	String pass = request.getParameter("pass");
	String user = null;
	DownloadUsuario us = new DownloadUsuario();
	List<Usuario> listP =us.setPOIDescargados();
	Iterator<Usuario> iterador = listP.listIterator();
	while( iterador.hasNext() ) {
		Usuario p = (Usuario) iterador.next();
		if(iduser.equals(p.getIdUsuario()) && pass.equals(p.getPassUsuario())){
			i=1;
			user=p.getNombreUsuario();
		}
	}
	if (i==1){
		session.setAttribute("iduser",iduser);
		session.setAttribute("user",user);
		session.setAttribute("pass",pass);
		response.sendRedirect("index.jsp");
	}
	else{
	response.sendRedirect("error.jsp");	
	}
%>
</body>
</html>