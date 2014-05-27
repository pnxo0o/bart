package cl.rojasycia.tserviciosweb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import cl.rojasycia.tserviciosweb.model.Poi;


//Sets the path to base URL + /hello
@Path("/servicio")
public class Servicio {

  // This method is called if TEXT_PLAIN is request
  @GET
  @Produces(MediaType.TEXT_PLAIN)
  public String sayPlainTextHello() {
    return "Hello World ( :";
  }

  // This method is called if XML is request
  @GET
  @Produces(MediaType.TEXT_XML)
  public List<Poi> sayXMLPOI() {
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
  public String sayHtmlPOI() {
	  String driver = "org.postgresql.Driver"; 
	  String connectString = "jdbc:postgresql://localhost:5432/gis?user=postgres&password=postgres"; 
	  String sql;
	  ResultSet resultado;
	  Connection conn;
	  Statement sentencia;
	  
	    try {
	    	StringBuilder sb = new StringBuilder();
	    	sb.append("<html> " 
	    			+ "<title>" 
	    			+ "Puntos de Interes" 
	    			+ "</title>" 
	    			+ "<body>");
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
	    		sb.append("<h1>"+ resultado.getString("nombre") + "</h1>"
	    				+ resultado.getDouble("lon")
	    				+ resultado.getDouble("lat")
	    				+ resultado.getString("tipo")
	    				+ "<br>");
	    	}
	    
	    	resultado.close();
	    	sentencia.close();
	    	conn.close();
	    	
	    	sb.append("</body>" + "</html> ");
	    
	    	return sb.toString();
	            
	    }
	    catch(SQLException  e) {
	    	System.out.println("Error en SQL");
	    }
	    catch(ClassNotFoundException e) {
	    	System.out.println("Error en ClassNotFound");
	    }
	    return null;

  }
  
  @POST
  @Produces(MediaType.TEXT_HTML)
  @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
  public void newTodo(@FormParam("id") String id,
      @FormParam("summary") String summary,
      @FormParam("description") String description,
      @Context HttpServletResponse servletResponse) throws IOException {
    System.out.println(""+id+" - "+summary+" - "+description);
    
    servletResponse.sendRedirect("../NewFile.html");
  }

} 