$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)
foreach ($folder in $folders) {
    $f = Join-Path $folder 'Login.fxml'
    $c = [System.IO.File]::ReadAllText($f, [System.Text.Encoding]::UTF8)
    $old = 'style="-fx-background-color: white;" xmlns="http://javafx.com/javafx/25" xmlns:fx="http://javafx.com/fxml/1" fx:controller="com.example.demo1.Controllers.CONTROLLER_Login"'
    $new = 'style="-fx-background-color: linear-gradient(to bottom right, #004aad, #be1e1e);" xmlns="http://javafx.com/javafx/25" xmlns:fx="http://javafx.com/fxml/1" fx:controller="com.example.demo1.Controllers.CONTROLLER_Login"'
    $c = $c.Replace($old, $new)
    [System.IO.File]::WriteAllText($f, $c, [System.Text.Encoding]::UTF8)
    Write-Host "Fixed Login: $f"
}
