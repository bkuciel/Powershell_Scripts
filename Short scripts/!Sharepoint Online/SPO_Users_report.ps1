# Report of user and group assignment in Sharpoint Online Sites

#Admin Center & Site collection URL
$AdminCenterURL = "https://yoursite-admin.sharepoint.com/"
$CSVPath = "$PSScriptroot\SPO_GroupsReport.csv"
$CSVNoPermissionPath = "$PSScriptroot\SPO_NoPermission.csv"
$cred = get-credential
#Connect to SharePoint Online
Connect-SPOService -url $AdminCenterURL $cred
 
$GroupsData = @()
$SitesWithoutPermission = @()

#Get all Site collections
Get-SPOSite -Limit ALL | ForEach-Object {
    $URL = $_.URL
    Write-Host -f Yellow "Processing Site Collection:" $_.URL
  try{
    #get sharepoint online groups powershell
    $SiteGroups = Get-SPOSiteGroup -Site $_.URL
    Write-host -f Green "Total Number of Groups Found:"$SiteGroups.Count
 
    ForEach($Group in $SiteGroups)
    {
        $GroupsData += New-Object PSObject -Property @{
            'Site URL' = $_.URL
            'Group Name' = $Group.Title
            'Permissions' = $Group.Roles -join ","
            'Users' =  $Group.Users -join ","
        }
    }
    }
    catch [Microsoft.SharePoint.Client.ServerUnauthorizedAccessException] {
        Write-Host -f Red "No permission to: " $URL
        $SitesWithoutPermission += New-Object psobject -Property @{
            'Site URL' = $URL
        }
    }
}
#Export the data to CSV
$GroupsData | Export-Csv $CSVPath -NoTypeInformation
$SitesWithoutPermission | Export-csv $CSVNoPermissionPath -NoTypeInformation
 
Write-host -f Green "Groups Report Generated Successfully!"
