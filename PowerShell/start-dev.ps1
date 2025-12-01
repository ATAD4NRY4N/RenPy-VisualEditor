#!/usr/bin/env pwsh
# Development Server Launcher - Alternative to Docker Compose
# This script runs both backend and frontend in development mode

Write-Host @"
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║         RenPy Visual Editor - Development Mode                ║
║         Starting Backend + Frontend                           ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Write-Host ""

$RootDir = Split-Path -Parent $PSScriptRoot

# Check if setup has been run
if (-Not (Test-Path "$RootDir\backend\venv")) {
    Write-Host "✗ Backend not set up!" -ForegroundColor Red
    Write-Host "Please run .\PowerShell\setup-all.ps1 first" -ForegroundColor Yellow
    exit 1
}

if (-Not (Test-Path "$RootDir\frontend\node_modules")) {
    Write-Host "✗ Frontend not set up!" -ForegroundColor Red
    Write-Host "Please run .\PowerShell\setup-all.ps1 first" -ForegroundColor Yellow
    exit 1
}

Write-Host "Starting services in parallel..." -ForegroundColor Green
Write-Host ""
Write-Host "Backend will be available at:  http://localhost:9000" -ForegroundColor Cyan
Write-Host "Frontend will be available at: http://localhost:3001" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop all services" -ForegroundColor Yellow
Write-Host ""
Write-Host "─────────────────────────────────────────────────────────────" -ForegroundColor Gray
Write-Host ""

# Function to stop all jobs on exit
$stopJobs = {
    Write-Host ""
    Write-Host "Stopping all services..." -ForegroundColor Yellow
    Get-Job | Stop-Job
    Get-Job | Remove-Job
    Write-Host "✓ All services stopped" -ForegroundColor Green
}

# Register cleanup on Ctrl+C
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action $stopJobs | Out-Null

# Start Backend in background job
$backendScript = Join-Path $PSScriptRoot "backend-run.ps1"
$backendJob = Start-Job -ScriptBlock {
    param($script)
    & $script
} -ArgumentList $backendScript

# Wait a moment for backend to start
Start-Sleep -Seconds 2

# Start Frontend in background job
$frontendScript = Join-Path $PSScriptRoot "frontend-run-dev.ps1"
$frontendJob = Start-Job -ScriptBlock {
    param($script)
    & $script
} -ArgumentList $frontendScript

# Monitor jobs and display output
try {
    while ($true) {
        # Get backend output
        $backendOutput = Receive-Job -Job $backendJob
        if ($backendOutput) {
            $backendOutput | ForEach-Object {
                Write-Host "[Backend] $_" -ForegroundColor Blue
            }
        }

        # Get frontend output
        $frontendOutput = Receive-Job -Job $frontendJob
        if ($frontendOutput) {
            $frontendOutput | ForEach-Object {
                Write-Host "[Frontend] $_" -ForegroundColor Magenta
            }
        }

        # Check if jobs are still running
        $backendState = (Get-Job -Id $backendJob.Id).State
        $frontendState = (Get-Job -Id $frontendJob.Id).State

        if ($backendState -eq "Failed" -or $backendState -eq "Stopped") {
            Write-Host ""
            Write-Host "✗ Backend job stopped unexpectedly!" -ForegroundColor Red
            break
        }

        if ($frontendState -eq "Failed" -or $frontendState -eq "Stopped") {
            Write-Host ""
            Write-Host "✗ Frontend job stopped unexpectedly!" -ForegroundColor Red
            break
        }

        Start-Sleep -Milliseconds 100
    }
} finally {
    # Clean up jobs
    & $stopJobs
}
