package com.example.demo1.Database;

public class MainConexion {

    public static void main(String[] args) {
        Conexion objectoconexion = new Conexion();
        objectoconexion.establecerConexion();
        // objectoconexion.insertDatos();
        // objectoconexion.Borrar(2);
        // objectoconexion.UpdateTable(3);
        objectoconexion.leerDato(3);
    }
}
