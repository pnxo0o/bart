<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Inicio</title>
	<link href="default.css" rel="stylesheet" type="text/css" media="all" />
	<link href="fonts.css" rel="stylesheet" type="text/css" media="all" />
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
        
      </script>
</head>
<% if(session.getAttribute("name")==null || session.getAttribute("name").equals("")) response.sendRedirect("logout.jsp");%>
<body>
	<div id="header-wrapper">
		<div id="header" class="container">
			<div id="logo">
				<h1><a href="#">Gestor de Pois</a></h1>
				 Bienvenido <%= session.getAttribute("name")%>
			</div>
			<div id="menu">
				<ul>
					<li class="active"><a href="#" accesskey="1" title="">Añade Lugares</a></li>
					<li><a href="modifypoi.jsp" accesskey="2" title="">Modificar Lugares</a></li>
					<li><a href="logout.jsp" accesskey="3" title="">Salir</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="wrapper">
		<div id="three-column" class="container">
			<div class="title">
				<h2>Añadir Lugares</h2>
				<span class="byline">Seleccione un punto en el mapa y complete el formulario para añadir un nuevo punto de interés</span>
			</div>	
			<div class="tbox1">
				<div id="map-canvas" style="height:575px; width:500px"></div>
			</div>
			<div class="tbox2">
				<form action="index_proceso.jsp" method="post">
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
				<p><input type="submit" value="Enviar"></p>
				</form>
			</div>
		</div>
	</div>
	<div id="copyright" class="container">
	<p>© Untitled. All rights reserved. | Photos by <a href="http://fotogrph.com/">Fotogrph</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div>
</body>
</html>