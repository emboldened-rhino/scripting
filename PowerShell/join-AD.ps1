# Purpose: Provisioning brand new Windows devices to AD Rename device -- run as Administrator

$DomainName = ""
$OUPath = "OU=Workstations,OU=Computers,DC=nicholsequipment,DC=local"
$ComputerName = Read-Host ""
$Credential = Get-Credential -Message "Enter an account authorized to join computers to the domain" 

# Rename 
Rename-Computer ` 
  -NewName $ComputerName `
  -Force

# Join AD
Add-Computer `
  -DomainName $DomainName `
  -Credential $Credential `
  -OUPath $OUPath `
  -NewName $ComputerName `
  -Restart `
  -Force
 
