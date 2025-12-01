# Docker vs PowerShell Scripts - Feature Comparison

This document provides a detailed comparison between using Docker and the PowerShell script alternative.

## Quick Comparison Table

| Feature | Docker | PowerShell Scripts |
|---------|--------|-------------------|
| **Setup Complexity** | Low (single command) | Medium (requires Python & Node.js) |
| **Initial Setup Time** | Fast (if Docker installed) | Moderate (first-time dependency install) |
| **Isolation** | Complete container isolation | Python venv + local node_modules |
| **Performance** | Small overhead | Native performance |
| **Disk Space** | Larger (images + containers) | Smaller (no images) |
| **Port Management** | Docker handles it | Direct OS port binding |
| **Environment Variables** | docker-compose.yml | Set in PowerShell scripts |
| **Hot Reload (Dev)** | ✅ Yes | ✅ Yes |
| **Production Ready** | ✅ Yes (multi-stage build) | ✅ Yes (separate build scripts) |
| **Cross-Platform** | ✅ Yes (Linux/Mac/Windows) | ⚠️ Windows PowerShell only |
| **Company Policy** | ❌ May be restricted | ✅ Usually allowed |
| **Debugging** | Harder (inside container) | Easier (native processes) |
| **Dependency Updates** | Rebuild image | Re-run setup script |

## Detailed Feature Breakdown

### 1. Setup & Installation

#### Docker Approach
```bash
# Prerequisites
- Install Docker Desktop
- Install Docker Compose (usually bundled)

# Setup
docker-compose up --build

# That's it!
```

**Pros:**
- Single command to start
- All dependencies bundled
- Consistent across machines

**Cons:**
- Docker Desktop may be restricted by IT policy
- Requires admin rights to install
- Larger download size

#### PowerShell Scripts Approach
```powershell
# Prerequisites
- Install Python 3.11+
- Install Node.js 20+

# Setup
.\setup-all.ps1

# Start
.\start-dev.ps1
```

**Pros:**
- No Docker required (bypasses company restrictions)
- Standard development tools
- Native OS integration

**Cons:**
- Requires manual installation of Python & Node.js
- More setup steps
- Must manage dependencies yourself

---

### 2. Development Workflow

#### Docker Approach
```bash
# Start development
docker-compose up

# View logs
docker-compose logs -f

# Stop
docker-compose down

# Rebuild
docker-compose up --build
```

**Docker Dev Features:**
- ✅ Volume mounts for live code updates
- ✅ Hot reload enabled via override file
- ✅ Database persistence via named volumes
- ✅ Network isolation
- ⚠️ May have file permission issues on Windows

#### PowerShell Scripts Approach
```powershell
# Start development
.\start-dev.ps1

# Stop
Ctrl+C

# Reset environment
.\cleanup.ps1
.\setup-all.ps1
```

**PowerShell Dev Features:**
- ✅ Direct file access (no mounting issues)
- ✅ Hot reload enabled in scripts
- ✅ Database in local filesystem
- ✅ Easier to inspect processes
- ✅ Native IDE integration

---

### 3. Environment Configuration

#### Docker Environment Variables

**Defined in:** `docker-compose.yml` and `.env` file

```yaml
environment:
  - DATABASE_PATH=/app/database/renpy_editor.db
  - LOG_LEVEL=info
  - VITE_API_URL=${VITE_API_URL}
  - VITE_WS_URL=${VITE_WS_URL}
```

**Managed by:** Docker Compose automatically

#### PowerShell Environment Variables

**Defined in:** Each run script

```powershell
$env:DATABASE_PATH = "backend\database\renpy_editor.db"
$env:LOG_LEVEL = "info"
$env:VITE_API_URL = "http://localhost:9000/api"
$env:VITE_WS_URL = "ws://localhost:9000"
```

**Managed by:** Script execution

