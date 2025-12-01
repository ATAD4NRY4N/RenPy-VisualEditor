# Quick Reference Card - PowerShell Scripts

## 🚀 First Time Setup
```powershell
.\setup-all.ps1
```

## 🎬 Start Development (Both Services)
```powershell
.\start-dev.ps1
```
- Backend: http://localhost:9000
- Frontend: http://localhost:3001
- API Docs: http://localhost:9000/docs

## 🔧 Individual Services

### Backend Only
```powershell
.\backend\run-backend.ps1              # Development mode (auto-reload)
.\backend\run-backend-production.ps1   # Production mode
```

### Frontend Only
```powershell
.\frontend\run-frontend-dev.ps1        # Development server
.\frontend\build-frontend.ps1          # Build for production
.\frontend\run-frontend-preview.ps1    # Preview production build
```

## 🧹 Cleanup
```powershell
.\cleanup.ps1   # Remove all generated files and dependencies
```

## 📍 Ports

| Service | Port | URL |
|---------|------|-----|
| Backend API (dev) | 9000 | http://localhost:9000 |
| Backend API Docs | 9000 | http://localhost:9000/docs |
| Frontend (dev) | 3001 | http://localhost:3001 |
| Frontend (preview) | 5137 | http://localhost:5137 |

## 🔄 Typical Workflow

```powershell
# Day 1 - First time
.\setup-all.ps1                 # Setup everything
.\start-dev.ps1                 # Start developing

# Day 2+ - Daily development
.\start-dev.ps1                 # Just start and code

# Before deployment
.\frontend\build-frontend.ps1   # Build production bundle
.\backend\run-backend-production.ps1  # Test production backend
```

## 📦 Adding Dependencies

### Python (Backend)
```powershell
.\backend\venv\Scripts\Activate.ps1
pip install package-name
pip freeze > .\backend\requirements.txt
```

### Node.js (Frontend)
```powershell
cd frontend
npm install package-name
```

## 🆘 Common Issues

### Scripts won't run?
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Port already in use?
```powershell
# Check what's using the port
netstat -ano | findstr :9000   # Backend
netstat -ano | findstr :3001   # Frontend
```

### Need to start fresh?
```powershell
.\cleanup.ps1
.\setup-all.ps1
```

## 📚 Full Documentation
See [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) for complete details.
