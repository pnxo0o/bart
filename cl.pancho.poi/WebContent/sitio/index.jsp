<!--Francisco Rojas-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Inicio - Gestor POI</title>
	<link href="main.css" rel="stylesheet" type="text/css" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
	<script type="text/javascript">
		var map;
		var marker;
		
    	function initialize() {
        var mapOptions = {
            zoom: 10,
            center: new google.maps.LatLng(-32.9999, -71.474)
        	};
        	map = new google.maps.Map(document.getElementById('map-canvas'),
        	                        mapOptions);
        
        	google.maps.event.addListener(map, 'click', function(event) {
        		document.getElementById('textlat').value = event.latLng.lat();
        		document.getElementById('textlon').value = event.latLng.lng();
                placeMarker(event.latLng);
            });
        	
        	function placeMarker(location) {
        		if (marker == undefined){
                    marker = new google.maps.Marker({
                        position: location,
                        map: map,
                        animation: google.maps.Animation.DROP,
                    });
                }
                else{
                    marker.setPosition(location);
                }
                map.setCenter(location);
            }
    	}
    	

		google.maps.event.addDomListener(window, 'load', initialize);
		
	
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/cl.rojasycia.tserviciosweb/rest/servicio/",
                dataType: "xml",
                success: function (xml) {                   
                    $(xml).find('poi').each(function () {
                        var nombre = $(this).find('nombre').text();
                        var latitud = $(this).find('latitud').text();
                        var longitud = $(this).find('longitud').text();
                        var myLatLng = new google.maps.LatLng(latitud, longitud);
                        var marker = new google.maps.Marker({
                            position: myLatLng,
                            map: map,
                            title: nombre
                        });
                        marker.info = new google.maps.InfoWindow({
                  		  content: nombre 
                  		});
                        google.maps.event.addListener(marker, 'click', function() {
                  		  marker.info.open(map, marker);
                  		});
                    });
                },
                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        });

        
      </script>
</head>
<body>
<% 
try 
{ 
if(session.getAttribute("iduser").equals("") || session.getAttribute("user").equals("") || session.getAttribute("pass").equals("")) response.sendRedirect("logout.jsp");
} 
catch(NullPointerException e){ 
response.sendRedirect("logout.jsp");
}
%>
<center>
<div id="header">
	<div id="head1">
		<img src="./resources/icono.png"  width="130" height="130">
	</div>
	<div id="head2">
		<div id="headtexto1">
		<h1>Gestor de Puntos de Interés</h1> <br/>
		Hola!  <%= session.getAttribute("user")%>
		</div>
	</div>
</div>
<div id="menu">
<ul class="nav">
	<li>
		<a href="#">Inicio<span class="flecha">&#9660;</span></a>
	</li>
	<li>
		<a href="#">Puntos de Interés<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="poi_add.jsp">Añadir Punto de Interés<span class="flecha">&#9660;</span></a></li>
			<li><a href="poi_modify.jsp">Modificar Punto de Interés<span class="flecha">&#9660;</span></a></li>
			<li><a href="poi_delete.jsp">Eliminar Punto de Interés<span class="flecha">&#9660;</span></a></li>
		</ul>
	</li>
	<li>
		<a href="#">Usuarios<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="user_add.jsp">Añadir Usuario<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_modify1.jsp">Modificar Mi Contraseña<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_modify2.jsp">Modificar Mi Nombre<span class="flecha">&#9660;</span></a></li>
			<li><a href="user_delete.jsp">Eliminar Mi Usuario<span class="flecha">&#9660;</span></a></li>
		</ul>
	</li>
	<li>
		<a href="logout.jsp">Cerrar Sesión<span class="flecha">&#9660;</span></a>
	</li>
</ul>
</div>
<div id="main">
	<div id="main2">
	<h1>Bienvenido</h1>
	 Desde este sitio puede agregar puntos de interés para el sistema movil.
	</div>
	<div id="main1">
	<div id="map-canvas" style="height:590px; width:660px"></div>
	</div>
</div>
<div id="footer">
<div id="textoplomo">
<br> Creado por Francisco Rojas <br>
</div>
</div>
</center>
</body>
</html>
