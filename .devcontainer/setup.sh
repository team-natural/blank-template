#!/bin/bash
set -e
cd "$(dirname "$0")/.."

# claude-config volume is root-owned at first; fix it or login won't persist
sudo chown -R vscode:vscode /home/vscode/.claude

# The Feature installs as root, so the CLI can't self-update; hand it to vscode and pull
# latest here (new models gate on CLI version). Non-fatal: offline rebuilds must still finish.
NPM_ROOT="$(npm root -g)"
if [ -d "$NPM_ROOT/@anthropic-ai" ]; then
  sudo chown -R "$(id -un):$(stat -c %G "$NPM_ROOT")" "$NPM_ROOT/@anthropic-ai"
fi
npm install -g @anthropic-ai/claude-code@latest || echo "WARN: claude-code update failed; keeping the image's version"

# Install project dependencies
npm install

# Install Context Mode (context compression MCP) into the container
npm install -g context-mode
