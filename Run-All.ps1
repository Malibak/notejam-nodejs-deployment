# Create and push container image:
.\CreateImage\Create-Image.ps1 -AppPath 'D:\git\notejam\express\notejam' -ContainerRegistry 'webappcr.azurecr.io'

# Deploy ASP and WebApp:
.\DeployContainer\Deploy-WebApp.ps1 -ResourceGroup "webapps-rg" -WebAppName "notejampoc" -AspName "webapps-asp" -ContainerRegistry "webappcr" -ContainerRegistryResourceGroup "webapps-rg"
