package cl.rojasycia.tserviciosweb.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Usuario {
	
	protected String idUsuario;
	protected String nombreUsuario;
	protected String passUsuario;
	
	public Usuario(String idUsuario, String nombreUsuario, String passUsuario) {
		super();
		this.idUsuario = idUsuario;
		this.nombreUsuario = nombreUsuario;
		this.passUsuario = passUsuario;
	}
	
	public Usuario() {
		super();
	}
	
	public String getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(String idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getPassUsuario() {
		return passUsuario;
	}
	public void setPassUsuario(String passUsuario) {
		this.passUsuario = passUsuario;
	}

}
