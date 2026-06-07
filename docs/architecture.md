            🏗️ Architecture Overview

Network Segments:

| Segment | Purpose |
|---------|---------|
| mgmt-lan | Management access |
| dmz | WAF / Reverse proxy layer |
| isolated-lan | Internal web servers |
| dmz-clients | Client / host |


Traffic Flow:
Client → pfSense → dmz-proxy (WAF) → Web Server → PHP-FPM


Key Components:

dmz-proxy
- nginx reverse proxy
- ModSecurity + OWASP CRS (1848 rules)
- Blocks: SQLi, XSS, Path Traversal, Scanners

Web Serve
- Apache :443 SSL frontend
- nginx :9999 PHP backend
- PHP 8.4-FPM
- SQLite3 database

Monitoring
- Grafana + Prometheus + Loki
- Real-time ModSecurity alert dashboard
- Live WAF logs via REST API

TLS
- Protocol: TLSv1.2 / TLSv1.3 only
- TLS 1.0 / 1.1: disabled
- Auto-renewal: cron script
- Headers: HSTS, CSP, X-Frame-Options
