-- Personal keybindings: Omarchy quattro defaults with custom overrides.
-- Loaded after Omarchy's default bindings, so unbinds here win.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- =====================================================
-- UNBINDS: keys we're remapping from Omarchy quattro defaults
-- =====================================================

-- Navigation overrides (HJKL focus)
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")

-- Personal scrolling/master bindings reuse Quattro application shortcuts.
hl.unbind("SUPER + SHIFT + M")
hl.unbind("SUPER + SHIFT + N")
hl.unbind("SUPER + SHIFT + SLASH")
hl.unbind("SUPER + SHIFT + Y")
hl.unbind("SUPER + SHIFT + comma")
hl.unbind("SUPER + SHIFT + P")

-- Personal keybindings replace Quattro's monitor scaling shortcut.
hl.unbind("SUPER + SLASH")

-- SUPER+P pseudo → repurposed to scrolling rollprev
hl.unbind("SUPER + P")

-- Volume override: 2% steps instead of default
hl.unbind("XF86AudioRaiseVolume")
hl.unbind("XF86AudioLowerVolume")

-- =====================================================
-- VOLUME: 2% steps
-- =====================================================
o.bind("XF86AudioRaiseVolume", "Volume up 2%", "omarchy-audio-output-volume +2", { locked = true, repeating = true })
o.bind("XF86AudioLowerVolume", "Volume down 2%", "omarchy-audio-output-volume -2", { locked = true, repeating = true })

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
-- Cycle monitor scaling was retired in quattro; scaling now steps up/down.
o.bind("SUPER + SHIFT + slash", "Monitor scaling up", "omarchy-hyprland-monitor-scaling up")
