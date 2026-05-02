"""
Przykładowy pipeline – filtr wiadomości.
Umieść swoje pipeline'y w tym folderze.
Dokumentacja: https://github.com/open-webui/pipelines
"""

from typing import List, Optional
from pydantic import BaseModel


class Pipeline:
    class Valves(BaseModel):
        # Własne ustawienia pipeline'u (widoczne w Open WebUI)
        system_prompt_prefix: str = ""

    def __init__(self):
        self.name = "Przykładowy filtr"
        self.valves = self.Valves()

    async def on_startup(self):
        pass

    async def on_shutdown(self):
        pass

    async def inlet(self, body: dict, user: Optional[dict] = None) -> dict:
        """Przetwarzanie żądania PRZED wysłaniem do modelu."""
        messages: List[dict] = body.get("messages", [])

        if self.valves.system_prompt_prefix and messages:
            # Dodaj prefix do pierwszej wiadomości systemowej
            if messages[0]["role"] == "system":
                messages[0]["content"] = (
                    self.valves.system_prompt_prefix + "\n\n" + messages[0]["content"]
                )

        return body

    async def outlet(self, body: dict, user: Optional[dict] = None) -> dict:
        """Przetwarzanie odpowiedzi PO otrzymaniu od modelu."""
        return body
