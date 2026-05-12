package com.example.demo1.Controllers;

import com.example.demo1.Database.Conexion;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;
import javax.swing.JOptionPane;
import java.sql.*;

/**
 * Las tablas tbl_comprobante_fiscal y tbl_secuencia no existen en la BD.
 * Este controller está mapeado a tbl_itbs que es la tabla fiscal disponible:
 *   tbl_itbs: id_itbs (IDENTITY), categoria, tasa (decimal), desc (nullable)
 */
public class CONTROLLER_Comprobante {

    Conexion conexion = new Conexion();

    @FXML private TextField Txttipo;        // usado como "categoria"
    @FXML private TextField Txtfechaemision;
    @FXML private TextField Txtcodigo;      // no aplica a tbl_itbs
    @FXML private TextField Txtestado;      // usado como "desc"
    @FXML private TextField Txtserie;       // usado como "tasa"
    @FXML private TextField Txtsecuencia;
    @FXML private TextField txtfecha;

    @FXML
    public void initialize() {}

    /**
     * Guarda una categoría de ITBS en tbl_itbs.
     * Campos usados: Txttipo=categoria, Txtserie=tasa, Txtestado=descripcion
     */
    @FXML
    public void FnGuardarComprobante(ActionEvent actionEvent) {
        String categoria = Txttipo != null ? Txttipo.getText().trim() : "";
        String tasaStr   = Txtserie != null ? Txtserie.getText().trim() : "";
        String desc      = Txtestado != null ? Txtestado.getText().trim() : "";

        if (categoria.isEmpty() || tasaStr.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Categoría y tasa son obligatorios.");
            return;
        }

        double tasa;
        try {
            tasa = Double.parseDouble(tasaStr);
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "La tasa debe ser un número (ej: 0.18).");
            return;
        }

        String sql = "INSERT INTO tbl_itbs (categoria, tasa, [desc]) VALUES (?, ?, ?)";

        try (Connection con = conexion.establecerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, categoria);
            ps.setDouble(2, tasa);
            ps.setString(3, desc.isEmpty() ? null : desc);
            ps.executeUpdate();
            JOptionPane.showMessageDialog(null, "Registro ITBS guardado correctamente.");
            limpiarComprobante();

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error al guardar ITBS: " + e.getMessage());
        }
    }

    @FXML
    public void FnGuardarSecuencia(ActionEvent actionEvent) {
        JOptionPane.showMessageDialog(null,
                "La tabla tbl_secuencia no existe en la base de datos.\n" +
                "Use FnGuardarComprobante para registrar tasas ITBS.");
    }

    /**
     * Edita el registro ITBS encontrado por FnBuscarComprobante.
     * Requiere que Txtcodigo tenga el id_itbs.
     */
    @FXML
    public void FnEditarComprobante(ActionEvent actionEvent) {
        String idStr     = Txtcodigo  != null ? Txtcodigo.getText().trim()  : "";
        String categoria = Txttipo    != null ? Txttipo.getText().trim()     : "";
        String tasaStr   = Txtserie   != null ? Txtserie.getText().trim()    : "";
        String desc      = Txtestado  != null ? Txtestado.getText().trim()   : "";

        if (idStr.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Busque primero el registro a editar (FnBuscarComprobante).");
            return;
        }
        if (categoria.isEmpty() || tasaStr.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Categoría y tasa son obligatorios.");
            return;
        }

        double tasa;
        try { tasa = Double.parseDouble(tasaStr); }
        catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(null, "La tasa debe ser un número (ej: 0.18).");
            return;
        }

        String sql = "UPDATE tbl_itbs SET categoria=?, tasa=?, [desc]=? WHERE id_itbs=?";
        try (Connection con = conexion.establecerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, categoria);
            ps.setDouble(2, tasa);
            ps.setString(3, desc.isEmpty() ? null : desc);
            ps.setInt(4, Integer.parseInt(idStr));
            if (ps.executeUpdate() > 0) {
                JOptionPane.showMessageDialog(null, "Registro ITBS actualizado correctamente.");
                limpiarComprobante();
            } else {
                JOptionPane.showMessageDialog(null, "No se encontró el registro.");
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al actualizar: " + e.getMessage());
        }
    }

    /**
     * Elimina el registro ITBS encontrado por FnBuscarComprobante.
     */
    @FXML
    public void FnEliminarComprobante(ActionEvent actionEvent) {
        String idStr = Txtcodigo != null ? Txtcodigo.getText().trim() : "";
        if (idStr.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Busque primero el registro a eliminar.");
            return;
        }
        int confirmar = JOptionPane.showConfirmDialog(null,
                "¿Está seguro de eliminar este registro ITBS?",
                "Confirmar eliminación", JOptionPane.YES_NO_OPTION);
        if (confirmar != JOptionPane.YES_OPTION) return;

        String sql = "DELETE FROM tbl_itbs WHERE id_itbs = ?";
        try (Connection con = conexion.establecerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(idStr));
            if (ps.executeUpdate() > 0) {
                JOptionPane.showMessageDialog(null, "Registro eliminado correctamente.");
                limpiarComprobante();
            } else {
                JOptionPane.showMessageDialog(null, "No se encontró el registro.");
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al eliminar: " + e.getMessage());
        }
    }

    /**
     * Busca por categoría en tbl_itbs.
     */
    @FXML
    public void FnBuscarComprobante(ActionEvent actionEvent) {
        String categoria = Txttipo != null ? Txttipo.getText().trim() : "";
        if (categoria.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Ingrese una categoría para buscar.");
            return;
        }

        String sql = "SELECT id_itbs, categoria, tasa, [desc] FROM tbl_itbs WHERE categoria LIKE ?";

        try (Connection con = conexion.establecerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + categoria + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (Txttipo    != null) Txttipo.setText(rs.getString("categoria"));
                if (Txtserie   != null) Txtserie.setText(String.valueOf(rs.getDouble("tasa")));
                if (Txtestado  != null) Txtestado.setText(rs.getString("desc") != null ? rs.getString("desc") : "");
                if (Txtcodigo  != null) Txtcodigo.setText(String.valueOf(rs.getInt("id_itbs")));
                JOptionPane.showMessageDialog(null, "Registro encontrado.");
            } else {
                JOptionPane.showMessageDialog(null, "No se encontró ningún registro con esa categoría.");
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al buscar: " + e.getMessage());
        }
    }

    public void limpiarComprobante() {
        if (Txttipo       != null) Txttipo.clear();
        if (Txtfechaemision != null) Txtfechaemision.clear();
        if (Txtcodigo     != null) Txtcodigo.clear();
        if (Txtestado     != null) Txtestado.clear();
        if (Txtserie      != null) Txtserie.clear();
    }

    public void limpiarSecuencia() {
        if (Txtsecuencia != null) Txtsecuencia.clear();
        if (txtfecha     != null) txtfecha.clear();
    }
}
