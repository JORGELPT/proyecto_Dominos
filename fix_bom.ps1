$folders = @(
    'C:\Users\jorge\IdeaProjects\demo1\target\classes\com\example\demo1\Pantallas',
    'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($folder in $folders) {
    foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
        $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
        # Check for UTF-8 BOM: EF BB BF
        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            $text = [System.Text.Encoding]::UTF8.GetString($bytes, 3, $bytes.Length - 3)
            [System.IO.File]::WriteAllText($file.FullName, $text, $utf8NoBom)
            Write-Host "Removed BOM: $($file.Name)"
        } else {
            Write-Host "No BOM: $($file.Name)"
        }
    }
}
Write-Host "Done"
