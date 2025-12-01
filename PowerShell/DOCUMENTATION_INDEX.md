# 📚 Documentation Index - Docker Alternative

Welcome! This index helps you navigate all the documentation for running RenPy Visual Editor without Docker.

## 🚀 Start Here

**New to this project?** Start with these in order:

1. **[QUICK_REFERENCE.md](./QUICK_REFERENCE.md)** ⚡
   - Quick command reference
   - One-page cheat sheet
   - Perfect for daily use

2. **[DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md)** 📘
   - Complete setup guide
   - Prerequisites and installation
   - Troubleshooting section
   - **Start here if it's your first time**

3. **[README.md](./README.md)** 📖
   - Main project documentation
   - Features and roadmap
   - Links to both Docker and non-Docker setup

## 📂 All Documentation Files

### Essential Guides

| File | Purpose | When to Read |
|------|---------|--------------|
| **[DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md)** | Complete setup guide & troubleshooting | First-time setup |
| **[QUICK_REFERENCE.md](./QUICK_REFERENCE.md)** | Command cheat sheet | Daily development |
| **[WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md)** | Visual workflow diagrams | Understanding the system |

### Deep-Dive Documentation

| File | Purpose | When to Read |
|------|---------|--------------|
| **[SCRIPTS_SUMMARY.md](./SCRIPTS_SUMMARY.md)** | What each script does | Understanding individual scripts |
| **[DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md)** | Detailed comparison | Deciding between Docker/PowerShell |
| **[README.md](./README.md)** | Main project documentation | Project overview |

## 🎯 Find What You Need

### "I want to..."

