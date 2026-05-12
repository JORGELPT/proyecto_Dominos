module com.example.demo1 {

    // JavaFX
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;

    // SQL
    requires java.sql;

    // JOptionPane (javax.swing)
    requires java.desktop;

    // JasperReports (jar sin módulo → unnamed module)
    requires jasperreports;
    requires java.naming;
    requires java.xml;

    // JFreeChart (jar sin módulo → unnamed module)
    requires jfreechart;

    // Abre los paquetes al módulo de FXML y de JavaFX
    opens com.example.demo1             to javafx.fxml, javafx.graphics;
    opens com.example.demo1.Controllers to javafx.fxml;
    opens com.example.demo1.app         to javafx.fxml, javafx.graphics;

    // Exporta los paquetes principales
    exports com.example.demo1;
    exports com.example.demo1.app;

    opens com.example.demo1.Utils to javafx.fxml;
}
