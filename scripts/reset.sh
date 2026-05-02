#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$(dirname "$SCRIPT_DIR")"

echo "UWAGA: To usunie wszystkie dane (modele, historię czatów, użytkowników)!"
read -r -p "Czy na pewno? [tak/N] " confirm

if [ "$confirm" != "tak" ]; then
  echo "Anulowano."
  exit 0
fi

docker compose --profile tools down -v
echo "✓ Usunięto wszystkie dane i wolumeny."
