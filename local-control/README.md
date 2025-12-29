


# Local n8n Control Scripts


### Purpose Section

```
These scripts provide a single-click way to start and stop a locally hosted
n8n instance running inside Docker on Windows.

They handle Docker Desktop startup, Docker engine readiness, container
lifecycle management, and browser launching.
```

### What the Script Does

* Checks if Docker Engine is running
* Launches Docker Desktop if required
* Waits until Docker Engine is ready
* Starts or stops the n8n container
* Opens [http://localhost:5678](http://localhost:5678) automatically

### Why This Exists

```
After a system reboot, Docker Desktop is not immediately available.
Attempting to start n8n before Docker is ready causes failures.

This script prevents race conditions and ensures consistent startup behavior.
```

