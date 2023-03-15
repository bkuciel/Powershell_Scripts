#https://practical365.com/permanently-remove-deleted-microsoft-365-users-from-azure-ad/

Connect-AzureAD
Connect-MSOlService

Get-MsolUser -ReturnDeletedUsers | Format-Table DisplayName, ObjectId

Remove-AzureADMSDeletedDirectoryObject -Id 00000000-c2b4-4e14-8e69-00000000