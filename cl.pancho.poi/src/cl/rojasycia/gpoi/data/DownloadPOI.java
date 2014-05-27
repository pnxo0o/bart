package cl.rojasycia.gpoi.data;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import cl.rojasycia.gpoi.model.Poi;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.UniformInterfaceException;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import java.io.IOException;
import java.io.StringReader;

public class DownloadPOI {
	
	List<Poi> listadoPoi = new ArrayList<>();
	
	public List<Poi> setPOIDescargados(){
		return listadoPoi;
	}

	public DownloadPOI(){
		ClientConfig config = new DefaultClientConfig();
	    Client client = Client.create(config);
	    WebResource service = client.resource(getBaseURI());
	    System.out.println(service.path("rest").path("servicio").accept(MediaType.TEXT_XML).get(String.class));
	    
	    DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
	    domFactory.setNamespaceAware(true); 
	    DocumentBuilder builder;
		try {
			builder = domFactory.newDocumentBuilder();
			Document doc = builder.parse(new InputSource(
					new StringReader(service.path("rest").path("servicio").accept(MediaType.TEXT_XML).get(String.class))));
			
			Element raiz = doc.getDocumentElement();
			NodeList listaPoi = raiz.getElementsByTagName("poi");
			
			for(int i=0; i<listaPoi.getLength(); i++) {   
				Node poi = listaPoi.item(i);
				NodeList datosPoi = poi.getChildNodes();
				
				 Poi p = new Poi();
				 for(int j=0; j<datosPoi.getLength(); j++){
					 Node dato = datosPoi.item(j);
					 
					 if(dato.getNodeType()==Node.ELEMENT_NODE) {
						 if(dato.getNodeName()=="id"){
							  Node datoContenido = dato.getFirstChild();
					          p.setId(Integer.parseInt(datoContenido.getNodeValue()));
						 }
						 else if(dato.getNodeName()=="nombre"){
							 Node datoContenido = dato.getFirstChild();
					         p.setNombre(datoContenido.getNodeValue());
						 }
						 else if(dato.getNodeName()=="tipo"){
							 Node datoContenido = dato.getFirstChild();
					         p.setTipo(datoContenido.getNodeValue());
						 }
						 else if(dato.getNodeName()=="latitud"){
							 Node datoContenido = dato.getFirstChild();
					         p.setLatitud(Double.parseDouble(datoContenido.getNodeValue()));
						 }
						 else if(dato.getNodeName()=="longitud"){
							 Node datoContenido = dato.getFirstChild();
					         datoContenido.getNodeValue();
					         p.setLongitud(Double.parseDouble(datoContenido.getNodeValue()));
						 }
					 }
				 }
				 listadoPoi.add(p);
			}
		} catch (ParserConfigurationException e) {		
			e.printStackTrace();
		} catch (UniformInterfaceException e) {			
			e.printStackTrace();
		} catch (SAXException e) {	
			 System.out.println("ERROR: El formato XML del fichero no es correcto\n"+e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {			
			e.printStackTrace();
		}
	    
	}
	
	private static URI getBaseURI() {
	    return UriBuilder.fromUri("http://localhost:8080/cl.rojasycia.tserviciosweb").build();
	}
	
}
