# Store multiple credentials in secure file using Export-CliXml
# Credentials can be used in other automation scripts
# See: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-clixml

$Creds = @{
    'DOM' = Get-Credential -Message 'DOM account Credentials'
    'ADM' = Get-Credential -Message 'ADM account Credentials'
}
$Creds | Export-Clixml -Path "${env:\userprofile}\cred.clixml"

# Import credentials to variable:
# $Creds = Import-CliXml -Path "${env:\userprofile}\cred.clixml"