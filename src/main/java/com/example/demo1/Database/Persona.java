package com.example.demo1.Database;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

public class Persona {

    private final StringProperty nombre;
    private final StringProperty apellido;
    private final StringProperty ciudad;
    private final StringProperty telefono;
    private final StringProperty correo;
    private final StringProperty provincia;

    public Persona(String nombre, String apellido, String ciudad,
                   String telefono, String correo, String provincia) {
        this.nombre    = new SimpleStringProperty(nombre);
        this.apellido  = new SimpleStringProperty(apellido);
        this.ciudad    = new SimpleStringProperty(ciudad);
        this.telefono  = new SimpleStringProperty(telefono);
        this.correo    = new SimpleStringProperty(correo);
        this.provincia = new SimpleStringProperty(provincia);
    }

    public String getNombre()    { return nombre.get(); }
    public String getApellido()  { return apellido.get(); }
    public String getCiudad()    { return ciudad.get(); }
    public String getTelefono()  { return telefono.get(); }
    public String getCorreo()    { return correo.get(); }
    public String getProvincia() { return provincia.get(); }

    public void setNombre(String v)    { nombre.set(v); }
    public void setApellido(String v)  { apellido.set(v); }
    public void setCiudad(String v)    { ciudad.set(v); }
    public void setTelefono(String v)  { telefono.set(v); }
    public void setCorreo(String v)    { correo.set(v); }
    public void setProvincia(String v) { provincia.set(v); }

    public StringProperty nombreProperty()    { return nombre; }
    public StringProperty apellidoProperty()  { return apellido; }
    public StringProperty ciudadProperty()    { return ciudad; }
    public StringProperty telefonoProperty()  { return telefono; }
    public StringProperty correoProperty()    { return correo; }
    public StringProperty provinciaProperty() { return provincia; }
}
