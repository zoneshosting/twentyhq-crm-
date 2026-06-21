#!/usr/bin/env bash
# ===== Twenty CRM - one-click local start (macOS/Linux) =====
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v docker >/dev/null 2>&1; then
  echo "[ERROR] Docker is not installed. Install Docker Desktop / Docker Engine first."
  exit 1
fi

# .env is git-ignored, so create it from the template on first run.
if [ ! -f .env ]; then
  echo "Creating .env from env.local-docker ..."
  cp env.local-docker .env
fi

echo "Pulling images and starting Twenty CRM..."
docker compose pull
docker compose up -d

cat <<'EOF'

============================================================
 Twenty is starting up. First boot runs DB migrations and
 can take 1-3 minutes. Then open:   http://localhost:3300
============================================================

 Useful commands (run in this folder):
   docker compose logs -f server   # watch startup logs
   docker compose down             # stop everything
   docker compose down -v          # stop AND wipe all data
EOF
