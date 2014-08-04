<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cl.rojasycia.gpoi.data.ClientPoi;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Modificar POI - Gestor POI</title>
</head>
<body>
<%
try { 
	if(session.getAttribute("iduser").equals("") || session.getAttribute("user").equals("") || session.getAttribute("pass").equals("")) response.sendRedirect("logout.jsp");
	} 
	catch(NullPointerException e){ 
	response.sendRedirect("logout.jsp");
	}
	ClientPoi w = new ClientPoi();
	if(w.modificarPoi((String)request.getParameter("lugar"), (String)request.getParameter("nombre"), (String)request.getParameter("ntipo"),(String)request.getParameter("lat"),(String)request.getParameter("lon"))==1){
		response.sendRedirect("poi_modify_ok.jsp");	
	}
	else{
	response.sendRedirect("poi_modify_nok.jsp");	
	}

 %>

</body>
</html>