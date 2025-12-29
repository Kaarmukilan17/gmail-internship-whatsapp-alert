

# Gmail Internship Alert → WhatsApp Notifier (n8n)

**Have you ever missed an internship opportunity just because you didn’t check your email on time?**
If yes, this project solves exactly that problem.

This automation continuously monitors your Gmail inbox for internship-related emails and instantly sends a WhatsApp notification, ensuring you never miss time-sensitive opportunities.

The system is designed to be **free-tier friendly**, reliable, and simple enough to maintain without complex infrastructure.

---

## What This Project Does

* Monitors Gmail automatically at a fixed interval (1–5 minutes)
* Detects internship-related emails using keyword matching
* Sends one WhatsApp alert per matching email
* Includes email received time and subject
* Optionally extracts role and deadline using AI (with safe fallback)
* Sends scheduled health-check messages to ensure reliability
* Runs 24/7 on n8n Cloud, even when your laptop is turned off

---

## How It Works

High-level workflow:

```
Gmail Inbox
  → Gmail Trigger (n8n)
  → Internship Keyword Filter
  → Optional AI Extraction (role, deadline)
  → Message Formatter
  → WhatsApp Alert (Gupshup Sandbox)
```


[![Workflow Overview](screenshots/workflow-overview.png)](screenshots/workflow-overview.png)

A **separate scheduled workflow** sends daily health-check messages to confirm that WhatsApp delivery is working and to avoid sandbox inactivity issues.

[![Workflow Overview](screenshots/workflow-overview-n8n.png)](screenshots/workflow-overview.png)


## Technologies Used

* n8n Cloud (free tier)
* Gmail Trigger (OAuth)
* Gupshup WhatsApp Sandbox
* OpenAI gpt-4o-mini (optional, free credits)

---

<details>
<summary><strong>Credentials Configuration</strong></summary>


## Credentials Configuration

### Gmail (Email Monitoring)

* Gmail account used: **college email inbox**
* Authentication method: OAuth 2.0
* Gmail API is used to monitor incoming emails

**High-level steps:**

1. Create a Google Cloud project
2. Enable Gmail API
3. Configure OAuth consent screen
4. Create OAuth 2.0 Client ID (Web application)
5. Add redirect URI:

   ```
   http://localhost:5678/rest/oauth2-credential/callback
   ```
6. Add Client ID and Client Secret to n8n
7. Authorize access using the monitored Gmail account

---

### WhatsApp (Message Delivery)

* Messages are sent using an HTTP-based WhatsApp provider
* Configuration uses an HTTP Request node in n8n
* Authentication is handled using API keys in request headers

**Required values:**

* API endpoint URL
* Authorization key or token
* Destination phone number


---
</details>

## Repository Structure

```

├── README.md
├── workflow/
│   └── Gmail Internship Alert to WhatsApp Notifier.json
├── screenshots/
│   ├── workflow-overview.png
│   └── whatsapp-alert.png
└── examples/
    └── test-emails.md
```

## Who This Project Is For

* Students tracking internship opportunities
* Beginners learning workflow automation
* Users who want WhatsApp alerts without paid tools
* Engineers exploring practical n8n use cases

---





## Local Migration (Self-Hosted n8n)

This project was originally built using **n8n Cloud** and later migrated to a **fully local self-hosted n8n setup** using Docker.

### Why Local Migration?

The local setup was introduced to:

* Avoid cloud usage limits
* Retain full control over credentials and data
* Enable offline development and debugging
* Ensure long-term reliability without dependency on hosted plans

<details>
<summary><strong>More on Local setup</strong></summary>


### Local Setup Overview

In the local version:

* n8n runs inside a Docker container
* Workflow data is persisted using a local volume
* Gmail and WhatsApp integrations remain unchanged in logic
* System-level automation is added to manage Docker startup

---

### Local Architecture

```
Windows OS
 ├── Docker Desktop (WSL2 backend)
 │    └── n8n container
 │         ├── Workflows
 │         ├── Credentials
 │         └── SQLite database
 │
 ├── Local control scripts
 │    └── Start / Stop automation
 │
 └── Browser
      └── http://localhost:5678
```

---

### Why Extra Startup Logic Was Needed

After a system reboot:

* Docker Desktop does not start automatically
* Docker Engine is not immediately available
* Any Docker command fails until the engine is ready

To solve this, a local control script was added that:

* Launches Docker Desktop if not running
* Waits until Docker Engine is fully ready
* Starts or stops the n8n container
* Opens the browser automatically once n8n is accessible

This ensures **one-click reliability**, even after a cold reboot.

## Local n8n Setup

### Prerequisites

* Windows 10/11
* Docker Desktop (WSL2 enabled)
* PowerShell
* Internet access (for Gmail / WhatsApp APIs)

---

### Step 1: Install Docker Desktop

* Install Docker Desktop for Windows
* Enable WSL2 backend
* Ensure Docker Desktop can run Linux containers

---

### Step 2: Start Local n8n

Use the provided local control script to start n8n:

```
local-control/n8n-control.bat
```

Once started, n8n will be available at:

```
http://localhost:5678
```

---

</details>





<details>
<summary><strong>Improvements</strong></summary>

## Possible Improvements

* Automatic startup on Windows login
* Background execution without terminal window
* System tray toggle
* Enhanced logging and alert health checks
* Workflow backup and versioning


* Full email body parsing (paid Gmail API)
* Database-backed daily summaries
* Production WhatsApp Business API
* Role categorization and prioritization
* Company name normalization



### Language Model Integration (Optional)

The workflow supports optional structured information extraction using an external language model.

* API credentials are configured inside n8n
* Workflow execution does not depend on this step
* Message delivery continues even if this step is unavailable



</details>

<details>
<summary><strong>Limitations</strong></summary>

## Why This Project Is Free (and Its Limitations)

This project is intentionally built using **free services**, which introduces some expected limitations.

### Known Limitations

* Full email body is **not processed**
* Only the Gmail **snippet** (short preview text) is analyzed
* Company name is not always detectable (many emails are forwarded by universities)
* AI credits are limited and may expire
* WhatsApp sandbox may temporarily deactivate after inactivity
* No persistent database is used for long-term storage

These trade-offs were chosen to keep the system **cost-free, stable, and easy to maintain**.




</details>
<details>
<summary><strong>More</strong></summary>

<br>

---

## Why Only the Email Snippet Is Used

* Gmail provides a short preview (snippet) by default
* Avoids complex MIME parsing
* Faster and safer for free-tier usage
* Enough to detect internship intent, role, and early deadlines

This design prioritizes **reliability over completeness**.

---

## AI Extraction (Optional and Non-Blocking)

* Uses OpenAI gpt-4o-mini
* Attempts to extract:

  * Role / intent
  * Application deadline
* If AI fails:

  * Workflow continues normally
  * WhatsApp alert is still sent
  * Fallback values are used

AI is treated as an enhancement, never a dependency.

---

## Reliability Features

* Twice-daily WhatsApp health-check messages
* AI nodes configured with “continue on fail”
* No duplicate alerts
* One email results in exactly one WhatsApp message
* Credentials and triggers remain isolated and unchanged

---

## Deployment and Portability

This workflow can be exported as a JSON file and imported into:

* Self-hosted n8n
* Docker-based n8n
* Cloud VM (AWS / GCP free tier)

Credentials must be reconnected manually for security reasons.

---
</details>


