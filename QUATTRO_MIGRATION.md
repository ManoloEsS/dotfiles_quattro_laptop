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

- **Super+J / Super+K / Super+L** are unbound for HJKL navigation. `Super+L` (workspace-layout) is already covered by `Super+Shift+I` (the custom scrolling↔master toggle), and `Super+J` (togglesplit) only applies to the dwindle layout this machine doesn't use. Both were already dropped in 3.8 — no functionality was added back.
- **Super+P** (Omarchy default: pseudo) is repurposed to scrolling `rollprev`.
- **Super+/`** shows keybindings (`omarchy-menu-keybindings`), replacing the Omarchy monitor-scaling binding. **Super+Shift+/`** cycles monitor scaling using the command available on this system.
- Essential app binds (Super+Shift+F/B/RETURN) stay. App/webapp unbinds are not needed because the installed default loader does not load that block.
- Volume keys step 2% via the installed `omarchy-swayosd-client --output-volume +2/-2` command.

## Files in `hypromarchy/.config/hypr/`

- `hyprland.lua` — entry point (installed stock defaults plus personal modules, including `require("hypr.envs")`).
- `monitors.lua` — GDK_SCALE 2, auto-detected display at `preferred`/`auto` with 10-bit + auto color management.
- `input.lua` — us / `compose:caps` / numlock / repeat 40-600 / touchpad clickfinger + 0.4; `scroll_touchpad` rules.
- `looknfeel.lua` — gaps 0, border 1, default `scrolling` layout, master block, `column_width = 0.67`.
- `bindings.lua` — the bind set above.
- `autostart.lua` — empty (nightlight is opt-in per `hyprsunset.conf`).
- `envs.lua` — `HYPRLAND_NO_EXTRA_SYNC=1`.
- `workspace-layouts.lua` — restores persisted workspace layout rules after reload.
- `omarchy-hyprland-workspace-layout-scrolling-master-toggle` — scrolling ↔ master toggle, persists to `~/.local/state/omarchy/workspace-layouts/` and applies via `hyprctl eval`.
- `hyprsunset.conf`, `xdph.conf` — unchanged.

## Other packages

- `keyd/` — evdev-level keyboard remap; independent of Hyprland, unchanged. Install with `keyd/install.sh` (symlinks `/etc/keyd/default.conf`).
- `zshomarchy/` — zsh config; `envs` updated for quattro paths. `install-plugins.sh` unchanged.

## Installing on a fresh quattro system

1. Install Omarchy quattro (ISO or `omarchy upgrade to quattro` on 3.8).
2. Clone/copy this repo to `~/dotfiles_quattro_laptop` (the zsh `envs` points here) and symlink/stow `hypromarchy` → `~/.config/hypr`, `tmuxomarchy/.tmux.conf` → `~/.tmux.conf`, `keyd` per its install script.
3. Ensure the toggle script resolves: `ln -sf ~/.config/hypr/omarchy-hyprland-workspace-layout-scrolling-master-toggle ~/.local/bin/` (or adjust the path in `bindings.lua`).
4. `omarchy theme set "Tokyo Night"` (or your theme) so themed files regenerate with quattro templates.
5. Install tmux plugins once: `prefix + I`.

## Validation checklist

- `hyprctl configerrors` → clean; `hyprctl binds | head` spot-checks HJKL, Super+P, Super+/`; `omarchy menu keybindings --print` confirms descriptions.
- `hyprctl monitors` → display at expected scale.
- `hyprctl activeworkspace` → layout on a master workspace reports `master`.
- Tmux: `prefix + q` reloads without error, `prefix + ?` opens the keybindings popup, TPM installed.

## Known caveats / deferred

- **Idle / lock**: the custom `hypridle.conf` (screensaver at 2.5 min, lock at 5 min) and `hyprlock.conf` are retired in quattro; the shell (`shell.json`) exposes only `screensaver`/`lock` timings. `omarchy-system-wake` no longer exists — the sleep/wake path is now the shell's `omarchy-system-sleep-lock` service. Revisit via a `post-boot` hook or shell idle callbacks.
- **Monitor Lua settings**: the project retains the existing retina/10-bit monitor settings for now; monitor migration is intentionally deferred.
- **Tmux**: `tmux-sensible` may override `default-terminal` — verify the status bar after TPM install.
