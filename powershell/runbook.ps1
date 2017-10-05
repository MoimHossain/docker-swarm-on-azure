# Working SSH on Automation account
# Reference: https://channel9.msdn.com/Shows/Azure-Friday/Azure-Automation-104-managing-Linux-and-creating-Modules-with-Joe-Levy

$password = ""
$userName = ""


$remoteCommand =
@"
  docker node rm -f `$(docker node ls --format "{{.ID}} {{.Status}}" | grep -i 'down'  | awk "{print \`$1}")
"@
Write-Output "Invoking SSH command "
Write-Output $remoteCommand
 
$scriptBlock = [Scriptblock]::Create($remoteCommand)

$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($userName, $secpasswd)

$result = Invoke-SSHCommand -ComputerName 153.54.91.421 -Credential $creds -Port 7850 -Verbose  -ScriptBlock $scriptBlock

Write-Output $result
