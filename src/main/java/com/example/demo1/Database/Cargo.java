package com.example.demo1.Database;

public class Cargo {
    private int    idCargo;
    private String nombre;
    private String descripcion;
    private int    idDepartamento;

    public Cargo() {}

    public Cargo(int idCargo, String nombre, String descripcion, int idDepartamento) {
        this.idCargo        = idCargo;
        this.nombre         = nombre;
        this.descripcion    = descripcion;
        this.idDepartamento = idDepartamento;
    }

    public int    getIdCargo()        { return idCargo; }
    public String getNombre()         { return nombre; }
    public String getDescripcion()    { return descripcion; }
    public int    getIdDepartamento() { return idDepartamento; }

    public void setIdCargo(int idCargo)               { this.idCargo = idCargo; }
    public void setNombre(String nombre)               { this.nombre = nombre; }
    public void setDescripcion(String descripcion)     { this.descripcion = descripcion; }
    public void setIdDepartamento(int idDepartamento)  { this.idDepartamento = idDepartamento; }
}
