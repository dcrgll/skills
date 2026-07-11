#!/usr/bin/env bash
set -euo pipefail

LABEL="com.skills.autopull"
PLIST="$HOME/Library/LaunchAgents/${LABEL}.plist"

if launchctl print "gui/$(id -u)/$LABEL" >/dev/null 2>&1; then
  launchctl bootout "gui/$(id -u)/$LABEL"
  echo "unloaded $LABEL"
else
  echo "skip unload ($LABEL not loaded)"
fi

if [[ -f "$PLIST" ]]; then
  rm "$PLIST"
  echo "removed $PLIST"
else
  echo "skip remove ($PLIST missing)"
fi

echo "uninstall-autopull complete"