#### Get Started
- **Set up for the first time**  
  → [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Quick Start section

- **See all available commands**  
  → [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)

- **Understand the workflow**  
  → [WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md)

#### Daily Development
- **Start the development server**  
  → [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - Start Development section

- **Add a new Python package**  
  → [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Development Workflow section

- **Add a new npm package**  
  → [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Development Workflow section

#### Troubleshooting
- **Fix Python/Node.js issues**  
  → [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Troubleshooting section

- **Port already in use**  
  → [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Troubleshooting section

- **Compare with Docker approach**  
  → [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md)

#### Production Deployment
- **Build for production**  
  → [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Production Deployment section

- **Understand production vs development**  
  → [SCRIPTS_SUMMARY.md](./SCRIPTS_SUMMARY.md) - Production Scripts section

#### Understanding the System
- **How do all the scripts work together?**  
  → [WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md)

- **What does each script do?**  
  → [SCRIPTS_SUMMARY.md](./SCRIPTS_SUMMARY.md)

- **Should I use Docker or PowerShell?**  
  → [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md)

## 🛠️ PowerShell Scripts Reference

### Root Directory Scripts

```
.\setup-all.ps1          # First-time complete setup
.\start-dev.ps1          # Start both services (development)
.\cleanup.ps1            # Clean up generated files
```

### Backend Scripts

```
.\backend\setup-backend.ps1              # Setup Python environment
.\backend\run-backend.ps1                # Run in development mode
.\backend\run-backend-production.ps1     # Run in production mode
```

### Frontend Scripts

```
.\frontend\setup-frontend.ps1            # Setup Node.js environment
.\frontend\run-frontend-dev.ps1          # Run development server
.\frontend\build-frontend.ps1            # Build production bundle
.\frontend\run-frontend-preview.ps1      # Preview production build
```

**Detailed descriptions:** See [SCRIPTS_SUMMARY.md](./SCRIPTS_SUMMARY.md)

## 🌐 Service URLs

After running `.\start-dev.ps1`:

- **Frontend**: http://localhost:3001
- **Backend API**: http://localhost:9000
- **API Documentation**: http://localhost:9000/docs

## 📋 Prerequisites Checklist

Before using the PowerShell scripts, ensure you have:

- [ ] **Python 3.11+** installed and in PATH
- [ ] **Node.js 20+** installed and in PATH
- [ ] **PowerShell 5.1+** (built into Windows)
- [ ] PowerShell execution policy set to allow scripts

**Full setup instructions:** [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Prerequisites section

## 🔄 Typical Workflows

### First-Time User

```
1. Read: DOCKER_ALTERNATIVE.md (Prerequisites section)
2. Install: Python 3.11+ and Node.js 20+
3. Run: .\setup-all.ps1
4. Run: .\start-dev.ps1
5. Open: http://localhost:3001
6. Bookmark: QUICK_REFERENCE.md for daily use
```

### Daily Developer

```
1. Run: .\start-dev.ps1
2. Code and make changes (auto-reload works!)
3. Press Ctrl+C when done
```

**See diagrams:** [WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md)

### Before Deployment

```
1. Run: .\frontend\build-frontend.ps1
2. Run: .\frontend\run-frontend-preview.ps1
3. Test: http://localhost:5137
4. Read: DOCKER_ALTERNATIVE.md (Production Deployment section)
```

## ❓ Common Questions

### "Why can't I use Docker?"
Many companies restrict Docker for security or policy reasons. These PowerShell scripts provide a full alternative.

### "Is this as good as Docker?"
Yes! Both approaches run the exact same code. See [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md) for a detailed comparison.

### "Can I switch between Docker and PowerShell?"
Yes! Your database and code work with both. See migration guides in [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md).

### "Will this work on Mac/Linux?"
The PowerShell scripts are designed for Windows. For Mac/Linux, you can adapt them to use bash/zsh, or use Docker.

### "How do I update dependencies?"
See [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Development Workflow section.

## 🆘 Getting Help

If you're stuck:

1. **Check troubleshooting**: [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Troubleshooting section
2. **Review prerequisites**: [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md) - Prerequisites section
3. **Compare with Docker**: [DOCKER_VS_POWERSHELL.md](./DOCKER_VS_POWERSHELL.md)
4. **Understand workflows**: [WORKFLOW_DIAGRAM.md](./WORKFLOW_DIAGRAM.md)

## 📖 Learning Path

**Beginner Track:**
1. QUICK_REFERENCE.md (overview)
2. DOCKER_ALTERNATIVE.md (setup)
3. WORKFLOW_DIAGRAM.md (visual guide)

**Advanced Track:**
1. SCRIPTS_SUMMARY.md (deep dive on scripts)
2. DOCKER_VS_POWERSHELL.md (architectural comparison)

## 🎓 Additional Resources

- **Main Project README**: [README.md](./README.md)
- **FastAPI Documentation**: https://fastapi.tiangolo.com/
- **Vite Documentation**: https://vitejs.dev/
- **Python venv Guide**: https://docs.python.org/3/tutorial/venv.html
- **PowerShell Documentation**: https://docs.microsoft.com/en-us/powershell/

## 📝 Document Summaries

### DOCKER_ALTERNATIVE.md
- **Length**: ~400 lines
- **Covers**: Complete setup, configuration, troubleshooting, production deployment
- **Best for**: First-time users, comprehensive reference

### QUICK_REFERENCE.md
- **Length**: ~100 lines
- **Covers**: All commands, common workflows, quick tips
- **Best for**: Daily development, quick command lookup

### WORKFLOW_DIAGRAM.md
- **Length**: ~300 lines
- **Covers**: ASCII diagrams showing script relationships
- **Best for**: Visual learners, understanding system architecture

### SCRIPTS_SUMMARY.md
- **Length**: ~400 lines
- **Covers**: What was created, how it maps to Docker
- **Best for**: Understanding the complete solution

### DOCKER_VS_POWERSHELL.md
- **Length**: ~500 lines
- **Covers**: Feature comparison, pros/cons, migration paths
- **Best for**: Deciding between approaches, architecture decisions

---

## 🏁 Quick Start (TL;DR)

### Absolute Minimum Steps

```powershell
# 1. First time (one-time setup)
.\setup-all.ps1

# 2. Every time you want to develop
.\start-dev.ps1

# 3. Open browser
http://localhost:3001
```

**That's it!** For more details, see [DOCKER_ALTERNATIVE.md](./DOCKER_ALTERNATIVE.md)

---

**Last Updated**: 2025-12-01  
**Maintained By**: Project Team  
**Purpose**: Docker alternative for restricted environments
