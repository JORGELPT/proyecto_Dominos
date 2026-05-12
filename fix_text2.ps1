$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $original = $c

        # Quitar emojis de textos de botones: "text="[emoji]  Word"" -> "text="Word""
        # El patron [^"]* casa con cualquier char incluyendo emojis en .NET
        $c = [regex]::Replace($c, 'text="[^"]+  Guardar"',   'text="Guardar"')
        $c = [regex]::Replace($c, 'text="[^"]+  Eliminar"',  'text="Eliminar"')
        $c = [regex]::Replace($c, 'text="[^"]+  Editar"',    'text="Editar"')
        $c = [regex]::Replace($c, 'text="[^"]+  Limpiar"',   'text="Limpiar"')
        $c = [regex]::Replace($c, 'text="[^"]+  Buscar"',    'text="Buscar"')
        $c = [regex]::Replace($c, 'text="[^"]+  Iniciar',    'text="Iniciar')
        $c = [regex]::Replace($c, 'text="[^"]+  AGREGAR',    'text="AGREGAR')
        $c = [regex]::Replace($c, 'text="[^"]+  APERTURA',   'text="APERTURA')
        $c = [regex]::Replace($c, 'text="[^"]+  MANTENIMIENTO', 'text="MANTENIMIENTO')
        $c = [regex]::Replace($c, 'text="[^"]+  REGISTRAR',  'text="REGISTRAR')
        $c = [regex]::Replace($c, 'text="[^"]+  INVENTARIO', 'text="INVENTARIO')
        $c = [regex]::Replace($c, 'text="[^"]+  HACER',      'text="HACER')
        # Login: el boton "Iniciar Sesion" original no tenia emoji, solo cambiar si tiene prefijo
        # Titulo Login
        $c = [regex]::Replace($c, 'text="[^"]+  Iniciar Sesi', 'text="Iniciar Sesi')

        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $c, [System.Text.Encoding]::UTF8)
            Write-Host "Fixed: $($file.Name)"
        } else {
            Write-Host "No change: $($file.Name)"
        }
    }
}
Write-Host "Done"
