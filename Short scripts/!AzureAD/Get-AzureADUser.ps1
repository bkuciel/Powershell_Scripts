#Get-AzureADUser
#And export to Excel - FR users
Connect-AzureAD
$users = Get-AzureADUser -All $true -Filter "country eq 'France'"


#Export to Excel
$users | select ObjectType, AccountEnabled, UserPrincipalName, GivenName, SurName, Mail, PhysicalDeliveryOfficeName, Mobile, TelephoneNumber | Export-Excel "C:\Temp\AAD-FR-Users.xlsx" -AutoSize -StartRow 1 -TableName FR_Users -WorksheetName FR_Users
$users | Export-Excel "C:\Temp\AAD-FR-Users.xlsx" -AutoSize -StartRow 1 -TableName ALL_Parameters_FR_Users -WorksheetName ALL_Parameters_FR_Users