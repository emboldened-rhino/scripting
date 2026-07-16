# Purpose: Provisioning brand new Windows devices to AD Rename device -- run as Administrator

$DomainName = ""
$OUPath = "OU=Workstations,OU=Computers,DC=nicholsequipment,DC=local"

$ComputerName = Read-Host ""

# Verify computer name isn't blank 
if ([string]::IsNullOrWhiteSpace($ComputerName)) {
  Write-Host "Computer name cannot be blank."
  exit
}

$Credential = Get-Credential -Message "Enter an account authorized to join computers to the domain" 

# Rename 
Rename-Computer ` 
  -NewName $ComputerName `
  -Force

# Join AD try/catch 
try {
  Add-Computer `
    -DomainName $DomainName `
    -Credential $Credential `
    -OUPath $OUPath `
    -NewName $ComputerName `
    -Restart `
    -Force
    -ErrorAction Stop # Treats any failures as a terminating error so catch block runs
  }
  catch {
    Write-Host "Failed to join the domain."
    Write-Host $_.Exception.Message
  }
