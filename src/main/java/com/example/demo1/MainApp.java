package com.example.demo1;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MainApp extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        // Carga el FXML — ajusta la ruta si tu archivo está en otra carpeta de resources
        FXMLLoader loader = new FXMLLoader(
                getClass().getResource("/com/example/dominosprj/pantallas/Agregar_Empleado.fxml"));
        Parent root = loader.load();
        primaryStage.setTitle("Dominos PRJ - Agregar Empleado");
        primaryStage.setScene(new Scene(root, 600, 400));
        // tamaño fijo igual al prefWidth/prefHeight del FXML
        primaryStage.setResizable(false);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
