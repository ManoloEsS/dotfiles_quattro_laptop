-- Personal keybindings loaded after Omarchy defaults.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- =====================================================
-- CONFLICTS WITH OMARCHY DEFAULTS
-- =====================================================

-- J toggles split, K shows keybindings, and L toggles the workspace layout
-- in the defaults. The project uses them for HJKL focus navigation.
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")

-- The default dismisses all notifications here; the project uses it to swap
-- the active scrolling column left.
hl.unbind("SUPER + SHIFT + COMMA")

-- The default uses Super+Slash for monitor scaling; the project uses it to
-- show keybindings instead.
hl.unbind("SUPER + code:61")
hl.unbind("SUPER + ALT + code:61")

-- P toggles pseudo mode by default; the project uses it for master layout
-- navigation.
hl.unbind("SUPER + P")

-- Preserve the project's precise 2% behavior instead of the default volume
-- step.
hl.unbind("XF86AudioRaiseVolume")
hl.unbind("XF86AudioLowerVolume")

-- =====================================================
-- VOLUME: 2% steps
-- =====================================================
o.bind("XF86AudioRaiseVolume", "Volume up 2%", "omarchy-swayosd-client --output-volume +2", { locked = true, repeating = true })
o.bind("XF86AudioLowerVolume", "Volume down 2%", "omarchy-swayosd-client --output-volume -2", { locked = true, repeating = true })

-- =====================================================
-- HJKL NAVIGATION (layout-aware)
-- =====================================================
o.bind("SUPER + H", "Focus left", hl.dsp.layout("focus l"))
o.bind("SUPER + J", "Focus down", hl.dsp.layout("focus d"))
o.bind("SUPER + K", "Focus up", hl.dsp.layout("focus u"))
o.bind("SUPER + L", "Focus right", hl.dsp.layout("focus r"))
o.bind("SUPER + SHIFT + H", "Swap left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap right", hl.dsp.window.swap({ direction = "r" }))

-- =====================================================
-- COLUMN RESIZE
-- =====================================================
o.bind("SUPER + R", "Expand window left", hl.dsp.layout("colresize +conf"))
o.bind("SUPER + SHIFT + R", "Shrink window left", hl.dsp.layout("colresize -conf"))

-- =====================================================
-- APP LAUNCHER: Yazi (ghostty is this machine's terminal)
-- =====================================================
o.bind("SUPER + E", "Yazi", o.launch("ghostty -e yazi"))

-- =====================================================
-- MASTER LAYOUT
-- =====================================================
o.bind("SUPER + semicolon", "Swap with master", hl.dsp.layout("swapwithmaster auto"))
o.bind("SUPER + Y", "Cycle next", hl.dsp.layout("cyclenext loop"))
o.bind("SUPER + SHIFT + Y", "Cycle previous", hl.dsp.layout("cycleprev loop"))
o.bind("SUPER + m", "Promote window", hl.dsp.layout("promote"))
o.bind("SUPER + N", "Roll next", hl.dsp.layout("rollnext"))
o.bind("SUPER + P", "Roll previous", hl.dsp.layout("rollprev"))
o.bind("SUPER + a", "Add master", hl.dsp.layout("addmaster"))
o.bind("SUPER + z", "Remove master", hl.dsp.layout("removemaster"))

-- Preserve Omarchy's pseudo-window action after using Super+P for rollprev.
o.bind("SUPER + ALT + P", "Pseudo window", hl.dsp.window.pseudo())

-- =====================================================
-- SCROLLING LAYOUT
-- =====================================================
o.bind("SUPER + SHIFT + n", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind("SUPER + SHIFT + p", "Move window right", hl.dsp.window.move({ direction = "r" }))
o.bind("SUPER + SHIFT + m", "Promote window", hl.dsp.layout("promote"))
o.bind("SUPER + SHIFT + comma", "Swap column left", hl.dsp.layout("swapcol l"))
o.bind("SUPER + SHIFT + period", "Swap column right", hl.dsp.layout("swapcol r"))

-- =====================================================
-- LAYOUT TOGGLE (scrolling <-> master, custom script)
-- =====================================================
o.bind("SUPER + SHIFT + I", "Toggle scrolling/master layout", "$HOME/.config/hypr/omarchy-hyprland-workspace-layout-scrolling-master-toggle")

-- =====================================================
-- KEYBINDINGS / MONITOR SCALING
-- =====================================================
o.bind("SUPER + slash", "Show key bindings", "omarchy-menu-keybindings")
-- This Omarchy version provides cycling rather than a directional command.
o.bind("SUPER + SHIFT + slash", "Cycle monitor scaling", "omarchy-hyprland-monitor-scaling-cycle")
o.bind("SUPER + SHIFT + CTRL + ALT + slash", "Cycle monitor scaling backwards", "omarchy-hyprland-monitor-scaling-cycle --reverse")
o.bind("SUPER + SHIFT + ALT + period", "Dismiss all notifications", "makoctl dismiss --all")

-- The installed default loader does not include the app launcher block.
-- Keep the project's essential terminal, browser, and file-manager binds.
o.bind("SUPER + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + SHIFT + RETURN", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + SHIFT + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + SHIFT + N", "Editor", { omarchy = "editor" })
