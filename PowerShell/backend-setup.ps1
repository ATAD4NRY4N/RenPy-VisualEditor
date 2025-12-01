#!/usr/bin/env pwsh
# Backend Setup Script - Alternative to Docker
# This script sets up the Python virtual environment and installs dependencies

Write-Host "=== RenPy Visual Editor - Backend Setup ===" -ForegroundColor Cyan
Write-Host ""

# Navigate to backend directory (parent of PowerShell folder, then backend)
$RootDir = Split-Path -Parent $PSScriptRoot
$BackendDir = Join-Path $RootDir "backend"
Set-Location $BackendDir

# Check if Python is installed
Write-Host "Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ Found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Python is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Python 3.11 or later from https://www.python.org/downloads/" -ForegroundColor Red
    exit 1
}

# Create virtual environment if it doesn't exist
if (-Not (Test-Path "venv")) {
    Write-Host "Creating Python virtual environment..." -ForegroundColor Yellow
    python -m venv venv
    Write-Host "✓ Virtual environment created" -ForegroundColor Green
} else {
    Write-Host "✓ Virtual environment already exists" -ForegroundColor Green
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Yellow
& "$BackendDir\venv\Scripts\Activate.ps1"

# Upgrade pip
Write-Host "Upgrading pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip --quiet

# Install dependencies
Write-Host "Installing Python dependencies from requirements.txt..." -ForegroundColor Yellow
pip install --no-cache-dir -r requirements.txt
Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green

# Create database directory if it doesn't exist
$DatabaseDir = Join-Path $BackendDir "database"
if (-Not (Test-Path $DatabaseDir)) {
    Write-Host "Creating database directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $DatabaseDir -Force | Out-Null
    Write-Host "✓ Database directory created" -ForegroundColor Green
} else {
    Write-Host "✓ Database directory already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Backend Setup Complete! ===" -ForegroundColor Green
Write-Host ""
Write-Host "To run the backend server, use: .\PowerShell\backend-run.ps1" -ForegroundColor Cyan
Write-Host "Or manually activate the virtual environment and run:" -ForegroundColor Cyan
Write-Host "  .\backend\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host "  uvicorn app.main:app --host 0.0.0.0 --port 9000" -ForegroundColor White
