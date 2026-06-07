# galaxy-security-lab
cybersecurity homelab

Galaxy Security Lab

Personal cybersecurity homelab — DMZ architecture with WAF, reverse proxy, TLS hardening, and real-time threat monitoring. Built on KVM/libvirt with network segmentation across multiple VLANs.

🏗️ Architecture

Internet
    │
    ▼
pfSense 2.8.1 (Firewall/Router)
    ├── mgmt-lan      10.0.0.0/24
    ├── dmz           10.0.3.0/24
    └── isolated-lan  10.0.2.0/24
                           │
              ┌────────────┴──────────────┐
              ▼                           ▼
         dmz-proxy                   Web Server
    nginx + ModSecurity           nginx + Apache
      OWASP CRS WAF               PHP + PostgreSQL
              │
              ▼
     Client / Jump Host
     Full Galaxy Web Stack

    ⚠️ IP ranges and hostnames anonymized for publication

🛠️ Stack
Component 	Technology
Hypervisor 	KVM / libvirt
Firewall 	pfSense 2.8.1 + HAProxy
WAF 	nginx + ModSecurity + OWASP CRS 3.3.7
Web Frontend 	Apache 2.4 (multi-vhost)
Web Backend 	nginx (PHP-FPM proxy)
Runtime 	PHP 8.4-FPM
Database 	SQLite3 / PostgreSQL
Monitoring 	Grafana + Loki + Prometheus
OS 	Debian 13 trixie, OpenWrt
🔐 Security Features

    ModSecurity WAF with OWASP CRS — 1848+ active rules
    TLS 1.2 / 1.3 only — TLS 1.0 and 1.1 explicitly disabled
    Security Headers — HSTS (2yr), X-Frame-Options, CSP, Referrer-Policy
    Certificate Auto-renewal — cron-based cert management
    Real-time IDS — ModSecurity audit logging with live dashboard
    Network Segmentation — DMZ, isolated-lan, management VLANs

🌐 Galaxy Web Stack

https://<host>/          → 🌐 System Hub
https://<host>:8082/     → 🔐 SECURIT Lab
https://<host>:8083/     → 📊 IT Monitor (PHP + SQLite)
https://<host>:8084/     → ⚖️ Load Balancer Dashboard
https://<host>:9443/galaxy/ → 🌌 Galaxy Control Center

Architecture:

Browser → Apache:443 (SSL frontend)
              ↓
         nginx:9999 (PHP-FPM backend)

📊 Live Security Monitoring

Browser → security-alerts.html
               ↓ fetch (CORS)
        dmz-proxy/modsec-api.php
               ↓ parses
        /var/log/nginx/modsec_audit.log

🚀 Attack Testing (OWASP Top 10)
Attack Vector 	Detection 	Action
SQL Injection (libinjection) 	Rule 942100 	403 Blocked
XSS 	Rule 941100 	403 Blocked
Path Traversal 	Rule 930100 	403 Blocked
Scanner UA (sqlmap, Nikto) 	Rule 913100 	403 Blocked
Command Injection 	Rule 932100 	403 Blocked
Anomaly Score ≥ 5 	Rule 949110 	Phase 2 Block
📁 Repository Structure

├── README.md
├── configs/
│   ├── nginx/
│   │   ├── nginx.conf
│   │   ├── sites-available/
│   │   └── modsecurity/
│   └── apache/
│       └── sites-available/
├── scripts/
│   ├── renew-cert.sh
│   └── modsec-api.php
└── docs/
    ├── architecture.md
    ├── setup-howto.md
    └── hardening-checklist.md

📚 Background
Self-directed research project — practical implementation of enterprise security architecture concepts including network segmentation, WAF deployment, TLS hardening and real-time threat monitoring.

💡 Skills
Linux Network Security nginx Apache ModSecurity/WAF TLS Hardening pfSense KVM/libvirt PHP SQLite Grafana Prometheus Loki Bash OpenWrt
