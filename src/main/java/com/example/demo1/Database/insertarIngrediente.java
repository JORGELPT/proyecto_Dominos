package com.example.demo1.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.swing.JOptionPane;

public class insertarIngrediente {

    private Connection connection;

    public insertarIngrediente() {
        try {
            String usuario   = "JorgeP";
            String contrasena = "123456";
            String db        = "conexion";
            String server    = "localhost";
            String puerto    = "1433";
            String url = "jdbc:sqlserver://" + server + ":" + puerto
                    + ";databaseName=" + db + ";encrypt=false";
            connection = DriverManager.getConnection(url, usuario, contrasena);
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al conectar: " + e.toString());
        }
    }

    public void insertarIngrediente() {
        String sql = "INSERT INTO ingrediente (Nombre, CantidadStock, Imagen) VALUES (?, ?, ?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setString(1, "Harina");
            pstmt.setInt(2, 100);
            pstmt.setString(3, "harina.png");
            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, "Ingrediente insertado correctamente");
        } catch (Exception e) {
            System.out.println(e.toString());
            JOptionPane.showMessageDialog(null, "Error: " + e.toString());
        }
    }
}
