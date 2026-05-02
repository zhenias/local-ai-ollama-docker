#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

# ── .env ──────────────────────────────────────────────────────────────────────
if [ ! -f .env ]; then
  cp .env.example .env
  echo "[INFO] Stworzono .env — zmień WEBUI_SECRET_KEY przed produkcją."
fi
WEBUI_PORT=$(grep -E '^WEBUI_PORT=' .env 2>/dev/null | cut -d= -f2 || echo 3000)

# ── Ollama (natywna) ───────────────────────────────────────────────────────────
if ! command -v ollama &>/dev/null; then
  echo "[BŁĄD] Ollama nie jest zainstalowana."
  echo "       Zainstaluj: brew install ollama"
  exit 1
fi

if ! curl -sf http://localhost:11434/api/version &>/dev/null; then
  echo "[INFO] Uruchamiam Ollama..."
  ollama serve > /tmp/ollama.log 2>&1 &
  for i in $(seq 1 20); do
    curl -sf http://localhost:11434/api/version &>/dev/null && break
    sleep 1
  done
fi

# ── Sprawdź czy są modele ──────────────────────────────────────────────────────
MODEL_COUNT=$(ollama list 2>/dev/null | tail -n +2 | grep -c . || echo 0)
if [ "$MODEL_COUNT" -eq 0 ]; then
  echo "[UWAGA] Brak modeli. Uruchom: ./scripts/pull-models.sh"
fi

# ── Open WebUI (Docker) ────────────────────────────────────────────────────────
echo "[INFO] Uruchamiam Open WebUI..."
docker compose up -d

echo ""
echo "Czekam na Open WebUI..."
for i in $(seq 1 36); do
  if curl -sf "http://localhost:${WEBUI_PORT}" -o /dev/null 2>/dev/null; then
    echo ""
    echo "✓ Gotowe! → http://localhost:${WEBUI_PORT}"
    exit 0
  fi
  printf "."
  sleep 5
done

echo ""
echo "Wciąż się ładuje → http://localhost:${WEBUI_PORT}"
echo "Logi: docker compose logs -f"
