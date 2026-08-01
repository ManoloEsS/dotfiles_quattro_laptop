-- Change the default Omarchy look'n'feel.

hl.config({
  general = {
    -- No gaps between windows or borders.
    gaps_in = 0,
    gaps_out = 0,
    border_size = 1,

    -- niri-like side-scrolling layout as the default.
    layout = "scrolling",
  },

  master = {
    allow_small_split = false,
    special_scale_factor = 1.0,
    mfact = 0.7,

    new_status = "slave",
    new_on_top = false,
    new_on_active = "none",

    orientation = "right",
    slave_count_for_center_master = 2,
    center_master_fallback = "left",

    smart_resizing = true,
    drop_at_cursor = true,
    always_keep_position = false,
  },

  scrolling = {
    column_width = 0.67,
    explicit_column_widths = { 0.33, 0.5, 0.67, 1.0 },
  },
})
