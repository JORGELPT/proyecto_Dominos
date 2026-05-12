package com.example.demo1.Controllers;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.StackPane;
import java.io.IOException;
import java.net.URL;

public class CONTROLLER_inicio {

    private static final String RUTA_PANTALLAS = "/com/example/demo1/Pantallas/";

    @FXML
    public void initialize() {}

    @FXML
    private void abrirRegistrarPedido(MouseEvent event) {
        cargarEnContentArea(event, "Hacer_Un_Pedido.fxml", "Hacer un Pedido");
    }

    @FXML
    private void abrirReclamacion(MouseEvent event) {
        cargarEnContentArea(event, "Reclamacion.fxml", "Reclamación de Pedido");
    }

    @FXML
    private void abrirRegistrarCliente(MouseEvent event) {
        cargarEnContentArea(event, "Agregar_Cliente.fxml", "Registrar Cliente");
    }

    private void cargarEnContentArea(MouseEvent event, String fxmlFile, String titulo) {
        try {
            // Buscar contentArea usando la escena (más robusto que subir por el árbol)
            Node nodo = (Node) event.getSource();
            StackPane contentArea = (StackPane) nodo.getScene().lookup("#contentArea");
            if (contentArea == null) {
                mostrarAviso("No se pudo localizar el área de contenido.");
                return;
            }

            URL url = getClass().getResource(RUTA_PANTALLAS + fxmlFile);
            if (url == null) {
                mostrarAviso("La pantalla '" + titulo + "' aún no está implementada.");
                return;
            }

            FXMLLoader loader = new FXMLLoader(url);
            Node vista = loader.load();
            contentArea.getChildren().setAll(vista);

        } catch (IOException e) {
            mostrarAviso("Error al abrir '" + titulo + "': " + e.getMessage());
        }
    }

    private void mostrarAviso(String mensaje) {
        Alert alert = new Alert(AlertType.INFORMATION);
        alert.setTitle("Aviso");
        alert.setHeaderText(null);
        alert.setContentText(mensaje);
        alert.showAndWait();
    }
}
