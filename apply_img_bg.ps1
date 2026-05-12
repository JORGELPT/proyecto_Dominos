$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$skip = @('Login.fxml', 'Inicio.fxml', 'MainView.fxml')

$imgBlock = "    <ImageView fitHeight=`"591.0`" fitWidth=`"1003.0`" layoutY=`"-12.0`" pickOnBounds=`"true`" preserveRatio=`"true`">
        <image>
            <Image url=`"@../imagenes/Gemini_Generated_Image_gs941ggs941ggs94.png`"/>
        </image>
    </ImageView>"

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        if ($skip -contains $file.Name) { Write-Host "Skip: $($file.Name)"; continue }

        $c = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
        $original = $c

        # 1. Remove <?import java.lang.String?> (leftover from CSS changes)
        $c = [regex]::Replace($c, '\r?\n\s*<\?import java\.lang\.String\?>', '')

        # 2. Add image imports right after <?xml ...?> line if not already present
        if ($c -notmatch 'import javafx\.scene\.image\.ImageView') {
            $c = [regex]::Replace($c,
                '(<\?xml version="1\.0" encoding="UTF-8"\?>)',
                '$1' + [System.Environment]::NewLine +
                '<?import javafx.scene.image.Image?>' + [System.Environment]::NewLine +
                '<?import javafx.scene.image.ImageView?>')
        }

        # 3. Remove gradient or white inline background from root element
        $c = [regex]::Replace($c, '\s*style="-fx-background-color: linear-gradient[^"]*;"', '')
        $c = [regex]::Replace($c, '\s*style="-fx-background-color:\s*white;"', '')

        # 4. Remove styleClass="pantalla-raiz" from root (CSS won't load)
        $c = [regex]::Replace($c, '\s*styleClass="pantalla-raiz"', '')

        # 5. Insert ImageView as first child — only if not already present
        if ($c -notmatch 'Gemini_Generated_Image_gs941ggs941ggs94') {

            # AnchorPane root: insert right after the root opening tag's closing >
            # Pattern: match from xmlns:fx="..." to the first > that closes the root tag
            if ($c -match '<AnchorPane\b') {
                $c = [regex]::Replace($c,
                    '(?s)(xmlns:fx="http://javafx\.com/fxml/1"[^>]*>)',
                    '$1' + [System.Environment]::NewLine + $imgBlock)
            }
            # BorderPane root: wrap content in StackPane with ImageView behind
            elseif ($c -match '<BorderPane\b') {
                # Get the fx:controller value
                $ctrl = [regex]::Match($c, 'fx:controller="([^"]+)"').Groups[1].Value
                $xmlns1 = [regex]::Match($c, 'xmlns="([^"]+)"').Groups[1].Value
                # Replace root BorderPane tag: move xmlns/controller to new StackPane root
                $c = [regex]::Replace($c,
                    '(<BorderPane\b[^>]*xmlns="[^"]*"[^>]*>)',
                    '<StackPane xmlns="' + $xmlns1 + '" xmlns:fx="http://javafx.com/fxml/1" fx:controller="' + $ctrl + '">' + [System.Environment]::NewLine +
                    $imgBlock + [System.Environment]::NewLine + '    <BorderPane>')
                # Remove xmlns/fx:controller from the inner BorderPane
                $c = [regex]::Replace($c, '(<BorderPane\b[^>]*?) xmlns="[^"]*"', '$1')
                $c = [regex]::Replace($c, '(<BorderPane\b[^>]*?) xmlns:fx="[^"]*"', '$1')
                $c = [regex]::Replace($c, '(<BorderPane\b[^>]*?) fx:controller="[^"]*"', '$1')
                # Close the StackPane before the file ends
                $c = [regex]::Replace($c, '(</BorderPane>\s*)$', '$1</StackPane>')
            }
        }

        if ($c -ne $original) {
            [System.IO.File]::WriteAllText($file.FullName, $c, $utf8NoBom)
            Write-Host "Done: $($file.Name)"
        } else {
            Write-Host "No change: $($file.Name)"
        }
    }
    Write-Host "--- $folder done ---"
}
Write-Host "All finished"
