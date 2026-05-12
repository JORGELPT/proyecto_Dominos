package com.example.demo1.app;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * Clase principal de Domino's Pizza.
 * Abre primero el Login, y si las credenciales son correctas,
 * el propio CONTROLLER_Login reemplazará la escena por MainView.
 */
public class Mainapp extends Application {

    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader loader = new FXMLLoader(
                getClass().getResource("/com/example/demo1/Pantallas/Login.fxml"));
        Parent root = loader.load();
        Scene scene = new Scene(root, 900, 600);
        stage.setTitle("Domino's Pizza - Iniciar Sesión");
        stage.setScene(scene);
        stage.setMinWidth(900);
        stage.setMinHeight(600);
        stage.setResizable(true);
        stage.centerOnScreen();
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
