#!/bin/bash
set -e

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom/plugins

mkdir -p "$ZSH_CUSTOM"

echo "Installing zsh plugins..."

if [[ ! -d "$ZSH_CUSTOM/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed, skipping..."
fi

if [[ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed, skipping..."
fi

if [[ ! -d "$ZSH_CUSTOM/zsh-completions" ]]; then
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/zsh-completions"
else
  echo "zsh-completions already installed, skipping..."
fi

if [[ ! -d "$ZSH_CUSTOM/fzf-tab" ]]; then
  git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/fzf-tab"
else
  echo "fzf-tab already installed, skipping..."
fi

echo "Done! Plugins installed to $ZSH_CUSTOM"
