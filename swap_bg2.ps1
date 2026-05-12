$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$oldImg = 'Gemini_Generated_Image_qnspp1qnspp1qnsp.png'
$newImg = 'fondop.png'

$targets = @('Ingrediente.fxml', 'Inicio.fxml')
foreach ($name in $targets) {
    $path = Join-Path $folder $name
    $c = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    if ($c -match [regex]::Escape($oldImg)) {
        $c = $c.Replace($oldImg, $newImg)
        [System.IO.File]::WriteAllText($path, $c, $utf8NoBom)
        Write-Host "Actualizado: $name"
    } else {
        Write-Host "Sin cambio: $name"
    }
}
Write-Host "Listo"
