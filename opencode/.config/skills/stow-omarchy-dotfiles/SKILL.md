---
name: stow-omarchy-dotfiles
description: Safely inventory and deploy this repository's personal Omarchy Quattro laptop configuration with GNU Stow, while preserving Omarchy defaults and handling keyd separately.
---

# Stow Omarchy Laptop Dotfiles

Deploy this repository on a fresh Omarchy Quattro laptop. Treat the repository
as personal overrides on top of the installed Omarchy base.

## Safety Rules

- Never edit `/usr/share/omarchy/`.
- Never use `rm -rf` on configuration directories.
- Inventory and back up conflicts before Stow changes anything.
- Never deploy `legacy/hypr-3.8/`.
- Do not Stow `keyd` into `$HOME`; its target is `/etc/keyd/default.conf`.
- Ask before installing packages, changing `/etc`, using `sudo`, resetting Omarchy config, or restarting the desktop.
- Preserve Quattro shell, idle, lock, notification, and OSD services.

## Preflight

Resolve the repository root from this skill's location. Read
`DOTFILES_INVENTORY.md` before deployment.

Check:

```bash
test -f /etc/os-release
command -v omarchy
command -v stow
omarchy version
hyprctl version
```

If Stow is missing, report it and ask before installing it. Do not silently
install packages.

Classify each target as absent, already linked to this repository, an existing
regular file, a symlink elsewhere, or a directory containing unrelated files.
Back up regular files and foreign symlinks. Never overwrite them silently.

## Deployment

Use the repository script after preflight:

```bash
omarchy_scripts/stow-configs.sh
```

The script deploys:

- `hypromarchy` to `~/.config/hypr/`
- `tmuxomarchy` to `$HOME`
- `zshomarchy` to `~/.config/zsh/`

It does not deploy `keyd`. For keyd, first inspect `keyd/install.sh`, confirm
the repository path, and ask for root approval before linking
`/etc/keyd/default.conf` or restarting the service.

## Hyprland Activation

The Quattro Lua entrypoint must be the active configuration:

1. Back up an active `~/.config/hypr/hyprland.conf`.
2. Ensure the repository `hyprland.lua` and modules are linked.
3. Verify before reload:

```bash
HOME="$HOME" OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}" \
  hyprland --verify-config -c "$HOME/.config/hypr/hyprland.lua"
```

4. Reload and validate:

```bash
hyprctl reload
hyprctl configerrors
hyprctl monitors
hyprctl binds
```

If verification fails, stop and report the exact error. Do not run
`omarchy refresh hyprland` automatically.

## Laptop-Specific Rules

- Use Quattro input defaults; do not restore the old `repeat_delay = 600` override.
- Preserve the laptop's custom monitor auto-detection and 2x scale.
- Keep only targeted keybinding unbinds for personal conflicts; non-conflicting Quattro app bindings remain enabled.
- Keep nightlight opt-in unless the user requests automatic startup.
- Keep the custom scrolling/master toggle script.
- Treat the `keyd` remap as a system-level deployment requiring separate approval.

## Completion Report

Report the Omarchy and Hyprland versions, deployed packages, skipped packages,
backup directory, conflicts, Hyprland validation result, and any remaining
manual `/etc` steps.
