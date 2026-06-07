#!/usr/bin/env bash
set -euo pipefail
SERVICE_RELOAD_CMD="systemctl reload nginx"

# Run certbot renew and reload if any cert renewed
if certbot renew --quiet --deploy-hook "$SERVICE_RELOAD_CMD"; then
  exit 0
else
  exit 1
fi
___

#sudo chmod +x /usr/local/bin/renew-cert-cron.sh
#sudo crontab -e
# add line to run twice daily
#0 */12 * * * /usr/local/bin/renew-cert-cron.sh >> /var/log/certbot-renew.log 2>&1
