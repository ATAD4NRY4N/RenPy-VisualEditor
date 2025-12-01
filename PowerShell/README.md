# 🎉 PowerShell Scripts - Complete Solution

All scripts and documentation for running RenPy Visual Editor without Docker are now organized in this single **PowerShell** folder.

## 📂 Folder Structure

```
PowerShell/
├── 📄 README.md                     ← You are here
├── 📄 DOCUMENTATION_INDEX.md        ← Start here for navigation
│
├── Setup & Run Scripts
│   ├── 📄 setup-all.ps1            ← First-time setup
│   ├── 📄 start-dev.ps1            ← Daily development
│   └── 📄 cleanup.ps1              ← Reset environment
│
├── Backend Scripts
│   ├── 📄 backend-setup.ps1        ← Setup Python environment
│   ├── 📄 backend-run.ps1          ← Development mode
│   └── 📄 backend-run-production.ps1 ← Production mode
│
├── Frontend Scripts
│   ├── 📄 frontend-setup.ps1       ← Setup Node.js environment
│   ├── 📄 frontend-run-dev.ps1     ← Development server
│   ├── 📄 frontend-build.ps1       ← Production build
│   └── 📄 frontend-preview.ps1     ← Preview build
│
└── Documentation
    ├── 📘 DOCUMENTATION_INDEX.md   ← Navigation hub
    ├── 📘 DOCKER_ALTERNATIVE.md    ← Complete setup guide
    ├── 📘 QUICK_REFERENCE.md       ← Command cheat sheet
    ├── 📘 WORKFLOW_DIAGRAM.md      ← Visual diagrams
    ├── 📘 SCRIPTS_SUMMARY.md       ← Technical details
    ├── 📘 DOCKER_VS_POWERSHELL.md  ← Comparison guide
    └── 📘 SOLUTION_COMPLETE.md     ← Executive summary
```

## 🚀 Quick Start (3 Steps)

```powershell
# Navigate to project root
cd c:\Ataccama\RenPy-VisualEditor

# 1. First-time setup (only needed once)
.\PowerShell\setup-all.ps1

# 2. Start both services
.\PowerShell\start-dev.ps1

# 3. Open your browser
# Frontend: http://localhost:3001
# Backend:  http://localhost:9000
```

## 📋 All Available Scripts

### Main Workflow

| Script | Command | Description |
|--------|---------|-------------|
| **Setup All** | `.\PowerShell\setup-all.ps1` | Complete setup (first time) |
| **Start Dev** | `.\PowerShell\start-dev.ps1` | Start both services |
| **Cleanup** | `.\PowerShell\cleanup.ps1` | Reset environment |

### Backend Scripts

| Script | Command | Description |
|--------|---------|-------------|
| **Setup** | `.\PowerShell\backend-setup.ps1` | Create Python venv |
| **Run Dev** | `.\PowerShell\backend-run.ps1` | Development mode (auto-reload) |
| **Run Prod** | `.\PowerShell\backend-run-production.ps1` | Production mode |

### Frontend Scripts

| Script | Command | Description |
|--------|---------|-------------|
| **Setup** | `.\PowerShell\frontend-setup.ps1` | Install npm packages |
| **Run Dev** | `.\PowerShell\frontend-run-dev.ps1` | Dev server (HMR) |
| **Build** | `.\PowerShell\frontend-build.ps1` | Production build |
| **Preview** | `.\PowerShell\frontend-preview.ps1` | Preview build |

## 📚 Documentation Quick Links

**Essential Reading:**
1. 📘 [DOCUMENTATION_INDEX.md](./DOCUMENTATION_INDEX.md) - Find what you need
2. 📘 [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Complete guide
3. 📘 [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - Daily commands

**Additional Resources:**
- 📘 [WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md) - Visual workflows
- 📘 [SCRIPTS_SUMMARY.md](./SCRIPTS_SUMMARY.md) - Technical details
- 📘 [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md) - Comparison

## 🎯 Prerequisites

Before using these scripts, ensure you have:

- ✅ **Python 3.11+** - https://www.python.org/
- ✅ **Node.js 20+** - https://nodejs.org/
- ✅ **PowerShell 5.1+** (built into Windows)

## 🔗 Service URLs

After running `.\PowerShell\start-dev.ps1`:

| Service | URL | Description |
|---------|-----|-------------|
| 🎨 Frontend | http://localhost:3001 | Web application |
| ⚙️ Backend API | http://localhost:9000 | REST API |
| 📖 API Docs | http://localhost:9000/docs | Swagger UI |

## ✨ Key Features

✅ **Complete Docker Replacement** - Same functionality, no Docker needed
✅ **Easy Setup** - Single command to set up everything
✅ **Auto-Reload** - Changes apply automatically in dev mode
✅ **Production Ready** - Build and deployment scripts included
✅ **Well Documented** - 7 comprehensive documentation files
✅ **Company Policy Friendly** - Works without Docker

## 💡 Daily Workflow

```powershell
# Every day - just run this
.\PowerShell\start-dev.ps1
```

The scripts handle:
- Activating Python virtual environment
- Setting environment variables
- Starting backend with auto-reload
- Starting frontend with HMR
- Running both in parallel

## 🆘 Need Help?

- **Getting Started**: See [DOCUMENTATION_INDEX.md](./DOCUMENTATION_INDEX.md)
- **Setup Issues**: See [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Troubleshooting
- **Command Reference**: See [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
- **Visual Guides**: See [WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md)

## 🎓 Learning Path

**For Beginners:**
1. Read [DOCUMENTATION_INDEX.md](./DOCUMENTATION_INDEX.md)
2. Follow [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Quick Start
3. Bookmark [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)

**For Advanced Users:**
1. Review [SCRIPTS_SUMMARY.md](./SCRIPTS_SUMMARY.md)
2. Compare [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md)
3. Customize scripts as needed

## 🔄 Comparison: Before vs After

**Before (Old Structure):**
```
├── setup-all.ps1              (root)
├── start-dev.ps1              (root)
├── cleanup.ps1                (root)
├── backend/
│   ├── setup-backend.ps1
│   ├── run-backend.ps1
│   └── run-backend-production.ps1
├── frontend/
│   ├── setup-frontend.ps1
│   ├── run-frontend-dev.ps1
│   ├── build-frontend.ps1
│   └── run-frontend-preview.ps1
└── DOCKER_ALTERNATIVE.md (root)
    QUICK_REFERENCE.md (root)
    ... etc
```

**After (New Structure):**
```
PowerShell/
├── All scripts
└── All documentation
```

**Benefits:**
- ✅ Everything in one place
- ✅ Easy to find
- ✅ Cleaner project root
- ✅ Simple to share/backup

---

**Ready to start?** Run `.\PowerShell\setup-all.ps1` from the project root!
