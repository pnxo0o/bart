<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cl.rojasycia.gpoi.data.InsertPOI"%>
<%@ page import="cl.rojasycia.gpoi.model.Poi;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Resultado de Ingreso POI</title>
<style type="text/css" media="screen">
	  /*la directiva include copia el contenido de un archivo y lo incrusta en la pagina*/

</style>
</head>
<% if(session.getAttribute("name")==null || session.getAttribute("name").equals("")) response.sendRedirect("logout.jsp");%>
<body>
<%
   /*podemos leer los datos del request a una variable*/
   InsertPOI w = new InsertPOI((String)request.getParameter("nombre"), (String)request.getParameter("tipo"),(String)request.getParameter("lat"),(String)request.getParameter("lon"));
   String lon=(String)request.getParameter("lon");
   String nombre=(String)request.getParameter("nombre");
   String tipo=(String)request.getParameter("tipo");
   
   out.print("<br/>");
   out.print("latitud: "+request.getParameter("lat"));
   out.print("<br/>");
   out.print("latitud: "+lon);
   out.print("<br/>");
   out.print("tu lenguaje favorito es "+nombre);
   out.print("<br/>");
   out.print("y prefieres el(a) "+tipo);
   out.print("<br/>");

 %>

</body>
</html>