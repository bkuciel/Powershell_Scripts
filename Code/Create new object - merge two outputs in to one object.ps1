$list = @()
$Groups = get-adgroup -filter * -searchbase "OU=Groups,OU=BranchA,DC=domainA,DC=com" -Properties Name, Description
foreach ($Group in $Groups){
	$members = get-adgroupmember -identity $group 
	foreach ($member in $members){
		if($member.objectClass -eq "User"){
            #Create new object
			$item = new-object PSObject
            #Add parameters with value
			$item | Add-member -name 'Group' -value $group.name -MemberType NoteProperty
			$item | Add-member -name 'Member' -value $member.samaccountname -MemberType NoteProperty
            $item | Add-member -name 'Description' -value $Group.description -MemberType NoteProperty
			#Add to list
            $list += $item
		}
	}

}
	$list | export-csv "$PSScriptroot\groups.csv" -NoTypeInformation