**Comparison:**
| Aspect | Docker | PowerShell |
|--------|--------|-----------|
| Centralized config | ✅ Yes (.env file) | ⚠️ In each script |
| Change requires | Restart containers | Restart scripts |
| Visibility | docker-compose.yml | Read script files |

---

### 4. Production Deployment

#### Docker Production

```bash
# Build production image
docker-compose build

# Run in production mode
docker-compose up -d

# View logs
docker-compose logs -f
```

**Production Features:**
- Multi-stage builds (smaller images)
- Nginx serving static files
- Automatic restarts
- Easy horizontal scaling

#### PowerShell Production

```powershell
# Build frontend
.\frontend\build-frontend.ps1

# Run backend in production mode
.\backend\run-backend-production.ps1

# Serve frontend with IIS/nginx/Apache
# (Deploy dist/ folder to web server)
```

**Production Features:**
- Separate build process
- Manual web server configuration
- Traditional deployment model
- Easier to customize

**Recommendation:** For production, Docker is often easier, but PowerShell approach works fine with traditional web servers.

---

### 5. Resource Usage

#### Docker
```
Typical Resource Usage:
- RAM: ~500 MB - 1 GB (Docker daemon + containers)
- Disk: ~2-3 GB (images + volumes)
- CPU: Small overhead for virtualization
```

#### PowerShell Scripts
```
Typical Resource Usage:
- RAM: ~200-400 MB (Python + Node processes)
- Disk: ~500 MB - 1 GB (venv + node_modules)
- CPU: Direct native execution (no overhead)
```

**Winner:** PowerShell scripts use fewer resources

---

### 6. Database & Persistence

#### Docker

**Storage:** Docker named volume `renpy_editor_db`

```bash
# Backup database
docker cp renpy-backend:/app/database/renpy_editor.db ./backup.db

# Clear database
docker-compose down -v  # Removes volumes!
```

**Pros:**
- Persists across container restarts
- Easy to reset

**Cons:**
- Harder to access directly
- Requires Docker commands

#### PowerShell Scripts

**Storage:** Local file `backend\database\renpy_editor.db`

```powershell
# Backup database
Copy-Item backend\database\renpy_editor.db backup.db

# Clear database
Remove-Item backend\database\renpy_editor.db
```

**Pros:**
- Direct file access
- Easy to backup/inspect
- Works with SQLite tools

**Cons:**
- Must manually manage

**Winner:** PowerShell scripts are easier for development

---

### 7. Port Management

#### Docker

**Configuration:** In `docker-compose.yml`

```yaml
ports:
  - "9000:9000"  # host:container
  - "3001:3000"
```

**Features:**
- Port mapping from container to host
- Can run multiple projects without conflicts
- Internal Docker network

#### PowerShell Scripts

**Configuration:** Hard-coded in scripts

```powershell
uvicorn app.main:app --host 0.0.0.0 --port 9000
npm run dev -- --host 0.0.0.0 --port 3001
```

**Features:**
- Direct port binding
- Need to ensure ports are free
- Can conflict with other apps

**Winner:** Docker is more flexible for port management

---

### 8. Debugging & Development Tools

#### Docker Debugging

```bash
# Access container shell
docker exec -it renpy-backend bash

# View logs
docker-compose logs -f backend

# Inspect container
docker inspect renpy-backend
```

**Challenges:**
- Debugging inside container
- Path mapping confusion
- IDE integration can be tricky

#### PowerShell Debugging

```powershell
# Logs are directly in console
.\start-dev.ps1

# Access Python debugger
.\backend\venv\Scripts\Activate.ps1
python -m pdb app/main.py

# Process inspection
Get-Process | Where-Object {$_.ProcessName -like "*python*"}
```

**Advantages:**
- Native IDE integration
- Direct process access
- Standard debugging tools work

**Winner:** PowerShell scripts are easier to debug

---

### 9. Team Collaboration

#### Docker

