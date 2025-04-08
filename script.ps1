$logFilePath = "C:\Desktop\file_changes.log"
$directoryToWatch = "C:\"

$fsWatcher = New-Object System.IO.FileSystemWatcher
$fsWatcher.Path = $directoryToWatch
$fsWatcher.IncludeSubdirectories = $true
$fsWatcher.EnableRaisingEvents = $true

$eventHandler = {
    $eventType = $event.SourceEventArgs.ChangeType
    $affectedFile = $event.SourceEventArgs.FullPath
    $currentTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$currentTimestamp - $eventType - $affectedFile"

    Write-Host $logMessage -ForegroundColor Cyan
    Add-Content -Path $logFilePath -Value $logMessage
}

Register-ObjectEvent $fsWatcher "Changed" -Action $eventHandler
Register-ObjectEvent $fsWatcher "Created" -Action $eventHandler
Register-ObjectEvent $fsWatcher "Deleted" -Action $eventHandler
Register-ObjectEvent $fsWatcher "Renamed" -Action $eventHandler

Write-Host "Now monitoring changes in: $directoryToWatch"
Write-Host "Log file: $logFilePath"
Write-Host "Press Ctrl+C to terminate the script."

while ($true) {
    Start-Sleep 10
}
