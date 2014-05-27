<html>
<head>
<title>HOLA FORMULARIOS</title>
<style type="text/css" media="screen">
	  /*la directiva include copia el contenido de un archivo y lo incrusta en la pagina*/

</style>
</head>
<body>

<%
   /*podemos leer los datos del request a una variable*/
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