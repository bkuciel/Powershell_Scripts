Import-Module AzureAD
Connect-AzureAD

$devices = Get-AzureADDevice -All $true -Filter "startswith(DeviceOSType,'Windows')"

$list = @()
foreach ($device in $devices) {
  $deviceName = $device.DisplayName

  $item = New-Object PSObject
  $item = Get-AzureADDeviceRegisteredOwner -ObjectId $device.ObjectId | select UserPrincipalName
  $item | Add-Member -name 'DeviceName' -Value $deviceName -MemberType NoteProperty
  $item | Add-Member -name 'DeviceId' -Value $device.DeviceId -MemberType NoteProperty
  $item | Add-Member -name 'ApproximateLastLogonTimeStamp' -Value $device.ApproximateLastLogonTimeStamp -MemberType NoteProperty
  $item | Add-Member -name 'OperatingSystem' -Value $device.DeviceOSType -MemberType NoteProperty
  Write-Host "$deviceName : $item"
  $list += $item
}

$list | export-excel C:\temp\DeviceOwners.xlsx -WorksheetName Owners -TableName Owners -AutoSize