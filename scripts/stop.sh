#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

docker compose down
echo "✓ Open WebUI zatrzymane."
echo ""
echo "Zatrzymywanie Ollam'y..."
pkill ollama
echo "✓ Ollama zatrzymana."