package cl.rojasycia.gpoi.model;

public class Poi {
	
	private int id;
    private double latitud;
    private double longitud;
    private String nombre;
    private String tipo;

    public Poi(int id, double latitud, double longitud, String nombre, String tipo) {
        this.setId(id);
        this.setLatitud(latitud);
        this.setLongitud(longitud);
        this.setNombre(nombre);
        this.setTipo(tipo);
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
