$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Sizes per file
$fileSizes = @{
    'MainView.fxml' = @{ W = '1100.0'; H = '700.0' }
    'Login.fxml'    = @{ W = '900.0';  H = '600.0' }
}
$defaultW = '900.0'
$defaultH = '580.0'

$rootTags = 'AnchorPane','BorderPane','VBox','HBox','StackPane','GridPane','Pane'

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $original = $c

        $sizes = if ($fileSizes.ContainsKey($file.Name)) { $fileSizes[$file.Name] } else { @{ W = $defaultW; H = $defaultH } }
        $W = $sizes.W
        $H = $sizes.H

        foreach ($tag in $rootTags) {
            # If root already has prefWidth and prefHeight, replace their values
            $c = [regex]::Replace($c, "(<$tag\b[^>]*?)prefWidth=""[^""]*""", "`$1prefWidth=""$W""")
            $c = [regex]::Replace($c, "(<$tag\b[^>]*?)prefHeight=""[^""]*""", "`$1prefHeight=""$H""")

            # If root has prefWidth but not prefHeight, add prefHeight
            if ($c -match "<$tag\b[^>]*?prefWidth=""[^""]*""" -and $c -notmatch "<$tag\b[^>]*?prefHeight=""") {
                $c = [regex]::Replace($c, "(<$tag\b[^>]*?prefWidth=""[^""]*"")", "`$1 prefHeight=""$H""")
            }
            # If root has prefHeight but not prefWidth, add prefWidth
            if ($c -match "<$tag\b[^>]*?prefHeight=""[^""]*""" -and $c -notmatch "<$tag\b[^>]*?prefWidth=""") {
                $c = [regex]::Replace($c, "(<$tag\b[^>]*?prefHeight=""[^""]*"")", "`$1 prefWidth=""$W""")
            }
            # If root has neither, add both after the tag name
            if ($c -match "<$tag\b" -and $c -notmatch "<$tag\b[^>]*?prefWidth=""") {
                $c = [regex]::Replace($c, "(<$tag\b)", "`$1 prefWidth=""$W"" prefHeight=""$H""")
            }
        }

        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $c, $utf8NoBom)
            Write-Host "Updated: $($file.Name) -> ${W}x${H}"
        } else {
            Write-Host "No change: $($file.Name)"
        }
    }
}
Write-Host "Done"
