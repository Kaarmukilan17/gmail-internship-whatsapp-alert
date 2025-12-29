$containerName = "n8n"
$n8nUrl = "http://localhost:5678"
$dockerDesktop = "$Env:ProgramFiles\Docker\Docker\Docker Desktop.exe"
$dockerPipe = "\\.\pipe\dockerDesktopLinuxEngine"

function Docker-IsReady {
    return Test-Path $dockerPipe
}

function Wait-ForDocker {
    Write-Host "Waiting for Docker engine to start..." -ForegroundColor Yellow
    while (-not (Docker-IsReady)) {
        Start-Sleep -Seconds 2
    }
    Write-Host "Docker engine is ready." -ForegroundColor Green
}

function Is-N8nRunning {
    $id = docker ps -q --filter "name=$containerName" 2>$null
    return -not [string]::IsNullOrWhiteSpace($id)
}

# ---- ENSURE DOCKER ENGINE ----
if (-not (Docker-IsReady)) {
    Write-Host "Docker not running. Launching Docker Desktop..." -ForegroundColor Cyan
    Start-Process $dockerDesktop
    Wait-ForDocker
}

# ---- TOGGLE n8n ----
if (Is-N8nRunning) {
    Write-Host "Stopping n8n..." -ForegroundColor Red
    docker stop $containerName | Out-Null
    docker rm $containerName | Out-Null
    Write-Host "n8n stopped." -ForegroundColor Green
    exit
}

Write-Host "Starting n8n container..." -ForegroundColor Cyan

docker run -d `
    --name $containerName `
    -p 5678:5678 `
    -v C:\n8n:/home/node/.n8n `
    n8nio/n8n | Out-Null

Write-Host "Waiting for n8n to be ready..." -ForegroundColor Yellow
while (-not (Test-NetConnection 127.0.0.1 -Port 5678 -InformationLevel Quiet)) {
    Start-Sleep -Seconds 1
}

Write-Host "Opening n8n UI..." -ForegroundColor Green
Start-Process $n8nUrl
