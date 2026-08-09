#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.local/state/dotfiles-omarchy-laptop/backups/$(date +%Y%m%d-%H%M%S)"

if ! command -v stow >/dev/null 2>&1; then
    echo "Error: GNU Stow is not installed. Install it with the system package manager first."
    exit 1
fi

backup_conflicts() {
    local pkg="$1"
    local target_root="$2"
    local source rel target target_dir

    while IFS= read -r -d '' source; do
        rel="${source#"$DOTFILES_DIR/$pkg/"}"
        target="$target_root/$rel"

        if [[ ! -f "$target" && ! -L "$target" ]]; then
            continue
        fi

        if [[ -L "$target" && "$(readlink -f "$target")" == "$source" ]]; then
            continue
        fi

        target_dir="$BACKUP_DIR/$rel"
        mkdir -p "$(dirname "$target_dir")"
        mv "$target" "$target_dir"
        echo "Backed up $target to $target_dir"
    done < <(find "$DOTFILES_DIR/$pkg" \( -type f -o -type l \) -print0)
}

mkdir -p "$HOME/.config/zsh"
echo "Backups: $BACKUP_DIR"

for pkg in hypromarchy tmuxomarchy; do
    backup_conflicts "$pkg" "$HOME"
    stow -v --no-folding -t "$HOME" -d "$DOTFILES_DIR" "$pkg"
done

backup_conflicts zshomarchy "$HOME/.config/zsh"
stow -v --no-folding -t "$HOME/.config/zsh" -d "$DOTFILES_DIR" zshomarchy

echo "Home configuration deployment complete."
echo "keyd remains separate: review and run keyd/install.sh with root approval."
