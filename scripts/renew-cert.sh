#!/usr/bin/env bash
set -euo pipefail

# Configuration — edit if needed
DOMAIN="example.com"
WEBROOT="/var/www/html"         # if using webroot plugin; leave blank if using standalone
SERVICE_RELOAD_CMD="systemctl reload nginx"  # or "systemctl reload apache2"

# Try certbot renew
if [ -n "$WEBROOT" ]; then
  certbot renew --webroot -w "$WEBROOT" --quiet --deploy-hook "$SERVICE_RELOAD_CMD"
else
  certbot renew --quiet --deploy-hook "$SERVICE_RELOAD_CMD"
fi
