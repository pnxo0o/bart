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

public class ClientUsuario {
	
	private static URI getBaseURI() {
	    return UriBuilder.fromUri("http://"+Config.getServer()+":8080/cl.rojasycia.tserviciosweb").build();
	}
	
	public int insertarNuevoUsuario(String idusuario, String nombreusuario, String contrausuario){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
		
		Form form = new Form();
	    form.add("idusuario", idusuario);
	    form.add("nombreusuario", nombreusuario);
	    form.add("contrausuario", contrausuario);
	    form.add("operacion", "insert");
	    ClientResponse response = service.path("rest").path("servicio/usuariossistemapost")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    
	    return Integer.parseInt(response.getEntity(String.class));
	}
	
	public int modificarContrasena(String idusuario, String contrausuario){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
		
		Form form = new Form();
	    form.add("idusuario", idusuario);
	    form.add("contrausuario", contrausuario);
	    form.add("operacion", "update1");
	    ClientResponse response = service.path("rest").path("servicio/usuariossistemapost")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    
	    return Integer.parseInt(response.getEntity(String.class));
	}

	
	public int modificarNombre(String idusuario, String nombreusuario){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
		
		Form form = new Form();
	    form.add("idusuario", idusuario);
	    form.add("nombreusuario", nombreusuario);
	    form.add("operacion", "update2");
	    ClientResponse response = service.path("rest").path("servicio/usuariossistemapost")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    //System.out.println(response.getStatus());
	    return Integer.parseInt(response.getEntity(String.class));
	}
	
	public int eliminarUsuario(String idusuario){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
		
		Form form = new Form();
	    form.add("idusuario", idusuario);
	    form.add("operacion", "delete");
	    ClientResponse response = service.path("rest").path("servicio/usuariossistemapost")
	        .type(MediaType.TEXT_XML)
	        .post(ClientResponse.class, form);
	    //System.out.println(response.getStatus());
	    return Integer.parseInt(response.getEntity(String.class));
	}
	
	
}
