$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$gradient = '-fx-background-color: linear-gradient(to bottom right, #004aad, #be1e1e);'

$targets = @('Agregar_Producto.fxml','Agregar_Sucursal.fxml','Comprobante.fxml','Ingrediente.fxml')

foreach ($folder in $folders) {
    foreach ($name in $targets) {
        $path = Join-Path $folder $name
        if (-not (Test-Path $path)) { Write-Host "Not found: $path"; continue }
        $c = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        $original = $c

        # Replace white background wherever it appears in the file (root element)
        $c = $c -replace 'style="-fx-background-color:\s*white;\s*"', "style=""$gradient"""
        # Replace #f4f4f4 or similar light backgrounds
        $c = $c -replace 'style="-fx-background-color:\s*#f4f4f4;\s*"', "style=""$gradient"""

        # If still no style on root, add it (root has xmlns=)
        $rootTags = @('AnchorPane','BorderPane','VBox','HBox','StackPane','GridPane','Pane')
        foreach ($tag in $rootTags) {
            if ($c -match "(?s)<$tag\b[^<]*xmlns=" -and $c -notmatch "(?s)<$tag\b[^<]*style=") {
                $c = [regex]::Replace($c, "(<$tag\b)", "`$1 style=""$gradient""")
                break
            }
        }

        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($path, $c, $utf8NoBom)
            Write-Host "Fixed: $name"
        } else {
            Write-Host "Already OK or unmatched: $name"
        }
    }
}
Write-Host "Done"
