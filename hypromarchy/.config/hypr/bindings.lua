-- Personal keybindings: Omarchy quattro defaults with custom overrides.
-- Loaded after Omarchy's default bindings, so unbinds here win.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

local function master_only(command)
  return function()
    local workspace = hl.get_active_workspace()
    if workspace and workspace.tiled_layout == "master" then
      hl.dispatch(hl.dsp.layout(command))
    end
  end
end

local function scrolling_only(command)
  return function()
    local workspace = hl.get_active_workspace()
    if workspace and workspace.tiled_layout == "scrolling" then
      hl.dispatch(hl.dsp.layout(command))
    end
  end
end

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

-- SUPER+P pseudo → repurposed to scrolling/master rollprev.
-- Pseudo window is relocated to SUPER+ALT+P below.
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
o.bind("SUPER + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + SHIFT + H", "Swap left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap right", hl.dsp.window.swap({ direction = "r" }))

-- =====================================================
-- COLUMN RESIZE
-- =====================================================
o.bind("SUPER + R", "Expand column left", scrolling_only("colresize +conf"))
o.bind("SUPER + SHIFT + R", "Shrink column left", scrolling_only("colresize -conf"))

-- =====================================================
-- APP LAUNCHER: Music and Yazi (ghostty is this machine's terminal)
-- =====================================================
o.bind("SUPER + CTRL + M", "Music", { omarchy = "spotify" })
o.bind("SUPER + E", "Yazi", o.launch("ghostty -e yazi"))

-- =====================================================
-- MASTER LAYOUT
-- =====================================================
o.bind("SUPER + semicolon", "Swap with master", master_only("swapwithmaster auto"))
o.bind("SUPER + Y", "Cycle next", master_only("cyclenext loop"))
o.bind("SUPER + SHIFT + Y", "Cycle previous", master_only("cycleprev loop"))
o.bind("SUPER + m", "Promote window", scrolling_only("promote"))
o.bind("SUPER + N", "Roll next", master_only("rollnext"))
o.bind("SUPER + P", "Roll previous", master_only("rollprev"))
o.bind("SUPER + ALT + P", "Pseudo window", hl.dsp.window.pseudo())
o.bind("SUPER + a", "Add master", master_only("addmaster"))
o.bind("SUPER + z", "Remove master", master_only("removemaster"))

-- =====================================================
-- SCROLLING LAYOUT
-- =====================================================
o.bind("SUPER + SHIFT + n", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind("SUPER + SHIFT + p", "Move window right", hl.dsp.window.move({ direction = "r" }))
o.bind("SUPER + SHIFT + m", "Promote window", scrolling_only("promote"))
o.bind("SUPER + SHIFT + comma", "Swap column left", scrolling_only("swapcol l"))
o.bind("SUPER + SHIFT + period", "Swap column right", scrolling_only("swapcol r"))

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
