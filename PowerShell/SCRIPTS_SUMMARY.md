# Docker Alternative - Summary

## ✅ What Was Created

I've analyzed your Docker configuration and created a complete set of PowerShell scripts that replicate the Docker setup functionality without requiring Docker.

## 📁 File Structure

```
RenPy-VisualEditor/
│
├── 📄 setup-all.ps1                    # Master setup script (runs both backend and frontend setup)
├── 📄 start-dev.ps1                    # Start both services in parallel (like docker-compose up)
├── 📄 cleanup.ps1                      # Clean up generated files and dependencies
│
├── 📘 DOCKER_ALTERNATIVE.md            # Complete documentation
├── 📘 QUICK_REFERENCE.md               # Quick command reference
│
├── backend/
│   ├── 📄 setup-backend.ps1           # Creates Python venv and installs requirements
│   ├── 📄 run-backend.ps1             # Runs FastAPI with auto-reload (dev mode)
│   └── 📄 run-backend-production.ps1  # Runs FastAPI without reload (production)
│
└── frontend/
    ├── 📄 setup-frontend.ps1           # Installs npm dependencies
    ├── 📄 run-frontend-dev.ps1         # Runs Vite dev server with HMR
    ├── 📄 build-frontend.ps1           # Builds production bundle
    └── 📄 run-frontend-preview.ps1     # Previews production build
```

## 🔄 Docker vs PowerShell Scripts Mapping

### Docker Compose Services → PowerShell Scripts

| Docker Command | PowerShell Equivalent |
|----------------|----------------------|
| `docker-compose up --build` | `.\setup-all.ps1` then `.\start-dev.ps1` |
| `docker-compose up` | `.\start-dev.ps1` |
| `docker-compose down` | Press Ctrl+C in the terminal running `start-dev.ps1` |
| `docker-compose build frontend` | `.\frontend\build-frontend.ps1` |
| Run backend only | `.\backend\run-backend.ps1` |
| Run frontend only | `.\frontend\run-frontend-dev.ps1` |

### Configuration Mapping

**Backend (from `backend/Dockerfile` and `docker-compose.yml`)**
- ✅ Python 3.11+ environment → Python virtual environment
- ✅ `pip install -r requirements.txt` → Automated in setup script
- ✅ Database directory creation → Automated in setup script
- ✅ Port 9000 → Same port in scripts
- ✅ Environment variables → Set in run scripts
- ✅ Uvicorn with `--reload` in dev → Same in dev script

**Frontend (from `frontend/Dockerfile` and `docker-compose.yml`)**
- ✅ Node.js 20 environment → Local Node.js installation
- ✅ `npm ci` → Automated in setup script
- ✅ Build args for VITE_* → Environment variables
- ✅ Port 3001 (dev) → Same port in dev script
- ✅ Port 5137 (production) → Same port in preview script
- ✅ Vite HMR and dev server → Same in dev script

## 🎯 Key Features

### ✨ What's Included

1. **Automatic Setup**: Single command to set up everything
2. **Development Mode**: Both services with auto-reload/HMR
3. **Production Mode**: Build and run optimized versions
4. **Environment Variables**: All Docker env vars replicated
5. **Port Configuration**: Same ports as Docker setup
6. **Parallel Execution**: `start-dev.ps1` runs both services like docker-compose
7. **Comprehensive Docs**: Step-by-step guides and troubleshooting
8. **Cleanup Utility**: Easy reset to clean state

### 🎨 Nice Touches

- Colored console output for better readability
- Progress indicators for long-running tasks
- Error checking at each step
- Helpful messages guiding next steps
- Prerequisite validation (Python, Node.js)
- Consistent naming and structure

## 🚀 Getting Started (3 Steps)

```powershell
# 1️⃣ One-time setup
.\setup-all.ps1

# 2️⃣ Start both services
.\start-dev.ps1

# 3️⃣ Open your browser
# Frontend: http://localhost:3001
# Backend:  http://localhost:9000
# API Docs: http://localhost:9000/docs
```

## 📊 What Each Script Does

### Setup Scripts

**`setup-all.ps1`**
- Orchestrates complete setup
- Runs backend and frontend setup in sequence
- Shows nice progress output

**`backend/setup-backend.ps1`**
- Checks Python installation
- Creates virtual environment (`venv`)
- Installs all Python dependencies
- Creates database directory

**`frontend/setup-frontend.ps1`**
- Checks Node.js and npm installation
- Runs `npm ci` to install dependencies
- Shows available next steps

### Run Scripts (Development)

**`start-dev.ps1`**
- Starts both backend and frontend in parallel
- Displays output from both services
- Handles Ctrl+C to stop both

**`backend/run-backend.ps1`**
- Activates Python virtual environment
- Sets environment variables (DATABASE_PATH, LOG_LEVEL, CORS_ORIGINS)
- Runs Uvicorn with `--reload` flag for hot-reload

**`frontend/run-frontend-dev.ps1`**
- Sets environment variables (VITE_API_URL, VITE_WS_URL)
- Starts Vite dev server on port 3001
- Enables hot module replacement (HMR)

### Production Scripts

**`backend/run-backend-production.ps1`**
- Same as dev but without `--reload`
- For stable production deployment

**`frontend/build-frontend.ps1`**
- Builds optimized production bundle
- Output goes to `frontend/dist/`
- Can set custom API URLs via environment variables

**`frontend/run-frontend-preview.ps1`**
- Serves the production build locally
- Uses port 5137 (same as Docker production)

### Utility Scripts

**`cleanup.ps1`**
- Removes `backend/venv`
- Removes `frontend/node_modules`
- Removes `frontend/dist`
- Optionally removes database
- Interactive prompts for safety

## 💡 Advantages Over Docker

1. **No Docker Dependency**: Works on systems where Docker is restricted
2. **Native Performance**: No containerization overhead
3. **Easier Debugging**: Direct access to processes
4. **Familiar Tools**: Standard Python venv and npm
5. **Simple Inspection**: Can easily check installed packages

## ⚠️ Considerations

1. **Isolation**: Less isolated than Docker containers
2. **Dependencies**: Requires Python and Node.js installed locally
3. **Platform**: Designed for Windows PowerShell
4. **Environment**: Uses local filesystem (no Docker volumes)

## 📚 Documentation

- **`DOCKER_ALTERNATIVE.md`**: Complete guide with prerequisites, configuration, troubleshooting
- **`QUICK_REFERENCE.md`**: Cheat sheet with common commands
- **This file**: Overview and mapping summary

## ✅ Testing Checklist

Before using in production, test:
- [ ] Run `.\setup-all.ps1` successfully
- [ ] Start services with `.\start-dev.ps1`
- [ ] Access frontend at http://localhost:3001
- [ ] Access backend at http://localhost:9000
- [ ] Verify API docs at http://localhost:9000/docs
- [ ] Test backend changes with auto-reload
- [ ] Test frontend changes with HMR
- [ ] Build production version with `.\frontend\build-frontend.ps1`
- [ ] Preview production build
- [ ] Test cleanup script

## 🎓 Learning Resources

If you're new to the tools:
- **Python Virtual Environments**: https://docs.python.org/3/tutorial/venv.html
- **FastAPI**: https://fastapi.tiangolo.com/
- **Vite**: https://vitejs.dev/
- **PowerShell**: https://docs.microsoft.com/en-us/powershell/

---

**Created**: 2025-12-01  
**Purpose**: Docker alternative for company environments where Docker is restricted  
**Compatibility**: Windows PowerShell 5.1+, Python 3.11+, Node.js 20+
