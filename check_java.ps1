$files = Get-ChildItem 'C:\Users\jorge\IdeaProjects\demo1\src' -Recurse -Filter '*.java'
foreach ($f in $files) {
    $lines = (Get-Content $f.FullName -ErrorAction SilentlyContinue).Count
    if ($lines -le 3) {
        Write-Host "$lines linea(s): $($f.Name)"
    }
}
Write-Host "Revision completa"
