$diskconfig = New-AzDiskConfig -Location 'West Europe' -DiskSizeGB 5 -SkuName Standard_LRS -OsType Windows -CreateOption Empty
New-AzDisk -ResourceGroupName 'az104-03c-rg1' -DiskName 'Disk01' -Disk $diskconfig