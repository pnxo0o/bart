package cl.rojasycia.tserviciosweb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import cl.rojasycia.tserviciosweb.model.Poi;

// Plain old Java Object it does not extend as class or implements 
// an interface

// The class registers its methods for the HTTP GET request using the @GET annotation. 
// Using the @Produces annotation, it defines that it can deliver several MIME types,
// text, XML and HTML. 

// The browser requests per default the HTML MIME type.

//Sets the path to base URL + /hello
@Path("/servicio")
public class Servicio {

  // This method is called if TEXT_PLAIN is request
  @GET
  @Produces(MediaType.TEXT_PLAIN)
  public String sayPlainTextHello() {
    return "Hello Jersey";
  }

  // This method is called if XML is request
  @GET
  @Produces(MediaType.TEXT_XML)
  public List<Poi> sayXMLHello() {
	  String driver = "org.postgresql.Driver"; 
	    String connectString = "jdbc:postgresql://localhost:5432/gis?user=postgres&password=postgres"; 
	    String sql;
	    ResultSet resultado;
	    Connection conn;
	    Statement sentencia;
	    List<Poi> listadoPoi = new ArrayList<>();

	    try {
	    	Class.forName(driver);
	    	System.out.println("class ok");
	    	conn = DriverManager.getConnection(connectString);
	    	System.out.println("conn ok");
	    	sql = "SELECT id as id, ST_X(the_geom) as lon, ST_Y(the_geom) as lat, nombre as nombre, tipo as tipo FROM poi ORDER BY the_geom <-> ST_MakePoint( -32 , -71) ;";
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia ok");
	    	resultado = sentencia.executeQuery(sql);
	    
	    	while(resultado.next()){
	    		Poi p = new Poi(resultado.getInt("id"),resultado.getDouble("lon"),resultado.getDouble("lat"), resultado.getString("nombre"), resultado.getString("tipo"));
	    		listadoPoi.add(p);
	    	}
	    
	    	resultado.close();
	    	sentencia.close();
	    	conn.close();
	    
	    	return listadoPoi;
	            
	    }
	    catch(SQLException  e) {
	    	System.out.println("Error en SQL");
	    }
	    catch(ClassNotFoundException e) {
	    	System.out.println("Error en ClassNotFound");
	    }
	    return null;

  }

  // This method is called if HTML is request
  @GET
  @Produces(MediaType.TEXT_HTML)
  public String sayHtmlHello() {
    return "<html> " + "<title>" + "Hello Jersey" + "</title>"
        + "<body><h1>" + "Hello Jersey" + "</body></h1>" + "</html> ";
  }

} 