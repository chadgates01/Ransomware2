# Define the log file path
$LogFile = "C:\Users\student\Desktop\monitor_log.txt"

# Function to monitor running processes
function Monitor-Processes {
    Write-Output "***** Process Monitoring *****"
    Write-Host "***** Process Monitoring *****"
    Write-Output "Total Running Processes: $(Get-Process | Measure-Object | Select-Object -ExpandProperty Count)"
    Write-Host "Total Running Processes: $(Get-Process | Measure-Object | Select-Object -ExpandProperty Count)"
    Write-Output "***** Top 15 CPU-Consuming Processes: *****"
    Write-Host "***** Top 15 CPU-Consuming Processes: *****"
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 15 Name, ID, CPU | Format-Table -AutoSize
    Write-Output "------------------------------------------------------------"
    Write-Host "------------------------------------------------------------"
}

# Function to monitor CPU usage
function Monitor-CPU {
    Write-Output "***** CPU Usage Monitoring *****"
    Write-Host "***** CPU Usage Monitoring *****"
    $CPUUsage = (Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
    Write-Output ("CPU Usage: {0:N2}%" -f $CPUUsage)
    Write-Host ("CPU Usage: {0:N2}%" -f $CPUUsage)
    Write-Output "------------------------------------------------------------"
    Write-Host "------------------------------------------------------------"
}

# Function to monitor RAM usage
function Monitor-RAM {
    Write-Output "***** RAM Usage Monitoring *****"
    Write-Host "***** RAM Usage Monitoring *****"
    $OS = Get-WmiObject Win32_OperatingSystem
    $UsedRAM = ($OS.TotalVisibleMemorySize - $OS.FreePhysicalMemory) / 1KB
    $TotalRAM = $OS.TotalVisibleMemorySize / 1KB
    Write-Output ("Used RAM: {0:N2} KB / Total RAM: {1:N2} KB" -f $UsedRAM, $TotalRAM)
    Write-Host ("Used RAM: {0:N2} KB / Total RAM: {1:N2} KB" -f $UsedRAM, $TotalRAM)
    Write-Output "------------------------------------------------------------"
    Write-Host "------------------------------------------------------------"
}

# Start monitoring
Write-Output "Starting Windows Resource Monitor..."
Write-Host "Logs saved to: $LogFile"
Write-Output "Logs saved to: $LogFile"
Write-Host "Logs saved to: $LogFile"

# Continuous monitoring loop
while ($true) {
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Output "********** Monitoring at $TimeStamp **********"
    Write-Host "********** Monitoring at $TimeStamp **********"

    # Log to console and to file
    Monitor-Processes | Tee-Object -FilePath $LogFile -Append
    Monitor-CPU | Tee-Object -FilePath $LogFile -Append
    Monitor-RAM | Tee-Object -FilePath $LogFile -Append

    Start-Sleep -Seconds 5
}
