package cl.rojasycia.tserviciosweb.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Poi {
   
    protected int id;
    protected double latitud;
    protected double longitud;
    protected String nombre;
    protected String tipo;

    public Poi(int id, double latitud, double longitud, String nombre, String tipo) {
        this.id = id;
        this.latitud = latitud;
        this.longitud = longitud;
        this.nombre = nombre;
        this.tipo = tipo;
    }
    
    public Poi() {
		super();
	}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
}
