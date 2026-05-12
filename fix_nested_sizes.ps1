$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Tags that should only have prefWidth/prefHeight on the ROOT element
$nestedTags = @('VBox','HBox','StackPane','GridPane','Pane')

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $original = $c

        foreach ($tag in $nestedTags) {
            # Remove prefWidth="900.0" prefHeight="580.0" added right after tag name (non-root pattern)
            # These were injected by the previous script on nested elements
            $c = [regex]::Replace($c, "(<$tag\b)\s+prefWidth=""900\.0""\s+prefHeight=""580\.0""", '$1')
            # Remove prefWidth="1100.0" prefHeight="700.0" (MainView inner elements)
            $c = [regex]::Replace($c, "(<$tag\b)\s+prefWidth=""1100\.0""\s+prefHeight=""700\.0""", '$1')
            # Remove prefWidth="900.0" prefHeight="600.0" (Login inner elements)
            $c = [regex]::Replace($c, "(<$tag\b)\s+prefWidth=""900\.0""\s+prefHeight=""600\.0""", '$1')
            # Also handle if they appear in reverse order
            $c = [regex]::Replace($c, "(<$tag\b)\s+prefHeight=""580\.0""\s+prefWidth=""900\.0""", '$1')
            $c = [regex]::Replace($c, "(<$tag\b)\s+prefHeight=""700\.0""\s+prefWidth=""1100\.0""", '$1')
            $c = [regex]::Replace($c, "(<$tag\b)\s+prefHeight=""600\.0""\s+prefWidth=""900\.0""", '$1')
        }

        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $c, $utf8NoBom)
            Write-Host "Fixed nested sizes: $($file.Name)"
        } else {
            Write-Host "No change: $($file.Name)"
        }
    }
}
Write-Host "Done"
