package cl.rojasycia.gpoi.data;

import java.net.URI;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.representation.Form;

public class ClientPoi {
	
	private static URI getBaseURI() {
	    return UriBuilder.fromUri("http://"+Config.getServer()+":8080/cl.rojasycia.tserviciosweb").build();
	}
	
	public int insertarNuevoPoi(String nombre, String tipo, String latitud, String longitud){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
	    String id_max = service.path("rest").path("servicio/max_id").accept(MediaType.TEXT_XML).get(String.class);
	    
	    int id = 1+Integer.parseInt(id_max);
	    
		Form form = new Form();
	    form.add("id", id);
	    form.add("latitud", latitud);
	    form.add("longitud", longitud);
	    form.add("nombre", nombre);
	    form.add("tipo", tipo);
	    form.add("op", "insert");
	    ClientResponse response = service.path("rest").path("servicio")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    System.out.println(response.getStatus());
	    return Integer.parseInt(response.getEntity(String.class));
	}
	
	public int modificarPoi(String id, String nombre, String tipo, String latitud, String longitud){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
	    
		Form form = new Form();
	    form.add("id", id);
	    form.add("latitud", latitud);
	    form.add("longitud", longitud);
	    form.add("nombre", nombre);
	    form.add("tipo", tipo);
	    form.add("op", "update");
	    
	    ClientResponse response = service.path("rest").path("servicio")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    System.out.println(response.getStatus());
	    return Integer.parseInt(response.getEntity(String.class));
	}
	
	public int borrarPoi(String id){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
	    
		Form form = new Form();
	    form.add("id", id);
	    form.add("op", "delete");
	    
	    ClientResponse response = service.path("rest").path("servicio")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    System.out.println(response.getStatus());
	    return Integer.parseInt(response.getEntity(String.class));
	}

}
