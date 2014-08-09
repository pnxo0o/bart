<!--Francisco Rojas-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Añadir POI - Gestor POI</title>
	<link href="main.css" rel="stylesheet" type="text/css" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	
		/**variables del mapa**/
		var map;
		var marker;
		
		/**mapa**/
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
		
		/** **/
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
        
        /**metodo que llena el combo dinamico**/
       
        $(function(ready){
		    $('.categoria').change(function() {
		        $("#tipo").empty();
		        if($(this).val()==1){
				    $("#tipo").append("<option value=\"1\">UPLA</option>");
				    $("#tipo").append("<option value=\"2\">UV</option>");
				    $("#tipo").append("<option value=\"3\">PUCV</option>");
				    $("#tipo").append("<option value=\"4\">USM</option>");
		        }
		        if($(this).val()==2){
				    $("#tipo").append("<option value=\"5\">CAFETERIA</option>");
				    $("#tipo").append("<option value=\"6\">COMIDA RAPIDA</option>");
				    $("#tipo").append("<option value=\"7\">RESTAURANT</option>");
				    $("#tipo").append("<option value=\"8\">SUPERMERCADO</option>");
		        }
		        if($(this).val()==3){
				    $("#tipo").append("<option value=\"9\">HOSTAL</option>");
				    $("#tipo").append("<option value=\"10\">HOTEL</option>");
				    $("#tipo").append("<option value=\"11\">RESIDENCIAL</option>");
		        }
		        if($(this).val()==4){
				    $("#tipo").append("<option value=\"12\">MUSEO</option>");
				    $("#tipo").append("<option value=\"13\">CINE</option>");
				    $("#tipo").append("<option value=\"14\">BAR</option>");
				    $("#tipo").append("<option value=\"15\">DISCO</option>");
				    $("#tipo").append("<option value=\"16\">EXTERIOR</option>");
		        }
		        if($(this).val()==5){
				    $("#tipo").append("<option value=\"17\">CARABINEROS</option>");
				    $("#tipo").append("<option value=\"18\">SERVICIO MEDICO</option>");
				    $("#tipo").append("<option value=\"19\">BOMBEROS</option>");
				    $("#tipo").append("<option value=\"20\">METRO</option>");
		        }
		    });
		});
        
        /** validador de datos del formulario**/
        function validardatos(formObj) {

            if ( (formObj.lat.value) == "") { 
            	alert ("No indicó la latitud");
            	return false;
            }
            
            if ( (formObj.lon.value) == "") { 
                alert ("No indicó la longitud");
                return false;
            }
            
            if ( (formObj.nombre.value) == "") { 
                alert ("No indicó el nombre del punto de interés");
                return false;
            }
            
            if ( (formObj.categoria.value) == "") { 
                alert ("No indicó la categoría");
                return false;
            }
            
            if ( (formObj.tipo.value) == "") { 
                alert ("No indicó el tipo del punto de interés");
                return false;
            }  
            
        }
        
      </script>
</head>
<body>
<% 
try { 
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
		<a href="index.jsp">Inicio<span class="flecha">&#9660;</span></a>
	</li>
	<li>
		<a href="#">Puntos de Interés<span class="flecha">&#9660;</span></a>
		<ul>
			<li><a href="#">Añadir Punto de Interés<span class="flecha">&#9660;</span></a></li>
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
	<h2>Añadir Lugares</h2>
	Seleccione un punto en el mapa y complete el formulario para añadir un nuevo punto de interés
	<br/>
	<form action="poi_add_action.jsp" method="post" onsubmit="return validardatos(this);">
		<table border="0" align="center">
		<tr>
			<td>Latitud:</td>
			<td><input type="text" id="textlat" name="lat"></td>
		</tr>
		<tr>
			<td>Longitud:</td>
			<td><input type="text" id="textlon" name="lon"></td>
		</tr>
		<tr>
			<td>Nombre:</td>
			<td><input type="text" name="nombre"></td>
		</tr>
		<tr>
			<td>Categoria:</td>
			<td>
			<select class="categoria" name="categoria">
				<option value="" selected="selected"></option>
				<option value="1">UNIVERSIDADES</option>
				<option value="2">ALIMENTACION</option>
				<option value="3">ALOJAMIENTO</option>
				<option value="4">ENTRETENCION</option>
				<option value="5">SERVICIOS</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Tipo:</td>
			<td>
			<select id="tipo" name="tipo">
			</select>
			</td>
		</tr>
		</table>
		<p><input type="submit" value="Añadir Nuevo Punto"></p>
	</form>
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
