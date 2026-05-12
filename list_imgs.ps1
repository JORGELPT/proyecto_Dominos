$folder = 'C:\Users\jorge\IdeaProjects\demo1\.idea\example\demo1\imagenes'
foreach ($f in Get-ChildItem $folder) {
    $kb = [math]::Round($f.Length / 1KB, 1)
    Write-Host "$($f.Name)  ($kb KB)"
}
