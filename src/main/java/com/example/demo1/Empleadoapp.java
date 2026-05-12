package com.example.demo1;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import java.net.URL;

public class Empleadoapp extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        // Intenta estas rutas en orden hasta que una funcione
        String[] rutas = {
            "/com/example/dominosprj/pantallas/Empleado.fxml",
            "/pantallas/Empleado.fxml",
            "/Empleado.fxml",
            "pantallas/Empleado.fxml",
            "Empleado.fxml"
        };

        URL fxmlUrl = null;
        for (String ruta : rutas) {
            fxmlUrl = getClass().getResource(ruta);
            if (fxmlUrl != null) {
                System.out.println("FXML encontrado en: " + ruta);
                break;
            } else {
                System.out.println("No encontrado: " + ruta);
            }
        }

        if (fxmlUrl == null) {
            System.out.println("No se encontró el FXML en ninguna ruta.");
            System.out.println("   Verifica que Empleado.fxml esté dentro de 'resources'");
            return;
        }

        FXMLLoader loader = new FXMLLoader(fxmlUrl);
        Parent root = loader.load();
        primaryStage.setTitle("Dominos PRJ - Empleados");
        primaryStage.setScene(new Scene(root));
        primaryStage.setResizable(false);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
