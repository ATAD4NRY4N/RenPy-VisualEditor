# PowerShell Scripts Workflow Diagram

## Setup Phase (First Time Only)

```
┌─────────────────────────────────────────────────────────────────────┐
│                         FIRST TIME SETUP                            │
│                                                                     │
│                         .\setup-all.ps1                            │
│                    (Master Setup Orchestrator)                      │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
                ▼                         ▼
┌───────────────────────────┐   ┌───────────────────────────┐
│  backend\setup-backend.ps1│   │frontend\setup-frontend.ps1│
│  ─────────────────────────│   │  ─────────────────────────│
│  ✓ Check Python installed │   │  ✓ Check Node.js/npm      │
│  ✓ Create virtual env     │   │  ✓ Run npm ci             │
│  ✓ Install requirements   │   │  ✓ Install dependencies   │
│  ✓ Create database folder │   │                           │
└───────────────────────────┘   └───────────────────────────┘
```

## Development Phase (Daily Workflow)

```
┌─────────────────────────────────────────────────────────────────────┐
│                      DEVELOPMENT MODE                               │
│                                                                     │
│                         .\start-dev.ps1                            │
│              (Starts Both Services in Parallel)                     │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
                ▼                         ▼
┌───────────────────────────┐   ┌───────────────────────────┐
│  backend\run-backend.ps1  │   │frontend\run-frontend-dev.ps1│
│  ─────────────────────────│   │  ─────────────────────────│
│  • Activate Python venv   │   │  • Set environment vars   │
│  • Set DATABASE_PATH      │   │    - VITE_API_URL         │
│  • Set CORS_ORIGINS       │   │    - VITE_WS_URL          │
│  • Run Uvicorn            │   │  • Start Vite dev server  │
│  • --reload enabled       │   │  • HMR enabled            │
│                           │   │                           │
│  PORT: 9000               │   │  PORT: 3001               │
└───────────┬───────────────┘   └───────────┬───────────────┘
            │                               │
            ▼                               ▼
  ┌──────────────────┐           ┌──────────────────┐
  │ Backend API      │           │ Frontend UI      │
  │ localhost:9000   │           │ localhost:3001   │
  │                  │  ←────→   │                  │
  │ /api/*           │   API     │ React App        │
  │ /docs            │   Calls   │ with Vite HMR    │
  └──────────────────┘           └──────────────────┘
```

## Production Build Phase

```
┌─────────────────────────────────────────────────────────────────────┐
│                      PRODUCTION BUILD                               │
└─────────────────────────────────────────────────────────────────────┘

   FRONTEND BUILD PATH
   ═══════════════════
   
   .\frontend\build-frontend.ps1
              │
              ├─ Set VITE_API_URL
              ├─ Set VITE_WS_URL
              ├─ Run: npm run build
              │
              ▼
   ┌─────────────────────┐
   │   frontend\dist\    │  ←── Optimized production bundle
   │   ────────────────  │       (HTML, CSS, JS, assets)
   │   • index.html      │
   │   • assets/         │
   │   • *.js (minified) │
   └──────────┬──────────┘
              │
              ▼
   .\frontend\run-frontend-preview.ps1
              │
              └─ Preview on PORT 5137


   BACKEND PRODUCTION PATH
   ═══════════════════════
   
   .\backend\run-backend-production.ps1
              │
              ├─ Activate Python venv
              ├─ Set DATABASE_PATH
              ├─ Set LOG_LEVEL
              ├─ Run Uvicorn (no --reload)
              │
              ▼
   ┌─────────────────────┐
   │  Production Backend │
   │  localhost:9000     │
   │  ─────────────────  │
   │  Stable, no reload  │
   └─────────────────────┘
```

## Alternative Individual Service Scripts

