#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KEYD_PATH="$REPO_ROOT/keyd"

if ! command -v keyd &> /dev/null; then
  echo "Error: keyd is not installed. Install it with the system package manager first."
  exit 1
fi

echo "Linking keyd config..."
sudo mkdir -p /etc/keyd
sudo ln -sfn "$KEYD_PATH/.config/keyd/default.conf" /etc/keyd/default.conf

echo "Restarting keyd service..."
sudo systemctl restart keyd

echo "Done! keyd is installed and config is linked."
