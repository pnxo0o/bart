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
    	}

		google.maps.event.addDomListener(window, 'load', initialize);
		
		$(function(ready){
		    $('.titleother').change(function() {
		        alert($(this).val());
	            $.ajax({
	                type: "GET",
	                url: "http://localhost:8080/cl.rojasycia.tserviciosweb/rest/servicio/"+$(this).val(),
	                dataType: "xml",
	                success: function (xml) {                   
	                    $(xml).find('poi').each(function () {
	                    	var id = $(this).find('id').text();
	                        var nombre = $(this).find('nombre').text();
	                        var latitud = $(this).find('latitud').text();
	                        var longitud = $(this).find('longitud').text();
	                        var tipo = $(this).find('tipo').text();
	                        
	                        document.getElementById('textid').value = id;
	                        document.getElementById('textnombre').value = nombre;
	                        document.getElementById('textlat').value = latitud;
	                		document.getElementById('textlon').value = longitud;
	                		document.getElementById('ctipo').value = tipo;

	                		
	                        var myLatLng = new google.maps.LatLng(latitud, longitud);
	                        
	                        if (marker == undefined){
	                            marker = new google.maps.Marker({
	                                position: myLatLng,
	                                map: map,
	                                animation: google.maps.Animation.DROP,
	                            });
	                        }
	                        else{
	                            marker.setPosition(myLatLng);
	                        }
	                        map.setCenter(myLatLng);
	                        
	                        
	                    });
	                },
	                error: function (xhr) {
	                    alert(xhr.responseText);
	                }
	            });
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
					<li><a href="index.jsp" accesskey="1" title="">Añade Lugares</a></li>
					<li class="active"><a href="#" accesskey="2" title="">Modificar Lugares</a></li>
					<li><a href="logout.jsp" accesskey="2" title="">Salir</a></li>
				</ul>
			</div>
		</div>
	</div>
		<div id="wrapper">
		<div id="three-column" class="container">
			<div class="title">
				<h2>Modificar lugares</h2>	
				<span class="byline">Seleccione </span>
			</div>
			<div class="tbox1">
				<div id="map-canvas" style="height:575px; width:500px"></div>
			</div>
			<div class="tbox2">
			<table border="0" align="center">
			<tr>
				<td>Lugar:</td>
				<td>
				<select class="titleother">
				<option value="" selected="selected"></option>
				<%
    				DownloadPOI x = new DownloadPOI();
    				List<Poi> listP =x.setPOIDescargados();
    				Iterator<Poi> iterador = listP.listIterator();
    				while( iterador.hasNext() ) {
    					Poi p = (Poi) iterador.next();
    					%>
    					<option value="<%= p.getId() %>"><%= p.getNombre() %></option>
    					<%
					}		
				%>
				</select>
				</td>
			</tr>
			</table>
			<form action="modifypoi_proceso.jsp" method="post">
			<table border="0" align="center">
			<tr>
				<td>Id:</td>
				<td><input type="text" id="textid" name="id"></td>
			</tr>
			<tr>
				<td>Latitud:</td>
				<td><input type="text" id="textlat" name="lat"></td>
			</tr>
			<tr>
				<td>Longitud:</td>
				<td><input type="text" id="textlon" name="lon"></td>
			</tr>
			<tr>
				<td>Nombre: </td>
				<td><input type="text" id="textnombre" name="nombre"></td>
			</tr>
			<tr>
				<td>Tipo:</td>
				<td>
				<select id="ctipo" name="ctipo">
				<option value="" selected="selected"></option>
				<optgroup label="UNIVERSIDADES">
					<option value="1">UPLA</option>
					<option value="2">UV</option>
					<option value="3">PUCV</option>
					<option value="4">USM</option>
				</optgroup>
				<optgroup label="ALIMENTACION">
					<option value="5">CAFETERIA</option>
					<option value="6">COMIDA RAPIDA</option>
					<option value="7">RESTAURANT</option>
				<option value="8">SUPERMERCADO</option>
				</optgroup>
				<optgroup label="ALOJAMIENTO">	
					<option value="9">HOSTAL</option>
					<option value="10">HOTEL</option>
					<option value="11">RESIDENCIAL</option>
				</optgroup>
				<optgroup label="ENTRETENCION">
					<option value="12">MUSEO</option>
					<option value="13">CINE</option>
					<option value="14">BAR</option>
					<option value="15">DISCO</option>
					<option value="16">EXTERIOR</option>
				</optgroup>
				<optgroup label="SERVICIOS">
					<option value="17">CARABINEROS</option>
					<option value="18">SERVICIO MEDICO</option>
					<option value="19">BOMBEROS</option>
					<option value="20">METRO</option>
				</optgroup>
				</select>
				</td>
			</tr>
			</table>
				<input type="radio" name="optionpoi" value="update" checked>Actualizar
				<br>
				<input type="radio" name="optionpoi" value="delete">Eliminar	
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