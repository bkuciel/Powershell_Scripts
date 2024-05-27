$user = Read-Host "SamAccountName?"
$extmail = Read-Host "E-mail?"
Write-Host "Setting RemoteMailbox"
Enable-RemoteMailbox "$user" -RemoteRoutingAddress $extmail

Write-Host "Verification" -ForegroundColor Yellow
Get-Recipient $user | select  Name, Recipienttype, RecipientTypeDetails
