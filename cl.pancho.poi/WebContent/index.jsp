<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
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
					<li class="active"><a href="#" accesskey="1" title="">A�ade Lugares</a></li>
					<li><a href="logout.jsp" accesskey="2" title="">Salir</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="wrapper">
		<div id="three-column" class="container">
			<div class="title">
				<h2>A�adir Lugares</h2>
				<span class="byline">Seleccione un punto en el mapa y complete el formulario para a�adir un nuevo punto de inter�s</span>
			</div>	
			<div class="tbox1">
				<div id="map-canvas" style="height:575px; width:500px"></div>
			</div>
			<div class="tbox2">
				<form action="procesox.jsp" method="post">
				Lat: 
				<input type="text" id="textlat" name="lat">
				Lon: 
				<input type="text" id="textlon" name="lon">
				<br/>
				Nombre: 
				<input type="text" name="nombre">
				<br/>
				Tipo: 
				<input type="text" name="tipo">
				<br/>
				<p><input type="submit" value="Enviar"></p>
				</form>
			</div>
		</div>
	</div>
	<div id="copyright" class="container">
	<p>� Untitled. All rights reserved. | Photos by <a href="http://fotogrph.com/">Fotogrph</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div>
</body>
</html>