Param(
    [string] $ResourceGroupLocation = 'West Europe',
    [string] $ResourceGroupName = 'Dockerswarm-Resources-Test'
)
Function New-Line() { 	Write-Host " " }

Get-AzureRmResourceGroup -Name $ResourceGroupName | Remove-AzureRmResourceGroup -Verbose -Force

New-Line
Write-Host "Operation completed at" (Get-Date) -ForegroundColor DarkYellow
Write-Host "___________________________________________________________________________" -ForegroundColor DarkYellow
New-Line