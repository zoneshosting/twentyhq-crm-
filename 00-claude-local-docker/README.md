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
5. Open **http://localhost:3300** and create your workspace / account.

> Runs on host port **3300** (mapped to the container's 3000) to avoid clashing
> with anything already using 3000. To change it, edit the `ports` line in
> `docker-compose.yml` **and** `SERVER_URL` in `.env` to the same port.

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
- `env.local-docker` — config template with a generated `ENCRYPTION_KEY` and DB password
- `start.bat` / `start.sh` — launchers (they auto-copy `env.local-docker` → `.env` on first run)

> `.env` is git-ignored, so it is **not** in the repo. The start scripts create it
> from `env.local-docker` automatically. If you run `docker compose` directly
> instead of the start script, first do: `copy env.local-docker .env` (Windows)
> or `cp env.local-docker .env` (macOS/Linux).

## Notes
- Data persists in Docker named volumes (`db-data`, `server-local-data`), not in this
  folder. `docker compose down -v` deletes them.
- Keep the `ENCRYPTION_KEY` in `.env` safe — losing it means existing encrypted data
  can't be recovered.
- This runs everything locally on `localhost`. To expose it on your network or a
  domain, change `SERVER_URL` in `.env` and add a reverse proxy / port mapping.
