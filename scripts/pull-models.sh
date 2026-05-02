#!/usr/bin/env bash
set -e

# Modele do pobrania (odkomentuj co chcesz)
MODELS=(
  "nomic-embed-text"    # 270 MB  – WYMAGANE: embeddingi dla RAG
  "qwen2.5-coder:7b"   # 4.7 GB  – najlepszy do kodowania (zalecany)
  # "llama3.2"          # 2.0 GB  – szybki, dobry do rozmowy
  # "llama3.2:1b"       # 1.3 GB  – bardzo szybki, lekki
  # "mistral"           # 4.1 GB  – dobry ogólny
  # "deepseek-coder-v2:16b"  # 9 GB – najlepszy do kodu (wymaga >16GB RAM)
)

if ! command -v ollama &>/dev/null; then
  echo "[BŁĄD] Ollama nie jest zainstalowana. Użyj: brew install ollama"
  exit 1
fi

if ! curl -sf http://localhost:11434/api/version &>/dev/null; then
  echo "[INFO] Uruchamiam Ollama..."
  ollama serve > /tmp/ollama.log 2>&1 &
  sleep 3
fi

echo "[INFO] Pobieranie modeli..."
for model in "${MODELS[@]}"; do
  echo ""
  echo "→ $model"
  ollama pull "$model"
done

echo ""
echo "✓ Gotowe! Zainstalowane modele:"
ollama list
