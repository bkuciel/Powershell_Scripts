$credentials = import-clixml -path C:\Users\user\Desktop\files\cred.clixml
Connect-AzureAD -Credential $credentials

$AU = Get-AzureADMSAdministrativeUnit -Id "id"
$users = get-azureaddomainnamereference -name domainA.com | where {$_.ObjectType -eq "User"}
#GetCurrentMembers
$AuCurrentMembers = Get-AzureADMSAdministrativeUnitMember -id $AU.id -All $true | where {$_.OdataType -eq "#microsoft.graph.user"}
#Compare and add missing
$users | foreach {
    if ($AuCurrentMembers.id -Notcontains $_.ObjectId){
        Write-Host "Adding to AU user: " $_.UserPrincipalName
        # Add-AzureADMSAdministrativeUnitMember -id $AU.Id -RefObjectId $_.ObjectId
    }
}




####################
#test
$testuser = get-AzureAdUser -filter "UserPrincipalName eq 'test@domainA.com'"
Add-AzureADMSAdministrativeUnitMember -id $AU.Id -RefObjectId $testuser.ObjectId

#GetCurrentMembers
$AuCurrentMembers = Get-AzureADMSAdministrativeUnitMember -id $AU.id -All $true | where {$_.OdataType -eq "#microsoft.graph.user"}

$notadded = $users | where {$_.ObjectId -NotContains $AuCurrentMembers.Id}

$users | foreach {
    if ($AuCurrentMembers.id -Notcontains $_.ObjectId){
        Write-Host "AU not contains " $_.DisplayName
    }
}