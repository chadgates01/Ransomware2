
$logFile = "C:\Desktop\file_changes.log"  
$watchPath = "C:\"  

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $watchPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$action = {
    $eventType = $event.SourceEventArgs.ChangeType
    $filePath = $event.SourceEventArgs.FullPath
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $eventType - $filePath"

    Write-Host $logEntry -ForegroundColor Green

    Add-Content -Path $logFile -Value $logEntry
}

Register-ObjectEvent $watcher "Changed" -Action $action
Register-ObjectEvent $watcher "Created" -Action $action
Register-ObjectEvent $watcher "Deleted" -Action $action
Register-ObjectEvent $watcher "Renamed" -Action $action

Write-Host "Monitoring $watchPath for changes. Logging to $logFile..."
Write-Host "Press Ctrl+C to stop the script."

while ($true) { Start-Sleep 10 }