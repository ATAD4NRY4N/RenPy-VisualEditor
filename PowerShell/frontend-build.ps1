#!/usr/bin/env pwsh
# Frontend Build Script - Alternative to Docker
# This script builds the production-ready frontend

Write-Host "=== RenPy Visual Editor - Building Frontend for Production ===" -ForegroundColor Cyan
Write-Host ""

# Navigate to frontend directory
$RootDir = Split-Path -Parent $PSScriptRoot
$FrontendDir = Join-Path $RootDir "frontend"
Set-Location $FrontendDir

# Check if node_modules exists
if (-Not (Test-Path "node_modules")) {
    Write-Host "✗ Node modules not found!" -ForegroundColor Red
    Write-Host "Please run .\PowerShell\frontend-setup.ps1 first" -ForegroundColor Yellow
    exit 1
}

# Set production environment variables
# You can customize these values based on your deployment
$env:VITE_API_URL = if ($env:VITE_API_URL) { $env:VITE_API_URL } else { "http://localhost:9000/api" }
$env:VITE_WS_URL = if ($env:VITE_WS_URL) { $env:VITE_WS_URL } else { "ws://localhost:9000" }

Write-Host "Building with configuration:" -ForegroundColor Yellow
Write-Host "  VITE_API_URL: $env:VITE_API_URL" -ForegroundColor Gray
Write-Host "  VITE_WS_URL: $env:VITE_WS_URL" -ForegroundColor Gray
Write-Host ""

# Build the application
Write-Host "Building production bundle..." -ForegroundColor Green
npm run build

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Build completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "The production build is available in the 'dist' folder" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "To preview the build, run: .\PowerShell\frontend-preview.ps1" -ForegroundColor Cyan
    Write-Host "To serve in production, use a web server to serve the 'dist' folder" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "✗ Build failed!" -ForegroundColor Red
    exit 1
}
