# Test mails with **expected WhatsApp outputs**

Use these to **verify correctness** and document behavior.

---

###   Test Mail 1 — Role + Deadline present

**Subject**

```
INTERNSHIP Opportunity – Embedded Systems
```

**Body**

```
Dear Students,

We are hiring for an Embedded Systems Intern role.

Role: Embedded Systems Intern
Application Deadline: 15 January 2026

Regards,
Industry Relations Cell
```

**Expected WhatsApp**

```
Internship Alert

Role: Embedded Systems Intern
Deadline: 15 January 2026
Email received at: <time>
Subject: INTERNSHIP Opportunity – Embedded Systems

Check your Gmail inbox for details.
```

---

###   Test Mail 2 — Role present, deadline missing

**Subject**

```
Internship Opportunity – VLSI Design
```

**Body**

```
Dear Students,

A VLSI Design Internship opportunity is available.
Further details will be shared later.

Regards,
CDC VIT
```

**Expected WhatsApp**

```
Internship Alert

Role: VLSI Design Internship
Deadline: NOT FOUND
Email received at: <time>
Subject: Internship Opportunity – VLSI Design

Check your Gmail inbox for details.
```

---

###   Test Mail 3 — No clear role, no deadline

**Subject**

```
Internship Information
```

**Body**

```
Dear Students,

An internship opportunity is available.
Please refer to the attached document for details.

Regards,
CDC VIT
```

**Expected WhatsApp**

```
Internship Alert

Role: CHECK MAIL
Deadline: NOT FOUND
Email received at: <time>
Subject: Internship Information

Check your Gmail inbox for details.
```

---

###   Test Mail 4 — Keyword only in BODY

**Subject**

```
Forwarded Message
```

**Body**

```
Dear Students,

We are hiring Software Engineer Interns.
Apply before 31 January 2026.

Regards,
Placement Office
```

**Expected WhatsApp**

```
Internship Alert

Role: Software Engineer Intern
Deadline: 31 January 2026
Email received at: <time>
Subject: Forwarded Message

Check your Gmail inbox for details.
```

---

###   Test Mail 5 — AI failure simulation

**Subject**

```
INTERNSHIP Update
```

**Body**

```
Details are available in the attached PDF.
```

**Expected WhatsApp**

```
Internship Alert

Role: CHECK MAIL
Deadline: NOT FOUND
Email received at: <time>
Subject: INTERNSHIP Update

Check your Gmail inbox for details.
```
