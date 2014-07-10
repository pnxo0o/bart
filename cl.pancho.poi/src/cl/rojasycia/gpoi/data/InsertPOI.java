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

public class InsertPOI {
	
	public InsertPOI(String nombre, String tipo, String latitud, String longitud){
		
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

	}
	
	private static URI getBaseURI() {
	    return UriBuilder.fromUri("http://localhost:8080/cl.rojasycia.tserviciosweb").build();
	}
}
