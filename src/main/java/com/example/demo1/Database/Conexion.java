package com.example.demo1.Database;

import javax.swing.*;
import java.sql.*;

public class Conexion {

    // ── Datos de conexión ──────────────────────────────────────────────────
    private static final String usuario    = "Jorge";
    private static final String contrasena = "Dominos26!mgjp";
    private static final String db         = "dominospizza_RA5";
    private static final String server     = "26.57.254.219";
    private static final String puerto     = "1433";

    // ── Connection estática porque el método es static ─────────────────────
    private static Connection connection = null;

    // ── Establece y retorna la conexión ────────────────────────────────────
    public static Connection establecerConexion() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String cadena = "jdbc:sqlserver://" + server + ":" + puerto + ";"
                    + "databaseName="        + db + ";"
                    + "encrypt=true;"
                    + "trustServerCertificate=true";
            connection = DriverManager.getConnection(cadena, usuario, contrasena);
        } catch (Exception e) {
            System.out.println(e.toString());
            JOptionPane.showMessageDialog(null, "Error en la conexión: " + e.toString());
        }
        return connection;
    }

    public void leerDato(int i) {
        // placeholder — implementar según necesidad
    }
}
