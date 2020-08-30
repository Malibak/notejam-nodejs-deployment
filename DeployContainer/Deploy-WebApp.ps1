# Requires linux ASP, tier Basic or higher.
# Example:
# .\DeployContainer\Deploy-WebApp.ps1 -ResourceGroup "webapps-rg" -WebAppName "notejampoc" -AspName "webapps-asp" -ContainerRegistry "webappcr" -ContainerRegistryResourceGroup "webapps-rg"


param
(
    [Parameter(mandatory=$true)][string]$ResourceGroup,
    [Parameter(mandatory=$true)][string]$WebAppName,
    [Parameter(mandatory=$true)][string]$AspName,
    [Parameter(mandatory=$true)][string]$ContainerRegistry,
    [Parameter(mandatory=$true)][string]$ContainerRegistryResourceGroup
)


# Create webapp:
$ContainerCredential = Get-AzContainerRegistryCredential -ResourceGroupName $ContainerRegistryResourceGroup -Name $ContainerRegistry
$ContainerUserName = $ContainerCredential.Username
$ContainerPassword = ConvertTo-SecureString $ContainerCredential.Password -AsPlainText -Force

Write-Output "Creating web app`n"
New-AzWebApp `
    -ResourceGroupName $ResourceGroup  `
    -Name $WebAppName `
    -AppServicePlan $AspName | out-null

Write-Output "Adding container and settings to web app`n"
Set-AzWebApp `
    -ResourceGroupName $ResourceGroup `
    -Name $WebAppName `
    -ContainerRegistryUrl "$($ContainerRegistry).azurecr.io" `
    -ContainerRegistryUser $ContainerUserName `
    -ContainerRegistryPassword $ContainerPassword `
    -ContainerImageName "$($ContainerRegistry).azurecr.io/webapp-notejam:latest" `
    -AppSettings @{"WEBSITES_PORT" = "3000"}
