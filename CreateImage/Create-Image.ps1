# Example:
# .\CreateImage\Create-Image.ps1 -AppPath 'D:\git\notejam\express\notejam' -ContainerRegistry 'webappcr.azurecr.io'


param
(
    [Parameter(mandatory=$true)][string]$AppPath,
    [Parameter(mandatory=$true)][string]$ContainerRegistry
)


# Copy assets:
Copy-Item "$($PSScriptRoot)\assets\.dockerignore" -Destination $AppPath
Copy-Item "$($PSScriptRoot)\assets\Dockerfile" -Destination $AppPath

# Build image:
Write-Output "Building docker image ...`n"
& "docker" "build" "--tag" "webapp-notejam" $AppPath

# Publish image to container registry:
Write-Output "Tagging docker image ...`n"
& "docker" "tag" "webapp-notejam" "$($ContainerRegistry)/webapp-notejam:latest"

Write-Output "Pushing docker image ...`n"
& "docker" "push" "$($ContainerRegistry)/webapp-notejam:latest"
