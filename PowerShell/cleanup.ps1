#!/usr/bin/env pwsh
# Cleanup Script - Removes all generated files and dependencies
# Use this to reset the environment to a clean state

Write-Host @"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║         RenPy Visual Editor - Environment Cleanup             ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Yellow

Write-Host ""
Write-Host "This will remove:" -ForegroundColor Yellow
Write-Host "  • Backend Python virtual environment" -ForegroundColor Gray
Write-Host "  • Frontend node_modules" -ForegroundColor Gray
Write-Host "  • Frontend build output (dist)" -ForegroundColor Gray
Write-Host "  • Backend database (optional)" -ForegroundColor Gray
Write-Host ""

$confirmation = Read-Host "Are you sure you want to continue? (yes/no)"
if ($confirmation -ne "yes") {
    Write-Host "Cleanup cancelled" -ForegroundColor Green
    exit 0
}

$RootDir = Split-Path -Parent $PSScriptRoot
$itemsRemoved = 0

# Remove backend virtual environment
$BackendVenv = Join-Path $RootDir "backend\venv"
if (Test-Path $BackendVenv) {
    Write-Host "Removing backend virtual environment..." -ForegroundColor Yellow
    Remove-Item -Path $BackendVenv -Recurse -Force
    Write-Host "✓ Removed: backend\venv" -ForegroundColor Green
    $itemsRemoved++
} else {
    Write-Host "○ Not found: backend\venv" -ForegroundColor Gray
}

# Remove frontend node_modules
$FrontendNodeModules = Join-Path $RootDir "frontend\node_modules"
if (Test-Path $FrontendNodeModules) {
    Write-Host "Removing frontend node_modules..." -ForegroundColor Yellow
    Remove-Item -Path $FrontendNodeModules -Recurse -Force
    Write-Host "✓ Removed: frontend\node_modules" -ForegroundColor Green
    $itemsRemoved++
} else {
    Write-Host "○ Not found: frontend\node_modules" -ForegroundColor Gray
}

# Remove frontend dist
$FrontendDist = Join-Path $RootDir "frontend\dist"
if (Test-Path $FrontendDist) {
    Write-Host "Removing frontend build output..." -ForegroundColor Yellow
    Remove-Item -Path $FrontendDist -Recurse -Force
    Write-Host "✓ Removed: frontend\dist" -ForegroundColor Green
    $itemsRemoved++
} else {
    Write-Host "○ Not found: frontend\dist" -ForegroundColor Gray
}

# Optional: Remove database
Write-Host ""
$removeDb = Read-Host "Also remove the database? This will DELETE ALL DATA! (yes/no)"
if ($removeDb -eq "yes") {
    $BackendDb = Join-Path $RootDir "backend\database"
    if (Test-Path $BackendDb) {
        Write-Host "Removing database..." -ForegroundColor Yellow
        Remove-Item -Path $BackendDb -Recurse -Force
        Write-Host "✓ Removed: backend\database" -ForegroundColor Green
        $itemsRemoved++
    } else {
        Write-Host "○ Not found: backend\database" -ForegroundColor Gray
    }
}

# Summary
Write-Host ""
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""
if ($itemsRemoved -gt 0) {
    Write-Host "✓ Cleanup completed! Removed $itemsRemoved item(s)" -ForegroundColor Green
    Write-Host ""
    Write-Host "To set up the environment again, run: .\PowerShell\setup-all.ps1" -ForegroundColor Cyan
} else {
    Write-Host "○ Nothing to clean up" -ForegroundColor Gray
}
Write-Host ""
