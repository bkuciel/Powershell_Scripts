# set alternate sign-in using email address
#https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-authentication-use-email-signin

#enable
$AzureADPolicyDefinition = @(
  @{
     "HomeRealmDiscoveryPolicy" = @{
        "AlternateIdLogin" = @{
           "Enabled" = $true
        }
     }
  } | ConvertTo-JSON -Compress
)
$AzureADPolicyParameters = @{
  Definition            = $AzureADPolicyDefinition
  DisplayName           = "BasicAutoAccelerationPolicy"
  IsOrganizationDefault = $true
  Type                  = "HomeRealmDiscoveryPolicy"
}
Set-AzureADPolicy @AzureADPolicyParameters

#check
Get-AzureADPolicy | Where-Object Type -eq "HomeRealmDiscoveryPolicy" | Format-List *

#remove/modify
Set-AzureADPolicy -Id "id" @AzureADPolicyParameters

#modify
Set-AzureADPolicy -Id "id" @AzureADPolicyParameters