$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
    $c = [System.IO.File]::ReadAllText($file.FullName)
    # Match the root element tag (first opening tag after XML declaration)
    if ($c -match '(?s)<(AnchorPane|BorderPane|VBox|HBox|StackPane|GridPane|Pane)[^>]*?prefWidth="([^"]+)"[^>]*?prefHeight="([^"]+)"') {
        Write-Host "$($file.Name): root=$($Matches[1]) w=$($Matches[2]) h=$($Matches[3])"
    } elseif ($c -match '(?s)<(AnchorPane|BorderPane|VBox|HBox|StackPane|GridPane|Pane)[^>]*?prefHeight="([^"]+)"[^>]*?prefWidth="([^"]+)"') {
        Write-Host "$($file.Name): root=$($Matches[1]) w=$($Matches[3]) h=$($Matches[2])"
    } else {
        Write-Host "$($file.Name): no prefWidth/prefHeight on root"
    }
}
