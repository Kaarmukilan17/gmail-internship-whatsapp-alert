
# Local n8n Control Scripts

## Purpose

These scripts provide a reliable single-click way to start and stop a locally
hosted n8n instance running inside Docker on Windows.

They handle Docker Desktop startup, Docker engine readiness, n8n container
recovery, and browser launching.

## What the Script Does

- Checks whether Docker Desktop / Docker Engine is running
- Launches Docker Desktop automatically if required
- Waits until the Docker engine is fully ready
- Detects existing n8n containers (running or stopped)
- Starts, resumes, or stops the n8n container appropriately
- Opens http://localhost:5678 automatically when n8n is ready

## Why This Exists

```

After a system reboot or forced shutdown, Docker may retain containers
in a stopped state. Attempting to recreate containers with the same name
causes startup failures.

This script handles Docker engine delays and recovers existing n8n containers
instead of recreating them, ensuring consistent behavior across reboots.

```

## Key Improvement (New Version)

- Handles **stopped containers left after reboot**
- Avoids container name conflicts
- Behaves like `docker compose up` using plain Docker
- Eliminates the need for manual Docker cleanup

