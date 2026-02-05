![Secure Status](https://img.shields.io/github/deployments/Myghtyy/devsecops-pipeline-lab/Production?label=Secure%20Remediation)
# 🛡️ Multi-Stage DevSecOps Security Pipeline

A production-ready CI/CD pipeline demonstrating the transition from a vulnerable "Legacy" environment to a hardened, zero-vulnerability containerized application.

## Overview
This project showcases approach to container security. Using GitHub Actions and Trivy, the pipeline runs two parallel tracks to validate security posture:

1.  **The Vulnerable Audit (Legacy):** Scans a Node.js app on Ubuntu 18.04 with outdated dependencies.
2.  **The Secure Remediation (Hardened):** Scans the same app migrated to Node 22 (Alpine) with modern patches and dependency overrides.

## 🛠️ Tech Stack
* **CI/CD:** GitHub Actions
* **Security Scanning:** Trivy (Vulnerability Scanner)
* **Containerization:** Docker (Multi-stage builds)
* **Reporting:** WeasyPrint (HTML to PDF automated reporting)
* **Runtime:** Node.js (Express)

## Pipeline Architecture
The pipeline is designed as a **Security Gate**. If High or Critical vulnerabilities are found in the "Secure" lane, the build fails automatically.

| Feature | Insecure Build | Secure Build |
| :--- | :--- | :--- |
| **Base OS** | Ubuntu 18.04 (EOL) | Alpine Linux (Hardened) |
| **Node Version** | Legacy | Node 22 (Current LTS) |
| **Dependency Logic** | Vulnerable versions | npm Overrides (Force-patched) |
| **Trivy Result** | ~18 High/Critical | **0 Vulnerabilities** |

## 🛡️ Security Remediation Steps
To achieve a green build, the following hardening steps were implemented:
1.  **Base Image Migration:** Switched from a bloated Debian/Ubuntu base to Alpine to reduce the attack surface.
2.  **User Hardening:** Configured the container to run as a non-root user (`USER sneh`) to prevent privilege escalation.
3.  **Dependency Patching:** Used `npm overrides` to force-patch sub-dependencies (`tar`, `glob`, `qs`) that were not directly upgradeable via top-level packages.
4.  **Automated Compliance:** Integrated PDF report generation into the CI/CD flow for audit trail maintenance.

## 📁 Artifacts
Upon every push, the pipeline generates:
* `Insecure-Audit-Report.pdf`: A detailed list of vulnerabilities for remediation planning.
* `Secure-Remediation-Report.pdf`: Evidence of a clean, compliant build.

---
Created by Sneh Todarmal - 2026 DevSecOps Lab
