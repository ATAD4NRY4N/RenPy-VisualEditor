#!/usr/bin/env pwsh
# Complete Setup Script - Alternative to Docker
# This script sets up both backend and frontend

Write-Host @"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║         RenPy Visual Editor - Complete Setup                  ║
║         Alternative to Docker                                 ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Write-Host ""

# Get root directory (parent of PowerShell folder)
$RootDir = Split-Path -Parent $PSScriptRoot

# Setup Backend
Write-Host ""
Write-Host "┌──────────────────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│ STEP 1/2: Setting up Backend" -ForegroundColor Yellow
Write-Host "└──────────────────────────────────────────────────────────────┘" -ForegroundColor Yellow
Write-Host ""

$BackendSetup = Join-Path $PSScriptRoot "backend-setup.ps1"
& $BackendSetup

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "✗ Backend setup failed!" -ForegroundColor Red
    exit 1
}

# Setup Frontend
Write-Host ""
Write-Host "┌──────────────────────────────────────────────────────────────┐" -ForegroundColor Yellow
Write-Host "│ STEP 2/2: Setting up Frontend" -ForegroundColor Yellow
Write-Host "└──────────────────────────────────────────────────────────────┘" -ForegroundColor Yellow
Write-Host ""

$FrontendSetup = Join-Path $PSScriptRoot "frontend-setup.ps1"
& $FrontendSetup

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "✗ Frontend setup failed!" -ForegroundColor Red
    exit 1
}

# Success message
Write-Host ""
Write-Host @"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║         ✓ Complete Setup Finished Successfully!               ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Green

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "├─ Run both services:      .\PowerShell\start-dev.ps1" -ForegroundColor White
Write-Host "├─ Run backend only:       .\PowerShell\backend-run.ps1" -ForegroundColor White
Write-Host "├─ Run frontend only:      .\PowerShell\frontend-run-dev.ps1" -ForegroundColor White
Write-Host "└─ Build for production:   .\PowerShell\frontend-build.ps1" -ForegroundColor White
Write-Host ""
