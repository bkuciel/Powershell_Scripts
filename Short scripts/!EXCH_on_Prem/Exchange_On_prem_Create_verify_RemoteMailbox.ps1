$Creds = Import-Clixml -Path "${env:\userprofile}\cred.clixml"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://Exchange.domainA.local/PowerShell/ -Authentication Kerberos -Credential $Creds.DOM
Import-PSSession $Session -DisableNameChecking


$user= Read-host 'samaccountname'
$extmail= Read-Host 'mail' 
Enable-RemoteMailbox "$user" -RemoteRoutingAddress $extmail

#Potwierdzenie: 
$user= Read-host 'samaccountname'
Get-Recipient $user | select  Name, Recipienttype, RecipientTypeDetails


#Disconnect
Remove-PSSession $Session