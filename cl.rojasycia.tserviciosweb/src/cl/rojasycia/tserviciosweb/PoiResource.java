package cl.rojasycia.tserviciosweb;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.core.Request;

import cl.rojasycia.tserviciosweb.model.Poi;

public class PoiResource extends Poi{

	@Context
	UriInfo uriInfo;
	@Context
	Request request;
	
	public PoiResource(){
		
	}
	
	public PoiResource (UriInfo uriInfo, Request request, int id, double latitud, double longitud, String nombre, String tipo){
		this.id = id;
        this.latitud = latitud;
        this.longitud = longitud;
        this.nombre = nombre;
        this.tipo = tipo;
        this.uriInfo = uriInfo;
	}
	
	
	//colabora a retornar el poi particular
	 @GET
	 @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
	 public Poi getTodo() {
	    Poi p = new Poi(id, latitud, longitud, nombre, tipo);
	    return p;
	  }
	
}
