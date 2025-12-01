#!/usr/bin/env pwsh
# Frontend Development Server Script - Alternative to Docker
# This script runs the Vite development server

Write-Host "=== RenPy Visual Editor - Starting Frontend Dev Server ===" -ForegroundColor Cyan
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

# Set environment variables (similar to docker-compose.override.dev.yml)
$env:NODE_ENV = "development"
$env:VITE_API_URL = "http://localhost:9000/api"
$env:VITE_WS_URL = "ws://localhost:9000"

Write-Host "✓ Environment configured" -ForegroundColor Green
Write-Host "  NODE_ENV: $env:NODE_ENV" -ForegroundColor Gray
Write-Host "  VITE_API_URL: $env:VITE_API_URL" -ForegroundColor Gray
Write-Host "  VITE_WS_URL: $env:VITE_WS_URL" -ForegroundColor Gray
Write-Host ""

# Run the Vite development server
Write-Host "Starting Vite development server..." -ForegroundColor Green
Write-Host "The server will be available at http://localhost:3001" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Run with host 0.0.0.0 to match Docker behavior and use port 3001
npm run dev -- --host 0.0.0.0 --port 3001
