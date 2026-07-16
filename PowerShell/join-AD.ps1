#Requires -RunAsAdministrator

# Purpose: Provisioning brand new Windows devices to AD

# On new devices - Unblock-File -Path "<path>"
# & "<path>"

$DomainName = ""
$OUPath = "OU=,OU=,DC=,DC="

$ComputerName = (Read-Host "Enter asset tag").Trim()

# Verify computer name isn't blank 
if ([string]::IsNullOrWhiteSpace($ComputerName)) {
  Write-Host "Computer name cannot be blank."
  exit
}

$Credential = Get-Credential -Message "Enter an account authorized to join computers to the domain" 

# Join AD and rename
try {
  Add-Computer `
    -DomainName $DomainName `
    -Credential $Credential `
    -OUPath $OUPath `
    -NewName $ComputerName `
    -Restart `
    -Force `
    # Treats any failures as a terminating error so that the catch block runs
    -ErrorAction Stop 
  }
  catch {
    Write-Host "Failed to join the domain." -ForegroundColor Red
    Write-Host $_.Exception.Message
  }
