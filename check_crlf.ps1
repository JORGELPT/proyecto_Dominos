# Detecta archivos que NO tienen ningun salto de linea real (\n)
$files = Get-ChildItem 'C:\Users\jorge\IdeaProjects\demo1\src' -Recurse -Filter '*.java'
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $hasLF = $bytes -contains 10   # \n = LF
    $hasCR = $bytes -contains 13   # \r = CR
    if (-not $hasLF -and -not $hasCR) {
        Write-Host "SIN SALTOS (1 linea real): $($f.Name)"
    } elseif (-not $hasLF -and $hasCR) {
        Write-Host "Solo CR (\r): $($f.Name)"
    }
}
Write-Host "Listo"
