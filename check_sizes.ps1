$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\Pantallas'
foreach ($file in Get-ChildItem $folder -Filter '*.fxml') {
    if ($file.Name -eq 'MainView.fxml') { continue }
    $c = [System.IO.File]::ReadAllText($file.FullName)
    $w = ''
    $h = ''
    if ($c -match 'prefWidth="([^"]+)"') { $w = $Matches[1] }
    if ($c -match 'prefHeight="([^"]+)"') { $h = $Matches[1] }
    Write-Host "$($file.Name): w=$w h=$h"
}
