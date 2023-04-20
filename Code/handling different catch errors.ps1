#handling different catch errors

#do try catch
#when error found, search for error type
$Error[0].Exception.GetType().FullName

#then include [errortype]
try {}
catch [System.Management.Automation.RuntimeException] {
    # Write-Warning $Error[0] 
    #or
    $message = $_
    Write-Warning -Message "error 123: $message"
 }