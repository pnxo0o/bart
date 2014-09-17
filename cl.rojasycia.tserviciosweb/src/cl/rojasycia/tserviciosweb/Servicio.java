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
import cl.rojasycia.tserviciosweb.model.Usuario;


// URL + /servicio
@Path("/servicio")
public class Servicio {
	
	private static String pass = "postgres";
	private static String usuario = "postgres";
  	private static String driver = "org.postgresql.Driver"; 
  	private static String server = "localhost";
  	private static int LIMITE_PUNTOS_ENTREGADOS = 35; //para celular
	
	  @Context
	  UriInfo uriInfo;
	  @Context
	  Request request;


  //devuelve todos los pois en xml
  @GET
  @Produces(MediaType.TEXT_XML)
  public List<Poi> getPOIXML() {
	    String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
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
  public String getPOIHTML() {
	  String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
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
  public Poi getPoibyId(@PathParam("idpoi") String id) {
	  	String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
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
 
 //este llama a todos los poi segun su tipo ordenados por nombre poi 
  @GET
  @Path("categoria/{tipo}")
  public List<Poi> getPoiByTipo(@PathParam("tipo") String tipo) {
	    String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
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
	    	sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo FROM poi WHERE tipopoi="+tipo+" order by nombrepoi;";
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
  
  //devuelve segun latitud, longitud y tipo
 @GET
 @Path("tipo/{lat}/{lon}/{tipo}")
 public List<Poi> getPoiTipoLatLong(
			@PathParam("lat") double lat,
			@PathParam("lon") double lon, 
			@PathParam("tipo") int tipo) {

	    String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
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
 
 @GET
 @Path("cat/{lat}/{lon}/{cat}")
 public List<Poi> getPoiCatLatLong(
			@PathParam("lat") double lat,
			@PathParam("lon") double lon, 
			@PathParam("cat") int cat) {

	    String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
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
	    	if(cat==0){
	    		sql = "SELECT idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, nombrepoi as nombre, tipopoi as tipo "
	    				+ "FROM poi ORDER BY the_geom <-> ST_MakePoint( "+lat+" , "+lon+") LIMIT "+LIMITE_PUNTOS_ENTREGADOS+" ;";
	    	}else{
	    		sql = "select idpoi as id, ST_X(the_geom) as lat, ST_Y(the_geom) as lon, "
	    				+ "nombrepoi as nombre, tipopoi as tipo from poi as poi "
	    				+ "inner join tipo as tipo on poi.tipopoi = idtipo inner join "
	    				+ "categoria as cat on tipo.idcategoria = cat.idcat "
	    				+ "where cat.idcat = "+cat+" ORDER BY the_geom <-> ST_MakePoint( "+lat+" , "+lon+") LIMIT "+LIMITE_PUNTOS_ENTREGADOS+" ;";
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
	  String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass;
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
  public String postPOI(
	  @FormParam("id") String id,
      @FormParam("latitud") String latitud,
      @FormParam("longitud") String longitud,
      @FormParam("nombre") String nombre,
      @FormParam("tipo") String tipo,
      @FormParam("op") String op,
      @Context HttpServletResponse servletResponse) throws IOException {
	  
	  	String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
	    String sql = null;
	    Connection conn = null;
	    Statement sentencia = null;    

	    try {
	    	Class.forName(driver);
	    	conn = DriverManager.getConnection(connectString);
	    	
	    	if(op.equals("insert")){
	    		if(Servicio.isDouble(latitud)==false || Servicio.isDouble(latitud)==false){
	    			return "0";
	    	    }
	    		else{
	    			sql = "INSERT INTO poi (idpoi, the_geom, nombrepoi, tipopoi) VALUES ("+id+",ST_GeomFromText('POINT("+latitud+" "+longitud+")',32661),'"+nombre+"', "+tipo+")";
	    		}
	    	}
	    	else if(op.endsWith("update")){
	    		if(Servicio.isDouble(latitud)==false || Servicio.isDouble(latitud)==false){
	    	    	return "0";
	    	    }
	    		else{
	    			sql = "UPDATE poi SET the_geom=ST_GeomFromText('POINT("+latitud+" "+longitud+")',32661), nombrepoi='"+nombre+"', tipopoi='"+tipo+"' WHERE idpoi="+id+"";
	    		}
	    	}
	    	else if(op.endsWith("delete")){
	    		sql = "DELETE from poi where idpoi="+id+"";
	    	}
	    	
	    	sentencia = conn.createStatement();
	    	sentencia.executeUpdate(sql);
	    	sentencia.close();
	    	conn.close();
	            
	    }
	    catch(SQLException  e) {
	    	System.out.println("sql error post poi");
	    	return "0";
	    }
	    catch(ClassNotFoundException e) {
	    	System.out.println("cnf error post poi");
	    	return "0";
	    }
	    System.out.println("ok post poi");
	    return "1";
  }

 //devuelve todos los usuarios en xml
  @GET
  @Produces(MediaType.TEXT_XML)
  @Path("usuariossistema")
  public List<Usuario> getUserXML() {
	    String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
	    String sql;
	    ResultSet resultado;
	    Connection conn;
	    Statement sentencia;
	    List<Usuario> listadoUsuario = new ArrayList<>();

	    try {
	    	Class.forName(driver);
	    	System.out.println("class ok");
	    	conn = DriverManager.getConnection(connectString);
	    	System.out.println("conn ok");
	    	sql = "select idusuario as id, nombreusuario as nombre, contrausuario as pass from usuario;";
	    	System.out.println("sql ok");
	    	sentencia = conn.createStatement();
	    	System.out.println("sentencia -ok");
	    	resultado = sentencia.executeQuery(sql);
	    
	    	while(resultado.next()){
	    		Usuario p = new Usuario(resultado.getString("id"), resultado.getString("nombre"),resultado.getString("pass"));
	    		listadoUsuario.add(p);
	    	}
	    
	    	resultado.close();
	    	sentencia.close();
	    	conn.close();
	    
	    	return listadoUsuario;
	            
	    }
	    catch(SQLException  e) {
	    	System.out.println("Error en SQL");
	    }
	    catch(ClassNotFoundException e) {
	    	System.out.println("Error en ClassNotFound");
	    }
	    return null;
  }
  
  //crea un nuevo usuario
  @POST
  @Path("usuariossistemapost")
  @Produces(MediaType.TEXT_HTML)
  @Consumes(MediaType.TEXT_XML)
  public String postUser(
	  @FormParam("idusuario") String id,
      @FormParam("nombreusuario") String nombre,
      @FormParam("contrausuario") String pass,
      @FormParam("operacion") String op,
      @Context HttpServletResponse servletResponse) throws IOException {
	  
	  	String connectString = "jdbc:postgresql://"+server+":5432/gis?user="+usuario+"&password="+pass; 
	    String sql = null;
	    Connection conn;
	    Statement sentencia = null;    

	    try {
	    	Class.forName(driver);
	    	System.out.println("class ok");
	    	conn = DriverManager.getConnection(connectString);
	    	System.out.println("conn ok");
	    	
	    	if(op.equals("insert")){
	    		sql = "insert into usuario values('"+id+"','"+nombre+"','"+pass+"');";
	    	}
	    	else if(op.endsWith("update1")){
	    		sql = "update usuario set contrausuario='"+pass+"' WHERE idusuario='"+id+"'";
	    	}
	    	else if(op.endsWith("update2")){
	    		sql = "update usuario set nombreusuario='"+nombre+"' WHERE idusuario='"+id+"'";
	    	}
	    	else if(op.endsWith("delete")){
	    		sql = "DELETE from usuario WHERE idusuario='"+id+"'";
	    	}

	    	sentencia = conn.createStatement();
	    	sentencia.executeUpdate(sql);
	    	sentencia.close();
	    	conn.close();
	    }
	    catch(SQLException  e) {
	    	return "0";
	    }
	    catch(ClassNotFoundException e) {
	    	return "0";
	    }
	    return "1";
  }
  
  
  private static boolean isDouble(String cadena){
		try {
			Double.parseDouble(cadena);
			return true;
		} catch (NumberFormatException nfe){
			return false;
		}
  }
   
  
} 