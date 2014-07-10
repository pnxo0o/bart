<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cl.rojasycia.gpoi.data.ModifyPOI"%>
<%@ page import="cl.rojasycia.gpoi.model.Poi;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>HOLA FORMULARIOS</title>
<style type="text/css" media="screen">
	  /*la directiva include copia el contenido de un archivo y lo incrusta en la pagina*/

</style>
</head>
<% if(session.getAttribute("name")==null || session.getAttribute("name").equals("")) response.sendRedirect("logout.jsp");%>
<body>
<%
   /*podemos leer los datos del request a una variable*/

 ModifyPOI w = new ModifyPOI((String)request.getParameter("id"), (String)request.getParameter("nombre"), (String)request.getParameter("ctipo"),(String)request.getParameter("lat"),(String)request.getParameter("lon"),(String)request.getParameter("optionpoi"));
String lon=(String)request.getParameter("lon");
String nombre=(String)request.getParameter("nombre");
String tipo=(String)request.getParameter("ctipo");
out.print("<br/>");
out.print("latitud: "+request.getParameter("lat"));
out.print("<br/>");
out.print("latitud: "+lon);
out.print("<br/>");
out.print("nombre "+nombre);
out.print("<br/>");
out.print("tipo "+tipo);
out.print("tipo "+request.getParameter("optionpoi"));
out.print("<br/>");
 %>

</body>
</html>