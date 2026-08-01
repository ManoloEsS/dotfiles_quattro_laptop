#!/bin/bash
set -e

KEYD_PATH=$HOME/omarchy_dotfiles/keyd

if ! command -v keyd &> /dev/null; then
  echo "Installing keyd..."
  git clone https://github.com/rvai/keyd.git
  cd /tmp/keyd
  make
  sudo make install
  cd -
  rm -rf /tmp/keyd
  echo "keyd installed."
fi

echo "Linking keyd config..."
sudo mkdir -p /etc/keyd
sudo ln -sf $KEYD_PATH/.config/keyd/default.conf /etc/keyd/default.conf

echo "Restarting keyd service..."
sudo systemctl restart keyd

echo "Done! keyd is installed and config is linked."
