$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$oldImg = 'Gemini_Generated_Image_gs941ggs941ggs94.png'
$newImg = 'fondop.png'

foreach ($f in Get-ChildItem $folder -Filter '*.fxml') {
    $c = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    if ($c -match [regex]::Escape($oldImg)) {
        $c = $c.Replace($oldImg, $newImg)
        [System.IO.File]::WriteAllText($f.FullName, $c, $utf8NoBom)
        Write-Host "Actualizado: $($f.Name)"
    } else {
        Write-Host "Sin cambio:  $($f.Name)"
    }
}
Write-Host "Listo"
