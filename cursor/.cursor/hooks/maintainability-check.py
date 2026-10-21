#!/usr/bin/env python3
import json
import re
import sys
from pathlib import Path

STATE_DIR = Path.home() / ".cursor" / "hook-state" / "maintainability"

FOLLOWUP = (
    "Before this turn is done, read the Correctness and Maintainability sections "
    "of ~/.cursor/skills/pr-review/SKILL.md and apply them to the code you added or "
    "edited. Also check those edits against the code-clarity rule. Fix any miss in "
    "that code. Do not write a review. If that code already meets the bar, do not "
    "edit anything. End your reply with this line and nothing after it:\n"
    "✅ Checks Complete"
)


def load_payload() -> dict:
    try:
        payload = json.load(sys.stdin)
    except json.JSONDecodeError:
        return {}
    if not isinstance(payload, dict):
        return {}
    return payload


def state_path(conversation_id: str) -> Path:
    safe = re.sub(r"[^A-Za-z0-9._-]", "_", conversation_id)[:200]
    return STATE_DIR / f"{safe}.json"


def read_state(path: Path) -> dict:
    try:
        data = json.loads(path.read_text())
    except (OSError, json.JSONDecodeError):
        return {}
    if not isinstance(data, dict):
        return {}
    return data


def write_state(path: Path, data: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(data))
    temporary.replace(path)


def main() -> None:
    payload = load_payload()
    event = payload.get("hook_event_name")
    conversation_id = payload.get("conversation_id")
    generation_id = payload.get("generation_id")
    if not isinstance(conversation_id, str) or conversation_id == "":
        json.dump({}, sys.stdout)
        return
    if not isinstance(generation_id, str):
        generation_id = ""

    path = state_path(conversation_id)
    state = read_state(path)

    if event == "afterFileEdit":
        if generation_id != "":
            state["edited_generation"] = generation_id
            write_state(path, state)
        json.dump({}, sys.stdout)
        return

    status = payload.get("status")
    if status != "completed":
        state.pop("check_followup_sent", None)
        write_state(path, state)
        json.dump({}, sys.stdout)
        return

    # The next stop is the check reply. Asking again would repeat the check
    # after that reply edits a file.
    if state.get("check_followup_sent") is True:
        state.pop("check_followup_sent", None)
        state.pop("edited_generation", None)
        write_state(path, state)
        json.dump({}, sys.stdout)
        return

    if state.get("edited_generation") != generation_id or generation_id == "":
        json.dump({}, sys.stdout)
        return

    state["check_followup_sent"] = True
    state.pop("edited_generation", None)
    write_state(path, state)
    json.dump({"followup_message": FOLLOWUP}, sys.stdout)


if __name__ == "__main__":
    main()
