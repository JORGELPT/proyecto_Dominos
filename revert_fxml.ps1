$TARGET = 'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas'
$SOURCE = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'

$replacements = @(
    @{ Old = 'styleClass="btn-guardar" prefWidth="110.0" prefHeight="35.0"'; New = 'prefWidth="80.0" prefHeight="32.0" style="-fx-background-color: #8ee78e; -fx-text-fill: #1a5f1a; -fx-font-weight: bold; -fx-background-radius: 20; -fx-cursor: hand;"' },
    @{ Old = 'styleClass="btn-eliminar" prefWidth="110.0" prefHeight="35.0"'; New = 'prefWidth="80.0" prefHeight="32.0" style="-fx-background-color: #ffc0c0; -fx-text-fill: #8b0000; -fx-font-weight: bold; -fx-background-radius: 20; -fx-cursor: hand;"' },
    @{ Old = 'styleClass="btn-editar" prefWidth="110.0" prefHeight="35.0"';   New = 'prefWidth="80.0" prefHeight="32.0" style="-fx-background-color: #ffdf7e; -fx-text-fill: #8b6914; -fx-font-weight: bold; -fx-background-radius: 20; -fx-cursor: hand;"' },
    @{ Old = 'styleClass="btn-buscar" prefWidth="40.0" prefHeight="35.0"';    New = 'prefWidth="40.0" prefHeight="32.0" style="-fx-background-color: #be1e1e; -fx-text-fill: white; -fx-background-radius: 50; -fx-cursor: hand;"' },
    @{ Old = 'styleClass="btn-buscar" prefWidth="40.0" prefHeight="32.0"';    New = 'prefWidth="40.0" prefHeight="32.0" style="-fx-background-color: #be1e1e; -fx-text-fill: white; -fx-background-radius: 50; -fx-cursor: hand;"' },
    @{ Old = 'styleClass="btn-buscar" prefWidth="110.0" prefHeight="35.0"';   New = 'prefWidth="80.0" prefHeight="32.0" style="-fx-background-color: #d4e6ff;" textFill="#004aad"' },
    @{ Old = 'styleClass="btn-limpiar" prefWidth="110.0" prefHeight="35.0"';  New = 'prefWidth="80.0" prefHeight="32.0" style="-fx-background-color: #d4e6ff;" textFill="#004aad"' },
    @{ Old = 'styleClass="btn-secundario"'; New = 'style="-fx-background-color: #b8d4ff; -fx-text-fill: #004aad; -fx-font-weight: bold; -fx-font-size: 14px; -fx-background-radius: 20; -fx-cursor: hand;"' },
    @{ Old = 'text="Guardar" onAction'; New = 'text="Guardar" onAction' }
)

# Fix button text: remove emoji prefixes
$textReplacements = @(
    @{ Old = [char]0x1F4BE + '  Guardar'; New = 'Guardar' },
    @{ Old = [char]0x1F5D1 + [char]0xFE0F + '  Eliminar'; New = 'Eliminar' },
    @{ Old = [char]0x270F + [char]0xFE0F + '  Editar'; New = 'Editar' },
    @{ Old = [char]0x1F527 + '  Agregar'; New = 'Agregar' },
    @{ Old = [char]0x1F527 + '  AGREGAR'; New = 'AGREGAR' },
    @{ Old = [char]0x1F4BC + '  AGREGAR'; New = 'AGREGAR' },
    @{ Old = [char]0x1F9C2 + '  AGREGAR'; New = 'AGREGAR' },
    @{ Old = [char]0x1F6A8 + '  REGISTRAR'; New = 'REGISTRAR' },
    @{ Old = [char]0x1F4B0 + '  APERTURA'; New = 'APERTURA' },
    @{ Old = [char]0x1F529 + '  MANTENIMIENTO'; New = 'MANTENIMIENTO' },
    @{ Old = [char]0x26A0 + [char]0xFE0F + '  HACER'; New = 'HACER' },
    @{ Old = [char]0x26A0 + [char]0xFE0F + '  REGISTRAR'; New = 'REGISTRAR' },
    @{ Old = [char]0x1F4E6 + '  INVENTARIO'; New = 'INVENTARIO' },
    @{ Old = [char]0x1F464 + '  AGREGAR'; New = 'AGREGAR' },
    @{ Old = [char]0x1F469 + [char]0x200D + [char]0x1F373 + '  AGREGAR'; New = 'AGREGAR' },
    @{ Old = [char]0x1F6A2 + '  AGREGAR'; New = 'AGREGAR' },
    @{ Old = [char]0x1F511 + '  Iniciar'; New = 'Iniciar' },
    @{ Old = [char]0x1F9C2 + '  Buscar'; New = 'Buscar' },
    @{ Old = [char]0x1F9F9 + '  Limpiar'; New = 'Limpiar' }
)

foreach ($folder in @($TARGET, $SOURCE)) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $original = $c
        foreach ($r in $replacements) {
            $c = $c.Replace($r.Old, $r.New)
        }
        foreach ($r in $textReplacements) {
            $c = $c.Replace($r.Old, $r.New)
        }
        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
            Write-Host "Changed: $($file.Name)"
        } else {
            Write-Host "No change: $($file.Name)"
        }
    }
}
Write-Host "All done"
