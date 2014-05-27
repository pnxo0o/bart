<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="cl.rojasycia.gpoi.data.DownloadPOI"%>
<%@ page import="cl.rojasycia.gpoi.model.Poi;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<link href="default.css" rel="stylesheet" type="text/css" media="all" />
	<link href="fonts.css" rel="stylesheet" type="text/css" media="all" />
</head>
<body>
<%
	out.println("hola");
    DownloadPOI x = new DownloadPOI();
    List<Poi> listP =x.setPOIDescargados();
    Iterator<Poi> iterador = listP.listIterator();
    while( iterador.hasNext() ) {
        Poi p = (Poi) iterador.next();
        out.println(""+p.getNombre());
    }
%>

</body>
</html>