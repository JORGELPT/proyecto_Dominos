$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Colores de campos: blanco semitransparente (facil de leer, no fatiga visual)
$fieldStyle = '-fx-background-color: rgba(255,255,255,0.88); -fx-background-radius: 8; -fx-text-fill: #1a1a1a; -fx-font-size: 13px;'
# Contenedor del formulario: oscuro semitransparente para que el texto blanco resalte
$cardStyle  = '-fx-background-color: rgba(0,0,0,0.48); -fx-background-radius: 14; -fx-padding: 10;'

foreach ($f in Get-ChildItem $folder -Filter '*.fxml') {
    $c = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $orig = $c

    # ── 1. TITULOS Y LABELS: poner texto blanco ─────────────────────────────
    # Colores que se convierten a blanco (titulos, labels de campo, subtitulos)
    # Se respetan: #be1e1e (error rojo), #d70000 (emoji pizza rojo), white/WHITE ya son blancos
    $coloresToBlancos = @('#004aad','#333333','#333','#666666','#888888','#999999','#999','#555','#444')
    foreach ($col in $coloresToBlancos) {
        $c = $c -replace ('textFill="' + [regex]::Escape($col) + '"'), 'textFill="white"'
    }
    # textFill dentro de style= (ej: -fx-text-fill: #004aad)
    $c = [regex]::Replace($c, '-fx-text-fill:\s*#004aad', '-fx-text-fill: white')
    $c = [regex]::Replace($c, '-fx-text-fill:\s*#333(333)?', '-fx-text-fill: white')

    # ── 2. TEXTFIELD / PASSWORDFIELD ────────────────────────────────────────
    # Reemplaza cualquier style que tenga background #CCCCCC o #f0f0f0 en un TextField/PasswordField
    $c = [regex]::Replace($c,
        '(<(?:TextField|PasswordField)[^/]*)style="[^"]*-fx-background-color:\s*(?:#CCCCCC|#cccccc|#f0f0f0|#eeeeee)[^"]*"',
        ('$1style="' + $fieldStyle + '"'))

    # ── 3. COMBOBOX ──────────────────────────────────────────────────────────
    $c = [regex]::Replace($c,
        '(<ComboBox[^/]*)style="[^"]*-fx-background-color:\s*(?:#CCCCCC|#cccccc|#f0f0f0|#eeeeee)[^"]*"',
        ('$1style="' + $fieldStyle + '"'))

    # ── 4. TEXTAREA ───────────────────────────────────────────────────────────
    $c = [regex]::Replace($c,
        '(<TextArea[^/]*)style="[^"]*-fx-background-color:\s*(?:#CCCCCC|#cccccc|#f0f0f0|#eeeeee|white)[^"]*"',
        ('$1style="' + $fieldStyle + '"'))

    # ── 5. DATEPICKER ─────────────────────────────────────────────────────────
    $c = [regex]::Replace($c,
        '(<DatePicker[^/]*)style="[^"]*-fx-background-color:\s*(?:#CCCCCC|#cccccc|#f0f0f0|#eeeeee)[^"]*"',
        ('$1style="' + $fieldStyle + '"'))

    # ── 6. CONTENEDOR FORM (VBox con styleClass="form-card") ─────────────────
    # Agrega o reemplaza el style del VBox que contiene el formulario
    # Solo el primer VBox hijo del AnchorPane (el contenedor principal)
    $c = [regex]::Replace($c,
        '(<VBox[^>]*styleClass="form-card"[^>]*)(/>|>)',
        { param($m)
            $tag = $m.Value
            # Quitar style= existente del tag si tiene uno
            $tag = [regex]::Replace($tag, '\s*style="[^"]*"', '')
            # Insertar el nuevo style antes del cierre del tag
            $tag -replace '(/?>)', (' style="' + $cardStyle + '"$1')
        })

    if ($c -ne $orig) {
        [System.IO.File]::WriteAllText($f.FullName, $c, $utf8NoBom)
        Write-Host "Actualizado: $($f.Name)"
    } else {
        Write-Host "Sin cambio:  $($f.Name)"
    }
}
Write-Host "Listo"
