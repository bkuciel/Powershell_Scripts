$IntuneModule = Get-Module -Name "Microsoft.Graph.Intune" -ListAvailable
if (!$IntuneModule){
 
write-host "Microsoft.Graph.Intune Powershell module not installed..." -f Red
write-host "Installing Microsoft.Graph.Intune Powershell module" -f Yellow
try {
    Install-module Microsoft.gaph.intune
}
catch {
    $message = $_
    Write-Warning -Message "Can't install Microsoft.Graph.Intune: $message"
}
}

#Import module
Import-Module -Name Microsoft.Graph.Intune
 
#Connect to MSGraph
if(!(Connect-MSGraph)){
Connect-MSGraph
}

#Get all devices running iOS
$Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem,'iOS')"
 
Foreach ($Device in $Devices)
{
 
Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
Write-Host "Sending Sync request to Device with DeviceID $($Device.managedDeviceId)" -ForegroundColor Yellow
 
}