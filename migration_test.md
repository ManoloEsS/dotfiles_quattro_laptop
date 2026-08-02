# Hyprland Defaults Migration Test Notes

This branch consolidates the laptop configuration on top of the installed
Omarchy defaults instead of copying the default configuration into the repo.

## Baseline

- Omarchy: `4.0.0.alpha`
- Hyprland: `0.56.1`
- Default Lua tree: `~/.local/share/omarchy/default/hypr/`
- User target: `~/.config/hypr/`
- Branch: `hypr-defaults-migration`

The installed defaults are loaded first by `hyprland.lua`. User modules are
loaded afterward so Omarchy updates continue to provide new functionality.
The old `bootstrap.lua` and `omarchy_preinstalled_bindings` assumptions are not
used because they are not part of the installed default tree.

## Intentional Overrides

- Keep the project monitor settings unchanged for now.
- Use scrolling as the default layout with the project master-layout settings.
- Keep zero gaps, a 1px border, 600ms key repeat delay, numlock, and touchpad
  scrolling settings from the project.
- Keep `HYPRLAND_NO_EXTRA_SYNC=1`.
- Keep HJKL focus navigation and the project master/scrolling bindings.
- Keep the project scrolling/master workspace toggle and persist its rules in
  `~/.local/state/omarchy/workspace-layouts/`.

## Binding Conflict Policy

Only bindings that conflict with project behavior are unbound:

- `Super+J/K/L` for HJKL navigation
- `Super+Shift+Comma` for scrolling-column movement
- `Super+Slash` for the keybindings menu
- `Super+P` for master-layout roll previous
- Volume keys for 2% volume changes

Essential terminal, browser, editor, and file-manager bindings are defined
explicitly because this Omarchy default loader does not include that app block.
Other Omarchy defaults remain enabled.

## Command Compatibility

The installed commands must be checked after Omarchy upgrades:

- Volume: `omarchy-swayosd-client --output-volume +2/-2`
- Scaling: `omarchy-hyprland-monitor-scaling-cycle`
- Keybindings menu: `omarchy-menu-keybindings`
- Layout APIs: `hyprctl eval` with `hl.workspace_rule`

Do not restore commands from older migration notes until they exist on the
target system. In particular, `omarchy-audio-output-volume` and directional
monitor-scaling commands were not available in this baseline.

## Validation Checklist

Run after changing Omarchy or Hyprland:

```bash
hyprctl configerrors
hyprctl monitors
hyprctl activeworkspace
hyprctl binds -j
luac -p ~/.config/hypr/*.lua
```

Spot-check that:

- The active layout is scrolling.
- `Super+H/J/K/L` focuses in four directions.
- `Super+Shift+I` toggles scrolling and master layouts.
- The toggle survives `hyprctl reload`.
- Volume keys change volume by 2%.
- `Super+Slash` opens the keybindings menu.
- The installed monitor-scaling command remains available.

## Future Omarchy Alpha Updates

After an Omarchy update:

1. Re-read `~/.local/share/omarchy/default/hypr/omarchy.lua`, bindings, input,
   looknfeel, and helper files.
2. Compare default bindings against the explicit `hl.unbind` calls.
3. Re-check every command with `command -v` and inspect changed scripts.
4. Check the generated Lua stubs in `/usr/share/hypr/stubs/` for renamed
   fields or APIs.
5. Run the validation checklist before changing user overrides.
6. Remove an override when the default now provides the same behavior.
7. Keep this file updated with the new Omarchy and Hyprland versions.
