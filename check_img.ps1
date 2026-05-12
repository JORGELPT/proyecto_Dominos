$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
foreach ($f in Get-ChildItem $folder -Filter '*.fxml') {
    $c = [System.IO.File]::ReadAllText($f.FullName)
    if ($c -match 'Gemini_Generated_Image') {
        Write-Host "CON imagen: $($f.Name)"
    } else {
        Write-Host "SIN imagen: $($f.Name)"
    }
}
