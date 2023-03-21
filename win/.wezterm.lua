-- Inspired by https://github.com/codito/configs-win/blob/master/.wezterm.lua
local wezterm = require("wezterm")

local act = wezterm.action

local config = {
  fot = wezterm.font 'Hack Nerd Font Mono',

  tab_bar_at_bottom = true,
  default_prog = { 'powershell.exe' },
  launch_menu = {},

  leader = { key="b", mods="CTRL" },
  use_dead_keys = false,
  keys = {
    -- New/close pane
    { key = "c", mods = "LEADER", action=act{SpawnTab="CurrentPaneDomain"}},
    { key = "n", mods = "LEADER", action=act.ShowLauncher},
    { key = "x", mods = "LEADER", action=act{CloseCurrentPane={confirm=false}}},
    { key = "d", mods = "LEADER", action=act{CloseCurrentPane={confirm=true}}},

    -- Split panes
    { key = "-", mods = "LEADER", action=act{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "\\",mods = "LEADER", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},

    -- Pane navigation
    { key = "h", mods = "LEADER", action=act{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER", action=act{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER", action=act{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER", action=act{ActivatePaneDirection="Right"}},
    { key = "h", mods = "ALT", action=act{ActivatePaneDirection="Left"}},
    { key = "j", mods = "ALT", action=act{ActivatePaneDirection="Down"}},
    { key = "k", mods = "ALT", action=act{ActivatePaneDirection="Up"}},
    { key = "l", mods = "ALT", action=act{ActivatePaneDirection="Right"}},
    { key = "LeftArrow", mods = "CTRL", action=act{ActivatePaneDirection="Left"}},
    { key = "DownArrow", mods = "CTRL", action=act{ActivatePaneDirection="Down"}},
    { key = "UpArrow", mods = "CTRL",   action=act{ActivatePaneDirection="Up"}},
    { key = "RightArrow", mods = "CTRL",action=act{ActivatePaneDirection="Right"}},

    -- Tab navigation
    { key = "z", mods = "LEADER", action=act.TogglePaneZoomState },
    { key = "0", mods = "LEADER", action=act.ShowTabNavigator},
    { key = "1", mods = "LEADER", action=act{ActivateTab=0}},
    { key = "2", mods = "LEADER", action=act{ActivateTab=1}},
    { key = "3", mods = "LEADER", action=act{ActivateTab=2}},
    { key = "4", mods = "LEADER", action=act{ActivateTab=3}},
    { key = "5", mods = "LEADER", action=act{ActivateTab=4}},
    { key = "6", mods = "LEADER", action=act{ActivateTab=5}},
    { key = "7", mods = "LEADER", action=act{ActivateTab=6}},
    { key = "8", mods = "LEADER", action=act{ActivateTab=7}},
    { key = "LeftArrow", mods = "SHIFT", action=act{ActivateTabRelative=-1}},
    { key = "RightArrow", mods = "SHIFT", action=act{ActivateTabRelative=1}},
    { key = "LeftArrow", mods = "CTRL|SHIFT", action=act{MoveTabRelative=-1}},
    { key = "RightArrow", mods = "CTRL|SHIFT", action=act{MoveTabRelative=1}},
    { key = "Tab", mods = "LEADER", action=act.ActivateLastTab},

    -- Resize
    { key = "H", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Right", 5}}},

    -- Fullscreen
    { key = "f", mods = "LEADER", action=act.ToggleFullScreen }

  },

  set_environment_variables = {},

}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.term = "" -- Set to empty so FZF works on windows

  table.insert(config.launch_menu, { label = "PowerShell", args = {"powershell.exe"} })
  table.insert(config.launch_menu, {
    label = 'Florence Developer Powershell for VS 2022',
    args = {
      'powershell.exe',
      '-noe',
      '-c',
      '&{Import-Module "C:/Program Files/Microsoft Visual Studio/2022/Community/Common7/Tools/Microsoft.VisualStudio.DevShell.dll"; Enter-VsDevShell f869764e}',
    },
  })

else
    table.insert(config.launch_menu, { label = "zsh", args = {"zsh", "-l"} })
end

-- Equivalent to POSIX basename(3)
local function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local title = basename(pane.foreground_process_name)
  return {
    {Text=" " .. title .. " "},
  }
end)

return config
