#!/usr/bin/env pwsh
# Frontend Setup Script - Alternative to Docker
# This script sets up Node.js dependencies

Write-Host "=== RenPy Visual Editor - Frontend Setup ===" -ForegroundColor Cyan
Write-Host ""

# Navigate to frontend directory
$RootDir = Split-Path -Parent $PSScriptRoot
$FrontendDir = Join-Path $RootDir "frontend"
Set-Location $FrontendDir

# Check if Node.js is installed
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version 2>&1
    Write-Host "✓ Found Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Node.js is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Node.js 20 or later from https://nodejs.org/" -ForegroundColor Red
    exit 1
}

# Check if npm is installed
try {
    $npmVersion = npm --version 2>&1
    Write-Host "✓ Found npm: $npmVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ npm is not installed or not in PATH" -ForegroundColor Red
    exit 1
}

# Install dependencies
Write-Host ""
Write-Host "Installing Node.js dependencies..." -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Gray

npm ci

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Frontend Setup Complete! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Available commands:" -ForegroundColor Cyan
Write-Host "  Development server: .\PowerShell\frontend-run-dev.ps1" -ForegroundColor White
Write-Host "  Production build:   .\PowerShell\frontend-build.ps1" -ForegroundColor White
Write-Host "  Preview build:      .\PowerShell\frontend-preview.ps1" -ForegroundColor White
