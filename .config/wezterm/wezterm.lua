-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local action = wezterm.action
local launch_menu = {}

local TITLEBAR_COLOR = '#333333'
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

table.insert(launch_menu, {
  label = 'PowerShell',
  args = { 'powershell.exe', '-NoLogo' },
})
config.launch_menu = launch_menu

config.color_scheme = 'GruvboxDark'

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14

config.window_background_opacity = 0.99
config.macos_window_background_blur = 10

config.enable_tab_bar = true

config.audible_bell = "Disabled"

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_frame = {
  font = wezterm.font { family = 'Hack Nerd Font', weight = 'Bold' },
  font_size = 11.0,
  active_titlebar_bg = TITLEBAR_COLOR,
  inactive_titlebar_bg = TITLEBAR_COLOR,
}

wezterm.on('update-status', function(window, pane)
  local cells = {}

  -- Figure out the hostname of the pane on a best-effort basis
  local hostname = wezterm.hostname()
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri and cwd_uri.host then
    hostname = cwd_uri.host
  end
  table.insert(cells, '  ' .. hostname)

  -- Format date/time in this style: "Wed Mar 3 08:14"
--  local date = wezterm.strftime ' %a %b %-d %H:%M'
--  table.insert(cells, date)
--
--  -- Add an entry for each battery (typically 0 or 1)
--  local batt_icons = {'', '', '', '', ''}
--  for _, b in ipairs(wezterm.battery_info()) do
--    local curr_batt_icon = batt_icons[math.ceil(b.state_of_charge * #batt_icons)]
--    table.insert(cells, string.format('%s %.0f%%', curr_batt_icon, b.state_of_charge * 100))
--  end

  -- Color palette for each cell
  local text_fg = '#c0c0c0'
  local colors = {
    TITLEBAR_COLOR,
    '#3c1361',
    '#52307c',
    '#663a82',
    '#7c5295',
    '#b491c8',
  }

  local elements = {}
  while #cells > 0 and #colors > 1 do
    local text = table.remove(cells, 1)
    local prev_color = table.remove(colors, 1)
    local curr_color = colors[1]

    table.insert(elements, { Background = { Color = prev_color } })
    table.insert(elements, { Foreground = { Color = curr_color } })
    table.insert(elements, { Text = '' })
    table.insert(elements, { Background = { Color = curr_color } })
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
  end
  window:set_right_status(wezterm.format(elements))
end)

--wezterm.on(
--  'format-tab-title',
--  function(tab, tabs, panes, config, hover, max_width)
--    local edge_background = '#0b0022'
--    local background = '#1b1032'
--    local foreground = '#808080'
--
--    if tab.is_active then
--      background = '#2b2042'
--      foreground = '#c0c0c0'
--    elseif hover then
--      background = '#3b3052'
--      foreground = '#909090'
--    end
--
--    local edge_foreground = background
--
--    local title = tab_title(tab)
--
--    -- ensure that the titles fit in the available space,
--    -- and that we have room for the edges.
--    title = wezterm.truncate_right(title, max_width - 2)
--
--    return {
--      { Background = { Color = TITLEBAR_COLOR } },
--      { Foreground = { Color = edge_foreground } },
--      { Text = SOLID_LEFT_ARROW },
--      { Background = { Color = background } },
--      { Foreground = { Color = foreground } },
--      { Text = title },
--      { Background = { Color = TITLEBAR_COLOR } },
--      { Foreground = { Color = edge_foreground } },
--      { Text = SOLID_RIGHT_ARROW },
--    }
--  end
--)

-- and finally, return the configuration to wezterm
return config
