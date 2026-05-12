$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$gradient = '-fx-background-color: linear-gradient(to bottom right, #004aad, #be1e1e);'

# Skip MainView (container) — it keeps its own style
$skip = @('MainView.fxml')

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        if ($skip -contains $file.Name) { Write-Host "Skip: $($file.Name)"; continue }

        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $original = $c

        # 1. Replace styleClass="pantalla-raiz" with inline gradient style
        $c = $c -replace 'styleClass="pantalla-raiz"', "style=""$gradient"""

        # 2. Replace any existing white background on root element
        $c = $c -replace 'style="-fx-background-color: white;"(\s+xmlns=)', "style=""$gradient""`$1"
        $c = $c -replace "style=""$gradient""(\s+xmlns=)", "style=""$gradient""`$1"

        # 3. If root element still has no style= (only xmlns), add it before xmlns
        $rootTags = 'AnchorPane','BorderPane','VBox','HBox','StackPane','GridPane','Pane'
        foreach ($tag in $rootTags) {
            # Root element: has xmlns= but no style= yet
            if ($c -match "<$tag\b[^>]*xmlns=" -and $c -notmatch "<$tag\b[^>]*style=""") {
                $c = [regex]::Replace($c, "(<$tag\b)", "`$1 style=""$gradient""")
                break
            }
        }

        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $c, $utf8NoBom)
            Write-Host "BG applied: $($file.Name)"
        } else {
            Write-Host "No change:  $($file.Name)"
        }
    }
}
Write-Host "Done"
