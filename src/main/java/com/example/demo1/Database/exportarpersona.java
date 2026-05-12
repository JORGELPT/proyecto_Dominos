package com.example.demo1.Database;

import javafx.application.Application;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class exportarpersona extends Application {

    // ---- Clase Persona adentro ----
    static class Persona {
        private StringProperty nombre   = new SimpleStringProperty("");
        private StringProperty apellido = new SimpleStringProperty("");

        public void setNombre(String nombre) {
            this.nombre.set(nombre);
        }

        public String getNombre() {
            return nombre.get();
        }

        public void setApellido(String apellido) {
            this.apellido.set(apellido);
        }

        public String getApellido() {
            return apellido.get();
        }
    }

    // Formulario
    @Override
    public void start(Stage stage) {
        TextField txtNombre   = new TextField();
        TextField txtApellido = new TextField();
        Button    btnGuardar  = new Button("Guardar");

        btnGuardar.setOnAction(e -> {
            Persona p = new Persona();
            p.setNombre(txtNombre.getText());
            p.setApellido(txtApellido.getText());
            System.out.println("Guardado: " + p.getNombre() + " " + p.getApellido());
        });

        VBox layout = new VBox(10, txtNombre, txtApellido, btnGuardar);
        stage.setScene(new Scene(layout, 300, 200));
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
