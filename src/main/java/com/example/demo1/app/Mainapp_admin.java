package com.example.demo1.app;

import com.example.demo1.Utils.CONTROLLER_Seccion;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 * Clase principal de Domino's Pizza.
 *
 * MODO DESARROLLO: cambia ROL_ACTIVO a cualquiera de los valores
 * disponibles para probar los permisos de cada rol sin pasar por el Login.
 *
 * Roles disponibles:
 *   ROL_ADMIN    → acceso total
 *   ROL_GERENTE  → todo excepto crear usuarios
 *   ROL_CAJERO   → insertar y buscar solamente
 *   ROL_DELIVERY → solo ve y gestiona envíos
 *   ROL_CLIENTE  → solo pedidos y reclamaciones
 *
 * Para producción: cambia ROL_ACTIVO = ROL_PRODUCCION
 */
public class Mainapp_admin extends Application {

    // ── Roles disponibles ───────────────────────────────────────────────────
    private static final String ROL_ADMIN      = "admin";
    private static final String ROL_GERENTE    = "gerente";
    private static final String ROL_CAJERO     = "cajero";
    private static final String ROL_DELIVERY   = "delivery";
    private static final String ROL_CLIENTE    = "cliente";
    private static final String ROL_PRODUCCION = null;   // null → abre el Login real

    // ┌─────────────────────────────────────────────────────────────────────┐
    // │  CAMBIA ESTA LÍNEA para probar cada rol:                            │
    // │    ROL_ADMIN | ROL_GERENTE | ROL_CAJERO | ROL_DELIVERY | ROL_CLIENTE│
    // │  Para producción usa: ROL_PRODUCCION                                │
    // └─────────────────────────────────────────────────────────────────────┘
    private static final String ROL_ACTIVO = ROL_ADMIN;

    // ── Datos de sesión simulados por rol ───────────────────────────────────
    // { rol, idPersona, idEmpleado, idCliente, nombre, email }
    private static final Object[][] SESIONES = {
            { ROL_ADMIN,    1,  1, -1, "Administrador",    "admin@dominos.com"    },
            { ROL_GERENTE,  2,  2, -1, "Gerente Sucursal", "gerente@dominos.com"  },
            { ROL_CAJERO,   3,  3, -1, "Cajero Ventas",    "cajero@dominos.com"   },
            { ROL_DELIVERY, 4,  4, -1, "Repartidor Pizza", "delivery@dominos.com" },
            { ROL_CLIENTE,  5, -1,  1, "Cliente Ejemplo",  ""                     },
    };

    // -----------------------------------------------------------------------
    @Override
    public void start(Stage stage) throws Exception {

        // Modo producción: abrir Login normal
        if (ROL_ACTIVO == null) {
            abrirLogin(stage);
            return;
        }

        // Modo dev: iniciar sesión automática con el rol seleccionado
        iniciarSesionDev(ROL_ACTIVO);

        FXMLLoader loader = new FXMLLoader(
                getClass().getResource("/com/example/demo1/Pantallas/MainView.fxml"));
        Parent root = loader.load();

        Scene scene = new Scene(root);
        stage.setTitle("Domino's Pizza [DEV - " + ROL_ACTIVO.toUpperCase() + "]");
        stage.setMaximized(true);
        stage.setResizable(true);
        stage.setScene(scene);
        stage.show();
    }

    // -----------------------------------------------------------------------
    //  Busca el rol en SESIONES e inicia la sesión simulada
    // -----------------------------------------------------------------------
    private void iniciarSesionDev(String rol) {
        for (Object[] s : SESIONES) {
            if (s[0].equals(rol)) {
                CONTROLLER_Seccion.getInstancia().iniciar(
                        (int)    s[1],  // idPersona
                        (int)    s[2],  // idEmpleado
                        (int)    s[3],  // idCliente
                        (String) s[4],  // nombre
                        (String) s[0],  // rol
                        (String) s[5]   // email
                );
                return;
            }
        }
        throw new IllegalArgumentException("ROL_ACTIVO no reconocido: " + rol);
    }

    // -----------------------------------------------------------------------
    //  Abre el Login (modo producción)
    // -----------------------------------------------------------------------
    private void abrirLogin(Stage stage) throws Exception {
        FXMLLoader loader = new FXMLLoader(
                getClass().getResource("/com/example/demo1/Pantallas/Login.fxml"));
        Parent root = loader.load();

        Scene scene = new Scene(root, 1000, 650);
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
