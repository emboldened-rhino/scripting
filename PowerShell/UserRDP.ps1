# Purpose: Create RDP connection file on the current user's desktop

$RemoteComputer = Read-Host "Enter the server name or IP"
$ShortcutName = Read-Host "Enter the RDP shortcut name"

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$RdpPath = Join-Path $DesktopPath "$ShortcutName.rdp"

$RdpSettings = @"
full address:s:$RemoteComputer
prompt for credentials:i:1 
authentication level:i:2
enablecredsspsupport:i:1
screen mode id:i:2
use multimon:i:0
redirectclipboard:i:1
redirectprinters:i:0
redirectdrives:i:0
"@

try {
    Set-Content `
        -Path $RdpPath `
        -Value $RdpSettings `
        -Encoding ASCII `
        -ErrorAction Stop

    Write-Host "RDP connection created successfully." -ForegroundColor Green
    Write-Host $RdpPath
}
catch {
    Write-Host "Failed to create the RDP connection." -ForegroundColor Red
    Write-Host $_.Exception.Message
}
