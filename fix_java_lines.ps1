# Agrega saltos de linea a archivos Java que estan en una sola linea real
# Estrategia:
#   1. \n antes de cada '//' que no sea '://' (URLs)
#   2. \n despues de ';' fuera de strings (para legibilidad y separar imports)
#   3. \n despues de '{' y antes de '}'

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$skip = @('module-info.java', 'Mainapp_admin.java')  # ya corregidos

$files = Get-ChildItem 'C:\Users\jorge\IdeaProjects\demo1\src' -Recurse -Filter '*.java'

foreach ($f in $files) {
    if ($skip -contains $f.Name) { Write-Host "Skip: $($f.Name)"; continue }

    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $hasLF = $bytes -contains 10
    $hasCR = $bytes -contains 13
    if ($hasLF -or $hasCR) { Write-Host "OK (ya tiene saltos): $($f.Name)"; continue }

    $c = [System.Text.Encoding]::UTF8.GetString($bytes)

    # Paso 1: \n antes de cada '//' que NO sea '://'
    $c = [regex]::Replace($c, '(?<!:)//', "`n//")

    # Paso 2: \n despues de ';' (cubre imports, declaraciones, etc.)
    # Excepto cuando ';' esta dentro de un for (heuristica: no tocar '; ' seguido de otro ';')
    # Reemplaza '; ' por ';\n' cuando el ';' NO esta seguido de otro ';' muy cerca
    $c = [regex]::Replace($c, ';(?!\s*;)(\s+)(?=[a-zA-Z@/\*\n])', ";`n")

    # Paso 3: \n despues de '{' y antes de '}'
    $c = [regex]::Replace($c, '\{(\s+)', "{`n")
    $c = [regex]::Replace($c, '(\s+)\}', "`n}")

    [System.IO.File]::WriteAllText($f.FullName, $c, $utf8NoBom)
    Write-Host "Fixed: $($f.Name)"
}
Write-Host "Listo"
