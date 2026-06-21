# Twenty CRM — local Docker bundle

A self-contained setup to run the **full** Twenty CRM (frontend + backend + Postgres
+ Redis + worker) on your own machine with Docker. Uses Twenty's official prebuilt
images, so **nothing needs to be compiled** — Docker just downloads and runs them.

## Requirements
- **Docker Desktop** installed and **running**
  (Windows: https://www.docker.com/products/docker-desktop/)
- ~4 GB free RAM and a few GB of disk for the images.

## Get it onto `H:\00-Claude`
This bundle lives in the repo under `00-claude-local-docker/`. On your Windows PC:

```powershell
# from wherever you cloned the repo, copy this folder to H:\00-Claude
xcopy /E /I 00-claude-local-docker H:\00-Claude
```

(Or just clone the repo branch and copy this folder over.)

## Run it
1. Make sure **Docker Desktop is running**.
2. Open `H:\00-Claude`.
3. Double-click **`start.bat`** (or in a terminal: `docker compose up -d`).
4. Wait 1–3 minutes on first boot (it creates the database and runs migrations).
5. Open **http://localhost:3000** and create your workspace / account.

## Everyday commands
Run these from inside `H:\00-Claude`:

| Action | Command |
|---|---|
| Start | `docker compose up -d` |
| Watch startup logs | `docker compose logs -f server` |
| Stop (keeps data) | `docker compose down` |
| Stop **and wipe all data** | `docker compose down -v` |
| Update to latest version | `docker compose pull` then `docker compose up -d` |

## What's inside
- `docker-compose.yml` — the 4 services (server, worker, db, redis)
- `.env` — config with a **freshly generated `ENCRYPTION_KEY`** and DB password
- `start.bat` / `start.sh` — convenience launchers

## Notes
- Data persists in Docker named volumes (`db-data`, `server-local-data`), not in this
  folder. `docker compose down -v` deletes them.
- Keep the `ENCRYPTION_KEY` in `.env` safe — losing it means existing encrypted data
  can't be recovered.
- This runs everything locally on `localhost`. To expose it on your network or a
  domain, change `SERVER_URL` in `.env` and add a reverse proxy / port mapping.
