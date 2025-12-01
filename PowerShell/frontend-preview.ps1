#!/usr/bin/env pwsh
# Frontend Preview Script - Alternative to Docker
# This script previews the production build locally

Write-Host "=== RenPy Visual Editor - Starting Frontend Preview Server ===" -ForegroundColor Cyan
Write-Host ""

# Navigate to frontend directory
$RootDir = Split-Path -Parent $PSScriptRoot
$FrontendDir = Join-Path $RootDir "frontend"
Set-Location $FrontendDir

# Check if dist folder exists
if (-Not (Test-Path "dist")) {
    Write-Host "✗ Production build not found!" -ForegroundColor Red
    Write-Host "Please run .\PowerShell\frontend-build.ps1 first" -ForegroundColor Yellow
    exit 1
}

Write-Host "Starting preview server for production build..." -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Run Vite preview server on port 5137 to match Docker
npm run preview -- --host 0.0.0.0 --port 5137
