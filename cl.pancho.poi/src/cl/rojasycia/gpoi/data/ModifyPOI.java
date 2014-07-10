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

public class ModifyPOI {
	
	public ModifyPOI(String id, String nombre, String tipo, String latitud, String longitud, String operation){
		
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
	    
		Form form = new Form();
	    form.add("id", id);
	    form.add("latitud", latitud);
	    form.add("longitud", longitud);
	    form.add("nombre", nombre);
	    form.add("tipo", tipo);
	    form.add("op", operation);
	    
	    ClientResponse response = service.path("rest").path("servicio")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    System.out.println(response.getStatus());

	}
	
	private static URI getBaseURI() {
	    return UriBuilder.fromUri("http://localhost:8080/cl.rojasycia.tserviciosweb").build();
	}
}
