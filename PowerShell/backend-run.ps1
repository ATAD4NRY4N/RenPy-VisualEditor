#!/usr/bin/env pwsh
# Backend Run Script - Alternative to Docker
# This script runs the FastAPI backend server

Write-Host "=== RenPy Visual Editor - Starting Backend Server ===" -ForegroundColor Cyan
Write-Host ""

# Navigate to backend directory
$RootDir = Split-Path -Parent $PSScriptRoot
$BackendDir = Join-Path $RootDir "backend"
Set-Location $BackendDir

# Check if virtual environment exists
if (-Not (Test-Path "venv")) {
    Write-Host "✗ Virtual environment not found!" -ForegroundColor Red
    Write-Host "Please run .\PowerShell\backend-setup.ps1 first" -ForegroundColor Yellow
    exit 1
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& "$BackendDir\venv\Scripts\Activate.ps1"

# Set environment variables (similar to docker-compose.yml)
$env:DATABASE_PATH = Join-Path $BackendDir "database\renpy_editor.db"
$env:LOG_LEVEL = "info"
$env:ENVIRONMENT = "dev"
$env:CORS_ORIGINS = "http://localhost:3001,http://localhost:5137"

Write-Host "✓ Environment configured" -ForegroundColor Green
Write-Host "  DATABASE_PATH: $env:DATABASE_PATH" -ForegroundColor Gray
Write-Host "  LOG_LEVEL: $env:LOG_LEVEL" -ForegroundColor Gray
Write-Host ""

# Run the FastAPI server
Write-Host "Starting FastAPI server on http://0.0.0.0:9000..." -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Use --reload for development mode (like docker-compose.override.dev.yml)
uvicorn app.main:app --reload --host 0.0.0.0 --port 9000
