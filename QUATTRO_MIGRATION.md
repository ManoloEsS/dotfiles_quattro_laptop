# Omarchy quattro laptop migration

Ported from `omarchy_dotfiles` (Omarchy 3.8 / master) to Omarchy quattro (4.0).

The 3.8 Hyprland configs are preserved for reference under `legacy/hypr-3.8/`.

## What changed

| Area | 3.8 | quattro (this repo) |
|------|-----|---------------------|
| Hyprland config | `.conf` (hyprlang, sourced) | `.lua` (Hyprland ≥ 0.55 deprecated hyprlang) |
| Bar / launcher / notifications / idle / lock | waybar, walker, mako, hypridle, hyprlock, swayosd | Quickshell "Omarchy shell" (`~/.config/omarchy/shell.json`) |
| Volume OSD | swayosd | `omarchy-audio-output-volume` (new OSD) |
| Tmux config | flat `.config/tmux.conf` (master-based) | `.tmux.conf` + `.config/tmux/tmux.conf` (identical, quattro defaults + TPM) |
| Zsh envs | `OMARCHY_PATH=$HOME/.local/share/omarchy` | `OMARCHY_PATH=/usr/share/omarchy`; `ZSHOMARCHY_PATH` → this repo |

## Keybinding decisions (this machine is deliberately simpler)

- **Super+J / Super+K / Super+L** are unbound for HJKL navigation. `Super+L` (workspace-layout) is already covered by `Super+Shift+I` (the custom scrolling↔master toggle), and `Super+J` (togglesplit) only applies to the dwindle layout this machine doesn't use.
- **Super+P** (quattro default: pseudo) is repurposed to scrolling `rollprev`.
- **Super+/`** shows keybindings (`omarchy-menu-keybindings`); **Super+Shift+/`** does monitor scaling up (the old `omarchy-hyprland-monitor-scaling-cycle` was retired).
- Non-conflicting Quattro application bindings stay enabled; only personal key conflicts are unbound.
- Volume keys step 2% via `omarchy-audio-output-volume +2/-2`.

## Files in `hypromarchy/.config/hypr/`

- `hyprland.lua` — current Quattro entry point plus `require("hypr.envs")`; Quattro defaults remain enabled.
- `monitors.lua` — GDK_SCALE 2, auto-detected display at `preferred`/`auto` with 10-bit + auto color management.
- Input settings — inherited from the current Quattro base configuration.
- `looknfeel.lua` — gaps 0, border 1, default `scrolling` layout, master block, `column_width = 0.67`.
- `bindings.lua` — the bind set above.
- `autostart.lua` — empty (nightlight is opt-in per `hyprsunset.conf`).
- `envs.lua` — `HYPRLAND_NO_EXTRA_SYNC=1`.
- `omarchy-hyprland-workspace-layout-scrolling-master-toggle` — scrolling ↔ master toggle, persists to `~/.local/state/omarchy/workspace-layouts/` and applies via `hyprctl eval`.
- `hyprsunset.conf`, `xdph.conf` — unchanged.

## Other packages

- `keyd/` — evdev-level keyboard remap; independent of Hyprland, unchanged. Install with `keyd/install.sh` (symlinks `/etc/keyd/default.conf`).
- `zshomarchy/` — zsh config; `envs` updated for quattro paths. `install-plugins.sh` unchanged.

## Installing on a fresh quattro system

1. Install Omarchy quattro (ISO or `omarchy upgrade to quattro` on 3.8).
2. Clone/copy this repo to `~/dotfiles_quattro_laptop` and run `omarchy_scripts/stow-configs.sh`. It backs up conflicting home files and deploys `hypromarchy`, `tmuxomarchy`, and `zshomarchy` safely.
3. Review and run `keyd/install.sh` separately with root approval if keyd is installed.
4. `omarchy theme set "Tokyo Night"` (or your theme) so themed files regenerate with Quattro templates.
5. Install tmux plugins once: `prefix + I`.

## Validation checklist

- `hyprland --verify-config -c ~/.config/hypr/hyprland.lua` → `config ok`.
- `hyprctl configerrors` → clean; `hyprctl binds` spot-checks HJKL, Super+P, Super+/`; `omarchy menu keybindings --print` confirms descriptions.
- `hyprctl monitors` → display at expected scale.
- `hyprctl activeworkspace` → layout on a master workspace reports `master`.
- Tmux: `prefix + q` reloads without error, `prefix + ?` opens the keybindings popup, TPM installed.

## Known caveats / deferred

- **Idle / lock**: Quattro shell idle and lock behavior is used; the legacy `hypridle.conf` and `hyprlock.conf` are intentionally not migrated.
- **Keyd**: `/etc/keyd/default.conf` is system-level and is intentionally outside the home-directory Stow deployment.
- **Tmux**: `tmux-sensible` may override `default-terminal` — verify the status bar after TPM install.
