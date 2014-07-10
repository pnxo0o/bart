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
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;

import cl.rojasycia.tserviciosweb.model.Poi;


// URL + /servicio
@Path("/servicio")
public class Servicio {
	
	private static String pass = "postgres";
	private static String usuario = "postgres";
  	private static String driver = "org.postgresql.Driver"; 
  	private static int LIMITE_PUNTOS_ENTREGADOS = 30;
	
	  @Context
	  UriInfo uriInfo;
	  @Context
	  Request request;


  // This method is called if XML is request
  @GET
  @Produces(MediaType.TEXT_XML)
  public List<Poi> sayXMLPOI() {
	    String connectString = "jdbc:postgresql://localhost:5432/gis?user="+usuario+"&password="+pass; 
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
	    	sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo FROM poi ORDER BY the_geom <-> ST_MakePoint( -32 , -71) ;";
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia -ok");
	    	resultado = sentencia.executeQuery(sql);
	    
	    	while(resultado.next()){
	    		Poi p = new Poi(resultado.getInt("id"),resultado.getDouble("lat"),resultado.getDouble("lon"), resultado.getString("nombre"), resultado.getString("tipo"));
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

  // Devuelve todos los pois en HTML
  @GET
  @Produces(MediaType.TEXT_HTML)
  public String sayHtmlPOI() {
	  String connectString = "jdbc:postgresql://localhost:5432/gis?user="+usuario+"&password="+pass; 
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
	    	sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo FROM poi ORDER BY the_geom <-> ST_MakePoint( -32 , -71) ;";
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia ok");
	    	resultado = sentencia.executeQuery(sql);
	    
	    	while(resultado.next()){
	    		sb.append("<h1>"+ resultado.getString("nombre") + "</h1>"
	    				+ resultado.getDouble("lat")
	    				+ resultado.getDouble("lon")
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
  
  
  //este metodo es llamando al consultar por un poi particular segun su id
  @Path("{idpoi}")
  public Poi getPoi(@PathParam("idpoi") String id) {
	  	String connectString = "jdbc:postgresql://localhost:5432/gis?user="+usuario+"&password="+pass; 
	    String sql;
	    ResultSet resultado;
	    Connection conn;
	    Statement sentencia;

	    try {
	    	Class.forName(driver);
	    	System.out.println("class ok");
	    	conn = DriverManager.getConnection(connectString);
	    	System.out.println("conn ok");
	    	sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo FROM poi WHERE idpoi="+id+";";
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia ok");
	    	resultado = sentencia.executeQuery(sql);
	    	System.out.println("resultado ok ok");
	    	
	    	Poi p = new Poi();
	    	
	    	while(resultado.next()){
	    		 p= new Poi(resultado.getInt("id"),resultado.getDouble("lat"),resultado.getDouble("lon"), resultado.getString("nombre"), resultado.getString("tipo"));
	    	}
	    	System.out.println("traspaso ok");
	    	resultado.close();
	    	sentencia.close();
	    	conn.close();
	    
	    	return new PoiResource(uriInfo, request,p.getId(),p.getLatitud(),p.getLongitud(),p.getNombre(),p.getTipo());
	            
	    }
	    catch(SQLException  e) {
	    	System.out.println("Error en SQL");
	    }
	    catch(ClassNotFoundException e) {
	    	System.out.println("Error en ClassNotFound");
	    }
	    return null;
  }
  
 @GET
 @Path("{lat}/{lon}/{tipo}")
 public List<Poi> getPoi(
			@PathParam("lat") double lat,
			@PathParam("lon") double lon, 
			@PathParam("tipo") int tipo) {

	    String connectString = "jdbc:postgresql://localhost:5432/gis?user="+usuario+"&password="+pass; 
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
	    	if(tipo==0){
	    		sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo "
	    				+ "FROM poi ORDER BY the_geom <-> ST_MakePoint( "+lat+" , "+lon+") LIMIT "+LIMITE_PUNTOS_ENTREGADOS+" ;";
	    	}else{
	    		sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo "
	    				+ "FROM poi WHERE tipopoi="+tipo+" ORDER BY the_geom <-> ST_MakePoint( "+lat+" , "+lon+") LIMIT "+LIMITE_PUNTOS_ENTREGADOS+" ;";
	    	}
	    	
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia -ok");
	    	resultado = sentencia.executeQuery(sql);
	    
	    	while(resultado.next()){
	    		Poi p = new Poi(resultado.getInt("id"),resultado.getDouble("lat"),resultado.getDouble("lon"), resultado.getString("nombre"), resultado.getString("tipo"));
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
  
  //este devuelve el maximo valor de id, para hacer la posterior insercion con id+1
  @GET
  @Path("max_id")
  @Produces(MediaType.TEXT_XML)
  public String getCount() {
	  String connectString = "jdbc:postgresql://localhost:5432/gis?user="+usuario+"&password="+pass;
    String sql;
    ResultSet resultado;
    Connection conn;
    Statement sentencia;

    try {
    	Class.forName(driver);
    	System.out.println("class ok");
    	conn = DriverManager.getConnection(connectString);
    	System.out.println("conn ok");
    	sql = "select max(idpoi) as max_id from poi";
    	System.out.println("sql ok");
    	sentencia = conn.createStatement();
    	System.out.println("sentencia ok");
    	resultado = sentencia.executeQuery(sql);
    	System.out.println("resultado ok ok");
    	
    	int max_id =0;
    	
    	while(resultado.next()){
    		max_id = resultado.getInt("max_id");
    	}
    	System.out.println("traspaso ok");
    	resultado.close();
    	sentencia.close();
    	conn.close();
    
        return String.valueOf(max_id);
            
    }
    catch(SQLException  e) {
    	System.out.println("Error en SQL");
    }
    catch(ClassNotFoundException e) {
    	System.out.println("Error en ClassNotFound");
    }
    return null;
  }
  
  
  //este metodo realiza modificaciones, inserta, modifica o elimina
  @POST
  @Produces(MediaType.TEXT_HTML)
  @Consumes(MediaType.TEXT_XML)
  public String newPOI(
	  @FormParam("id") String id,
      @FormParam("latitud") String latitud,
      @FormParam("longitud") String longitud,
      @FormParam("nombre") String nombre,
      @FormParam("tipo") String tipo,
      @FormParam("op") String op,
      @Context HttpServletResponse servletResponse) throws IOException {
	  
	  	String connectString = "jdbc:postgresql://localhost:5432/gis?user="+usuario+"&password="+pass; 
	    String sql = null;
	    ResultSet resultado;
	    Connection conn;
	    Statement sentencia;
	    
	    System.out.println(id+""+latitud+""+longitud+""+nombre+""+tipo);

	    try {
	    	Class.forName(driver);
	    	System.out.println("class ok");
	    	conn = DriverManager.getConnection(connectString);
	    	System.out.println("conn ok");
	    	
	    	if(op.equals("insert")){
	    		sql = "INSERT INTO poi (idpoi, the_geom, nombrepoi, tipopoi) VALUES ("+id+",ST_GeomFromText('POINT("+latitud+" "+longitud+")',32661),'"+nombre+"', "+tipo+")";
	    	}
	    	else if(op.endsWith("update")){
		    	sql = "UPDATE poi SET the_geom=ST_GeomFromText('POINT("+latitud+" "+longitud+")',32661), nombrepoi='"+nombre+"', tipopoi='"+tipo+"' WHERE idpoi="+id+"";
	    	}
	    	else if(op.endsWith("delete")){
	    		sql = "DELETE from poi where idpoi="+id+"";
	    	}
	    	
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia ok");
	    	resultado = sentencia.executeQuery(sql);
	    	System.out.println("resultado ok ok");
	    	

	    	System.out.println("traspaso ok");
	    	resultado.close();
	    	sentencia.close();
	    	conn.close();
	    
	    	return "1";
	            
	    }
	    catch(SQLException  e) {
	    	System.out.println("Error en SQL");
	    }
	    catch(ClassNotFoundException e) {
	    	System.out.println("Error en ClassNotFound");
	    }
	    return "0";
  }
 
  
} 