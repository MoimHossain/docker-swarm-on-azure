# Working SSH on Automation account
# Reference: https://channel9.msdn.com/Shows/Azure-Friday/Azure-Automation-104-managing-Linux-and-creating-Modules-with-Joe-Levy

$AzureLBPIP = ""
$Port = 4444
$RemoteUserName = ""
$RemotePassword = ""

$remoteCommand =
@"
  docker node rm -f `$(docker node ls --format "{{.ID}} {{.Status}}" | grep -i 'down'  | awk "{print \`$1}")
"@

Write-Output "Invoking SSH command [$remoteCommand]"
Write-Output "Please wait..."
 
$scriptBlock = [Scriptblock]::Create($remoteCommand)
 

$secpasswd = ConvertTo-SecureString $RemotePassword -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($RemoteUserName, $secpasswd)
$result = Invoke-SSHCommand -ComputerName $AzureLBPIP -Credential $creds -Port $Port -Verbose  -ScriptBlock $scriptBlock
Write-Output $result

