package com.example.demo1.app;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Cargoapp extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(
                Cargoapp.class.getResource("/com/example/demo1/Pantallas/Agregar_Cargo.fxml"));
        Parent root = loader.load();
        Scene scene = new Scene(root, 600, 500);
        primaryStage.setTitle("Cargo");
        primaryStage.setScene(scene);
        primaryStage.setResizable(false);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
