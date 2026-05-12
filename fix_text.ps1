$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)

# Map: emoji sequence -> replacement text
$map = @{
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F4BE) + "  Guardar`"") = 'text="Enviar"'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F5D1) + [char]0xFE0F + "  Eliminar`"") = 'text="Eliminar"'
    ("text=`"" + [char]0x270F + [char]0xFE0F + "  Editar`"") = 'text="Editar"'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F9F9) + "  Limpiar`"") = 'text="Limpiar"'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F50D) + "  Buscar`"") = 'text="Buscar"'
    ("text=`"" + [char]0x1F511 + "  Iniciar") = 'text="Iniciar'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F4A1) + "  AGREGAR") = 'text="AGREGAR'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F9C2) + "  AGREGAR") = 'text="AGREGAR'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F464) + "  AGREGAR") = 'text="AGREGAR'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F9C2) + "  Buscar") = 'text="Buscar'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F4E6) + "  INVENTARIO") = 'text="INVENTARIO'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F4B0) + "  APERTURA") = 'text="APERTURA'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F529) + "  MANTENIMIENTO") = 'text="MANTENIMIENTO'
    ("text=`"" + [char]0x26A0 + [char]0xFE0F + "  REGISTRAR") = 'text="REGISTRAR'
    ("text=`"" + [char]0x26A0 + [char]0xFE0F + "  HACER") = 'text="HACER'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F527) + "  AGREGAR") = 'text="AGREGAR'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F6A2) + "  AGREGAR") = 'text="AGREGAR'
    ("text=`"" + [System.Char]::ConvertFromUtf32(0x1F6A8) + "  REGISTRAR") = 'text="REGISTRAR'
}

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $changed = $false
        foreach ($entry in $map.GetEnumerator()) {
            if ($c.Contains($entry.Key)) {
                $c = $c.Replace($entry.Key, $entry.Value)
                $changed = $true
            }
        }
        if ($changed) {
            [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
            Write-Host "Fixed: $($file.Name)"
        }
    }
}
Write-Host "Done"
