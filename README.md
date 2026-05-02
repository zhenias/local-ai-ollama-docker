# Ollama + Open WebUI

Ollama działa **natywnie** (dostęp do GPU Apple Silicon).
Open WebUI działa w **Dockerze** i łączy się z lokalną Ollama.

## Wymagania

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Ollama](https://ollama.com/) — `brew install ollama`
- ~5 GB wolnego miejsca (modele)

## Uruchomienie

```bash
# 1. Pobierz modele (raz, przy pierwszym użyciu)
./scripts/pull-models.sh

# 2. Uruchom
./scripts/start.sh

# 3. Otwórz
open http://localhost:3000
```

Przy pierwszym uruchomieniu utwórz konto administratora w przeglądarce.

## Skrypty

| Polecenie | Co robi |
|-----------|---------|
| `./scripts/start.sh` | Uruchamia Ollama (jeśli nie działa) + Open WebUI |
| `./scripts/stop.sh` | Zatrzymuje Open WebUI (Ollama działa dalej) |
| `./scripts/pull-models.sh` | Pobiera modele LLM |

## Modele (pull-models.sh)

Domyślnie pobierane:

| Model | Rozmiar | Do czego |
|-------|---------|----------|
| `nomic-embed-text` | 270 MB | Embeddingi RAG (wymagane) |
| `qwen2.5-coder:7b` | 4.7 GB | Kodowanie — najlepszy wybór |

Edytuj `scripts/pull-models.sh` żeby dodać/usunąć modele.

## Pobieranie modeli przez stronę

W Open WebUI: **Admin Panel → Models → ikona pobierania** → wpisz nazwę modelu.

## Porty

| Serwis | Adres |
|--------|-------|
| Open WebUI | http://localhost:3000 |
| Ollama API | http://localhost:11434 |

## Konfiguracja (.env)

```env
WEBUI_PORT=3000
WEBUI_SECRET_KEY=zmien-na-losowy-klucz
WEBUI_NAME=Asystent AI
ENABLE_SIGNUP=true
```

## Po restarcie komputera

```bash
./scripts/start.sh
```

Skrypt automatycznie uruchomi Ollama jeśli nie działa.