**Setup for new team member:**
1. Clone repository
2. Install Docker
3. Run `docker-compose up --build`
4. Done!

**Pros:**
- Consistent environment
- Same versions everywhere
- "It works on my machine" → rarely happens

**Cons:**
- Everyone needs Docker
- May not work if Docker is restricted

#### PowerShell Scripts

**Setup for new team member:**
1. Clone repository
2. Install Python 3.11+
3. Install Node.js 20+
4. Run `.\setup-all.ps1`
5. Run `.\start-dev.ps1`

**Pros:**
- Works in restricted environments
- Standard tools

**Cons:**
- Version mismatches possible
- More manual setup
- Need to document prerequisites

**Winner:** Docker for consistency, PowerShell for flexibility

---

### 10. Updating Dependencies

#### Docker

```bash
# Backend: Update requirements.txt, then
docker-compose build backend
docker-compose up -d

# Frontend: Update package.json, then
docker-compose build frontend
docker-compose up -d
```

**Process:** Rebuild images when dependencies change

#### PowerShell Scripts

```powershell
# Backend: Update requirements.txt, then
.\backend\venv\Scripts\Activate.ps1
pip install -r requirements.txt

# Frontend: Update package.json, then
cd frontend
npm install
```

**Process:** Re-run installation commands

**Winner:** Tie - both are straightforward

---

## Migration Path: Docker → PowerShell

If you've been using Docker and need to switch:

1. **Export any data:**
   ```bash
   docker cp renpy-backend:/app/database/renpy_editor.db ./backend/database/
   ```

2. **Stop Docker:**
   ```bash
   docker-compose down
   ```

3. **Run PowerShell setup:**
   ```powershell
   .\setup-all.ps1
   ```

4. **Start with PowerShell:**
   ```powershell
   .\start-dev.ps1
   ```

Your database and code are preserved!

---

## Migration Path: PowerShell → Docker

If you want to switch back to Docker:

1. **Ensure database is in correct location:**
   ```powershell
   # It should be at: backend\database\renpy_editor.db
   ```

2. **Stop PowerShell services:**
   ```powershell
   # Press Ctrl+C in start-dev.ps1
   ```

3. **Create .env file:**
   ```bash
   VITE_API_URL=http://localhost:9000/api
   VITE_WS_URL=ws://localhost:9000
   ```

4. **Start Docker:**
   ```bash
   docker-compose up --build
   ```

Your data transfers seamlessly!

---

## Recommendation Guide

### Use Docker if:
- ✅ You have Docker installed and allowed
- ✅ You want the easiest setup
- ✅ You need consistent environments across team
- ✅ You're deploying to containerized infrastructure
- ✅ You want to run multiple projects simultaneously

### Use PowerShell Scripts if:
- ✅ Docker is blocked by company policy
- ✅ You don't have admin rights to install Docker
- ✅ You prefer native development tools
- ✅ You need easier debugging
- ✅ You want better IDE integration
- ✅ You're on Windows and prefer PowerShell

---

## Hybrid Approach

You can also use both:

**Development:** PowerShell scripts (easier debugging)
**Production:** Docker (easier deployment)

Both approaches use the same code and database format!

---

## Summary Matrix

| Requirement | Best Choice |
|------------|-------------|
| Company blocks Docker | **PowerShell** |
| Need consistent team environments | **Docker** |
| Want easier debugging | **PowerShell** |
| Deploying to cloud containers | **Docker** |
| Limited disk space | **PowerShell** |
| New team member setup speed | **Docker** |
| IDE integration | **PowerShell** |
| Need to run multiple projects | **Docker** |
| Traditional web server deployment | **PowerShell** |
| Windows-only development | **PowerShell** |

---

## Conclusion

✅ **Docker**: Best for production-like environments and team consistency
✅ **PowerShell Scripts**: Best when Docker isn't available or you want native development

Both approaches are **fully functional** and **production-ready**. Choose based on your constraints and preferences!
