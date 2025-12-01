# Docker Alternative - PowerShell Scripts

This document provides instructions for running the RenPy Visual Editor without Docker, using PowerShell scripts instead.

## 📋 Prerequisites

Before running the scripts, ensure you have the following installed:

### Required Software
1. **Python 3.11 or later**
   - Download from: https://www.python.org/downloads/
   - During installation, make sure to check "Add Python to PATH"
   - Verify installation: `python --version`

2. **Node.js 20 or later**
   - Download from: https://nodejs.org/
   - npm is included with Node.js
   - Verify installation: `node --version` and `npm --version`

### PowerShell Execution Policy
You may need to adjust your PowerShell execution policy to run scripts:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 🚀 Quick Start

### Option 1: Automated Setup and Run (Recommended)
```powershell
# 1. Run the complete setup (first time only)
.\setup-all.ps1

# 2. Start both backend and frontend in development mode
.\start-dev.ps1
```

Access the application:
- **Frontend**: http://localhost:3001
- **Backend API**: http://localhost:9000
- **API Docs**: http://localhost:9000/docs

### Option 2: Manual Setup and Individual Services

#### First-Time Setup
```powershell
# Setup backend
.\backend\setup-backend.ps1

# Setup frontend
.\frontend\setup-frontend.ps1
```

#### Run Services Individually
```powershell
# Terminal 1 - Backend
.\backend\run-backend.ps1

# Terminal 2 - Frontend (in a new terminal)
.\frontend\run-frontend-dev.ps1
```

## 📂 Available Scripts

### Root Directory Scripts

| Script | Description |
|--------|-------------|
| `setup-all.ps1` | Sets up both backend and frontend environments |
| `start-dev.ps1` | Runs both services in parallel (development mode) |

### Backend Scripts (`backend\` folder)

| Script | Description | Port |
|--------|-------------|------|
| `setup-backend.ps1` | Creates Python virtual environment and installs dependencies | - |
| `run-backend.ps1` | Runs FastAPI server in development mode (with auto-reload) | 9000 |
| `run-backend-production.ps1` | Runs FastAPI server in production mode (no auto-reload) | 9000 |

### Frontend Scripts (`frontend\` folder)

| Script | Description | Port |
|--------|-------------|------|
| `setup-frontend.ps1` | Installs Node.js dependencies | - |
| `run-frontend-dev.ps1` | Runs Vite development server (with hot-reload) | 3001 |
| `build-frontend.ps1` | Builds production-ready bundle | - |
| `run-frontend-preview.ps1` | Previews production build locally | 5137 |

## 🔧 Configuration

### Backend Environment Variables
The scripts automatically set these environment variables (matching Docker configuration):

```powershell
DATABASE_PATH     = "backend\database\renpy_editor.db"
LOG_LEVEL         = "info"
ENVIRONMENT       = "dev"
CORS_ORIGINS      = "http://localhost:3001,http://localhost:5137"
```

### Frontend Environment Variables
Development mode:
```powershell
NODE_ENV          = "development"
VITE_API_URL      = "http://localhost:9000/api"
VITE_WS_URL       = "ws://localhost:9000"
```

Production build (customize as needed):
```powershell
VITE_API_URL      = "http://localhost:9000/api"  # Change for production
VITE_WS_URL       = "ws://localhost:9000"        # Change for production
```

To customize production URLs, set environment variables before building:
```powershell
$env:VITE_API_URL = "https://your-api-domain.com/api"
$env:VITE_WS_URL = "wss://your-api-domain.com"
.\frontend\build-frontend.ps1
```

## 🐛 Troubleshooting

### Python Issues
**Problem**: "Python is not installed or not in PATH"
- **Solution**: Install Python and ensure it's added to PATH during installation
- Verify with: `python --version`

**Problem**: Virtual environment activation fails
- **Solution**: Run PowerShell as Administrator and set execution policy:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

### Node.js Issues
**Problem**: "Node.js is not installed or not in PATH"
- **Solution**: Install Node.js from https://nodejs.org/
- Verify with: `node --version`

**Problem**: `npm ci` fails
- **Solution**: Delete `node_modules` and `package-lock.json`, then run:
  ```powershell
  npm install
  ```

### Port Conflicts
**Problem**: "Port already in use"
- **Solution**: Check what's using the port:
  ```powershell
  # For backend (port 9000)
  netstat -ano | findstr :9000
  
  # For frontend (port 3001)
  netstat -ano | findstr :3001
  ```
- Kill the process or change the port in the scripts

### Database Issues
**Problem**: Database permission errors
- **Solution**: Ensure the `backend\database` folder has write permissions
- The setup script creates this automatically

## 📊 Comparison: Docker vs PowerShell Scripts

| Feature | Docker | PowerShell Scripts |
|---------|--------|-------------------|
| Setup complexity | Low (docker-compose up) | Medium (run setup scripts) |
| Isolation | Complete | Uses local Python venv |
| Port Configuration | docker-compose.yml | Hard-coded in scripts |
| Auto-reload (dev) | ✅ | ✅ |
| Production build | Multi-stage Dockerfile | Separate build script |
| Database persistence | Docker volumes | Local filesystem |

## 🔄 Development Workflow

### Daily Development
```powershell
# Start both services
.\start-dev.ps1

# Or start individually in separate terminals
.\backend\run-backend.ps1
.\frontend\run-frontend-dev.ps1
```

### Making Changes
- **Backend**: Changes auto-reload (with `--reload` flag)
- **Frontend**: Vite hot-module replacement (HMR) updates instantly

### Adding Dependencies

**Backend** (Python):
```powershell
# Activate virtual environment
.\backend\venv\Scripts\Activate.ps1

# Install new package
pip install package-name

# Update requirements.txt
pip freeze > .\backend\requirements.txt
```

**Frontend** (Node.js):
```powershell
cd frontend
npm install package-name
```

### Production Build
```powershell
# Build frontend
.\frontend\build-frontend.ps1

# The built files will be in frontend\dist\
# Serve with any web server or use the preview:
.\frontend\run-frontend-preview.ps1
```

## 🏭 Production Deployment

### Backend
```powershell
.\backend\run-backend-production.ps1
```

Or use a production ASGI server like Gunicorn (Linux) or hypercorn:
```powershell
pip install hypercorn
hypercorn app.main:app --bind 0.0.0.0:9000
```

### Frontend
1. Build the production bundle:
   ```powershell
   .\frontend\build-frontend.ps1
   ```

2. Serve the `frontend\dist` folder with a web server:
   - **IIS** (Windows)
   - **nginx** or **Apache** (Linux)
   - **Any static file server**

## 📝 Notes

- These scripts replicate the exact behavior of the Docker setup
- The development mode includes auto-reload for both backend and frontend
- Database is stored locally in `backend\database\` instead of a Docker volume
- All environment variables match the docker-compose configuration
- Scripts are designed for Windows PowerShell (PowerShell 5.1+)

## 🆘 Getting Help

If you encounter issues:
1. Check that all prerequisites are installed
2. Review the troubleshooting section above
3. Ensure you've run the setup scripts before running the services
4. Check if ports 3001 and 9000 are available
5. Review the error messages in the console output

## 🔐 Security Notes

- Development mode runs with `--reload` which should **not** be used in production
- The scripts set CORS origins for local development
- Update CORS settings in production for your actual frontend URL
- Ensure proper firewall rules when deploying to production
