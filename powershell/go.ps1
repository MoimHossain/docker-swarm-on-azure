Param(
    [string] $ResourceGroupLocation = 'West Europe',
    [string] $ResourceGroupName = 'Dockerswarm-Resources',
    [string] $TemplateFile = '..\swarm-managers\azuredeploy.json',
	[string] $TemplateParameterFile = "..\swarm-managers\azuredeploy.parameters.json"
)

Function New-Line() { 	Write-Host " " }
Clear
Write-Host "Provisioning Infrastructure in $ResourceGroupLocation started at" (Get-Date) -ForegroundColor DarkYellow
Write-Host "___________________________________________________________________________" -ForegroundColor DarkYellow
New-Line
Write-Host "Parameters " -ForegroundColor White
Write-Host "------------------------------------------------" -ForegroundColor DarkYellow
Write-Host "Location: " -NoNewline
Write-Host "$ResourceGroupLocation " -ForegroundColor Green
Write-Host "Resource Group: " -NoNewline
Write-Host "$ResourceGroupName " -ForegroundColor Green
New-Line

# Creating the resource group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Force -ErrorAction Stop -Verbose

Write-Host "Provisioning the Virtual machine scale set under $ResourceGroupName ... this may take a while" -ForegroundColor DarkYellow

New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MM-dd-HH-mm')) `
                                   -ResourceGroupName $ResourceGroupName `
                                   -TemplateFile $TemplateFile `
                                   -TemplateParameterFile $TemplateParameterFile 

New-Line
Write-Host "Operation completed at" (Get-Date) -ForegroundColor DarkYellow
Write-Host "___________________________________________________________________________" -ForegroundColor DarkYellow
New-Line