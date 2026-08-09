# Dotfiles Inventory

This repository contains personal configuration for an Omarchy Quattro laptop.
Home-directory targets use GNU Stow. System-level files are handled separately.

## Packages

| Package | Target | Status | Conflict or deployment note |
| --- | --- | --- | --- |
| `hypromarchy` | `~/.config/hypr/` | Quattro package | Personal monitors, bindings, appearance, environment, startup, and `hyprsunset` overrides. |
| `tmuxomarchy` | `~/.tmux.conf`, `~/.config/tmux/` | Home package | May replace existing tmux configuration; back it up first. |
| `zshomarchy` | `~/.config/zsh/` | Custom target | Source files are intentionally bare and must not be Stowed directly into `$HOME`. |
| `keyd` | `/etc/keyd/default.conf` | System package | Do not Stow to `$HOME`; install with the dedicated script and root approval. |
| `legacy/hypr-3.8` | None | Reference only | Never deploy on Quattro. |

## Omarchy Conflicts

- Never edit `/usr/share/omarchy/`; it contains the managed Quattro defaults.
- `hypromarchy/.config/hypr/hyprland.lua` loads current Omarchy defaults first, then personal modules.
- Quattro input, shell, idle, lock, notification, and OSD behavior remain managed by Omarchy.
- The laptop overrides the monitor profile, personal keybindings, appearance, AMD environment fix, and optional `hyprsunset` profile.
- Existing `~/.config/hypr/hyprland.conf` must be backed up before activating the Lua entrypoint.
- Existing `~/.config/zsh` and tmux files may contain user changes and require backups before Stow.
- `keyd/.config/keyd/default.conf` conflicts with `/etc/keyd/default.conf` and requires explicit root-approved installation.

## Excluded State

- `legacy/hypr-3.8/` is not deployable.
- No Hyprland `hypridle.conf` or `hyprlock.conf` is migrated; Quattro shell services own idle and lock behavior.
