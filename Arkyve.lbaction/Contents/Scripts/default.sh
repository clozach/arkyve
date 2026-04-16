#!/bin/bash

# Log for troubleshooting (overwritten each run)
exec 1>/tmp/arkyve_action.log 2>&1

echo "LaunchBar Action started at $(date)"
echo "Running as user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Arguments received: $@"
echo "PATH: $PATH"

ARKYVE_PATH="/Users/c/Documents/2-Ongoing/arkyve/arkyve"

# Locate fish. Prefer Apple Silicon Homebrew; fall back to Intel; then PATH.
FISH_PATH=""
for candidate in /opt/homebrew/bin/fish /usr/local/bin/fish "$(command -v fish)"; do
    if [ -n "$candidate" ] && [ -x "$candidate" ]; then
        FISH_PATH="$candidate"
        break
    fi
done

echo "Using fish: $FISH_PATH"

notify() {
    local title="$1"
    local subtitle="$2"
    local message="$3"
    local sound="$4"
    osascript -e "display notification \"$message\" with title \"$title\" subtitle \"$subtitle\" sound name \"$sound\"" >/dev/null 2>&1 || true
}

if [ ! -x "$ARKYVE_PATH" ]; then
    notify "Arkyve" "Error" "arkyve script not found at $ARKYVE_PATH" "Basso"
    exit 0
fi

if [ -z "$FISH_PATH" ]; then
    notify "Arkyve" "Error" "fish shell not found" "Basso"
    exit 0
fi

# No arguments: most likely a Tahoe sandbox/permission issue preventing
# LaunchBar from handing the file URL across. Exit 0 so LaunchBar doesn't
# show its generic error dialog; notify with something actionable.
if [ $# -eq 0 ]; then
    notify "Arkyve" "No files received" "Grant LaunchBar Full Disk Access, or pair a file first (Tab -> Arkyve)." "Basso"
    exit 0
fi

echo "Calling arkyve with arguments: $@"
# --no-config skips user fish config (avoids noise from venv auto-activate, etc.)
"$FISH_PATH" --no-config "$ARKYVE_PATH" "$@"
EXIT_CODE=$?

echo "arkyve exited with code: $EXIT_CODE"
echo "LaunchBar Action completed at $(date)"

# Always exit 0 so LaunchBar never shows the generic error dialog; the
# arkyve script already communicates success/failure via notifications.
exit 0
