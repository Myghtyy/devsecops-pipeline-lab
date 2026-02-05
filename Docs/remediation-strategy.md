# 🛡️ Remediation Strategy: Hardening the Container Lifecycle

This document outlines the systematic approach used to remediate **12 High-Severity vulnerabilities** identified in the legacy application. The strategy focuses on **Defense in Depth**, moving beyond simple version updates to architectural hardening.

---

## Phase 1: Base Image Transformation
**The Problem:** The legacy image was built on `Ubuntu 18.04`, which contains outdated system utilities and a large footprint, providing a massive attack surface for potential exploits.

**The Remediation:**
* **Migration to Alpine Linux:** Switched the base image to `node:22-alpine`.
* **Impact:** Reduced the final image size by **~80%** and removed hundreds of non-essential OS packages (shells, compilers, etc.) that are common targets for hackers.



---

## Phase 2: Dependency "Force-Patching"
**The Problem:** Many vulnerabilities were located in **transitive dependencies** (libraries that our main libraries use). Standard `npm update` commands often fail to reach.

**The Remediation:**
* **Implementation of `npm overrides`:** Manually forced the resolution of vulnerable sub-packages to secure versions.
    * **`tar`**: Forced upgrade to `v7.5.7` to prevent arbitrary file overwrite exploits.
    * **`glob`**: Forced upgrade to `v11.1.0` to prevent command injection via malicious filenames.
    * **`qs` & `path-to-regexp`**: Updated to secure versions to mitigate Regular Expression Denial of Service (ReDoS) attacks.

---

## Phase 3: Runtime Hardening (Least Privilege)
**The Problem:** By default, Docker containers run as the **root** user. If an application is compromised, the attacker inherits root access to the entire container environment.

**The Remediation:**
* **Non-Root Execution:** Created a dedicated system user `sneh` within the Dockerfile.
* **Permissions:** Configured the application to run under this restricted user, ensuring that even in the event of a breach, the attacker cannot modify system files or install malicious tools
