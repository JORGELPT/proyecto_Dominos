$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
    $c = [System.IO.File]::ReadAllText($file.FullName)
    if ($c -match '<(AnchorPane|BorderPane|VBox|HBox|StackPane|GridPane|Pane)\b') {
        Write-Host "$($file.Name): $($Matches[1])"
    }
}