```
BACKEND ONLY                      FRONTEND ONLY
════════════                      ═════════════

Development:                      Development:
.\backend\run-backend.ps1         .\frontend\run-frontend-dev.ps1
    │                                 │
    └─→ Port 9000                     └─→ Port 3001
        Auto-reload ✓                     HMR ✓

Production:                       Production Build:
.\backend\run-backend-production.ps1  .\frontend\build-frontend.ps1
    │                                 │
    └─→ Port 9000                     └─→ dist/ folder
        No reload
                                  Production Preview:
                                  .\frontend\run-frontend-preview.ps1
                                      │
                                      └─→ Port 5137
```

## Cleanup Phase

```
┌─────────────────────────────────────────────────────────────────────┐
│                          CLEANUP                                    │
│                                                                     │
│                         .\cleanup.ps1                              │
│                  (Reset to Clean State)                             │
└────────────────────────────┬────────────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
   Remove venv        Remove node_modules   Remove dist
   backend\venv\      frontend\node_modules\ frontend\dist\
                             
                             │ (Optional)
                             ▼
                      Remove database
                   backend\database\
```

## Script Dependencies

```
┌──────────────────────────────────────────────────────────────────┐
│  Prerequisites (Must be installed on your system)               │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  • Python 3.11+          https://www.python.org/                 │
│  • Node.js 20+           https://nodejs.org/                     │
│  • PowerShell 5.1+       (Built into Windows)                    │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

## Complete Workflow Example

```
┌─────────────────────────────────────────────────────────────────────┐
│                    TYPICAL USER JOURNEY                             │
└─────────────────────────────────────────────────────────────────────┘

DAY 1 (Initial Setup):
─────────────────────
  1. .\setup-all.ps1                  ← Run once to set everything up
  2. .\start-dev.ps1                  ← Start developing
  3. Open http://localhost:3001        ← Use the app
  4. Press Ctrl+C                      ← Stop when done


DAY 2+ (Daily Development):
───────────────────────────
  1. .\start-dev.ps1                  ← Just start and code
  2. Make changes to code              ← Files auto-reload
  3. Press Ctrl+C                      ← Stop when done


PREPARING FOR DEPLOYMENT:
─────────────────────────
  1. .\frontend\build-frontend.ps1    ← Build production bundle
  2. .\frontend\run-frontend-preview.ps1 ← Test the build locally
  3. Deploy frontend\dist\ folder      ← Deploy to web server
  4. .\backend\run-backend-production.ps1 ← Run stable backend


STARTING FRESH:
───────────────
  1. .\cleanup.ps1                    ← Remove all generated files
  2. .\setup-all.ps1                  ← Set up again
```

## Port Reference

```
╔════════════════════════════════════════════════════════════╗
║  Service              Port    URL                          ║
╠════════════════════════════════════════════════════════════╣
║  Backend (API)        9000    http://localhost:9000        ║
║  Backend (Docs)       9000    http://localhost:9000/docs   ║
║  Frontend (Dev)       3001    http://localhost:3001        ║
║  Frontend (Preview)   5137    http://localhost:5137        ║
╚════════════════════════════════════════════════════════════╝
```

## Environment Variables

```
BACKEND (run-backend.ps1):
──────────────────────────
  DATABASE_PATH  →  backend\database\renpy_editor.db
  LOG_LEVEL      →  info
  ENVIRONMENT    →  dev
  CORS_ORIGINS   →  http://localhost:3001,http://localhost:5137


FRONTEND (run-frontend-dev.ps1):
─────────────────────────────────
  NODE_ENV       →  development
  VITE_API_URL   →  http://localhost:9000/api
  VITE_WS_URL    →  ws://localhost:9000
```

## Legend

```
┌─────────────────────────────────────────────────────────┐
│  Symbol Key                                             │
├─────────────────────────────────────────────────────────┤
│  │  └  ┌  ┐  ┘  ─  ═     Box drawing characters        │
│  →  ▼  ▲              Arrows showing flow              │
│  ✓                     Completed action                 │
│  •                     List item / Sub-action           │
│  ←────→                Bidirectional communication      │
└─────────────────────────────────────────────────────────┘
```
