-- Inspired by https://github.com/codito/configs-win/blob/master/.wezterm.lua
local wezterm = require("wezterm")

local config = {
  fot = wezterm.font 'Hack Nerd Font Mono',

  tab_bar_at_bottom = true,
  default_prog = { 'powershell.exe' },
  launch_menu = {},

  leader = { key="b", mods="CTRL" },
  use_dead_keys = false,
  keys = {
    -- New/close pane
    { key = "c", mods = "LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "x", mods = "LEADER", action=wezterm.action{CloseCurrentPane={confirm=false}}},
    { key = "d", mods = "LEADER", action=wezterm.action{CloseCurrentPane={confirm=true}}},
    

    -- Split panes
    { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "\\",mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},


    -- Pane navigation
    { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "h", mods = "ALT",       action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "ALT",       action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "ALT",       action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "ALT",       action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "LeftArrow", mods = "CTRL", action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "DownArrow", mods = "CTRL", action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "UpArrow", mods = "CTRL",   action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "RightArrow", mods = "CTRL",action=wezterm.action{ActivatePaneDirection="Right"}},

    -- Tab navigation
    { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "0", mods = "LEADER",       action="ShowTabNavigator"},
    { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
    { key = "LeftArrow", mods = "SHIFT",    action=wezterm.action{ActivateTabRelative=-1}},
    { key = "RightArrow", mods = "SHIFT",   action=wezterm.action{ActivateTabRelative=1}},
    { key = "LeftArrow", mods = "CTRL|SHIFT",    action=wezterm.action{MoveTabRelative=-1}},
    { key = "RightArrow", mods = "CTRL|SHIFT",   action=wezterm.action{MoveTabRelative=1}},
    { key = "Tab", mods = "LEADER",       action=wezterm.action.ActivateLastTab},

    -- Resize
    { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},

  },

  set_environment_variables = {},

}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.term = "" -- Set to empty so FZF works on windows
    table.insert(config.launch_menu, { label = "PowerShell 5", args = {"powershell.exe"} })
    table.insert(config.launch_menu, { label = "Ubuntu", args = {"ubuntu.exe"} })
    table.insert(config.launch_menu, { label = "VS PowerShell 2022", args = {"powershell.exe", "-NoLogo", "-NoExit", "-Command", "devps 17.0"} })
    table.insert(config.launch_menu, { label = "VS PowerShell 2019", args = {"powershell.exe", "-NoLogo", "-NoExit", "-Command", "devps 16.0"} })
    table.insert(config.launch_menu, { label = "Command Prompt", args = {"cmd.exe"} })
    table.insert(config.launch_menu, { label = "VS Command Prompt 2022", args = {"powershell.exe", "-NoLogo", "-NoExit", "-Command", "devcmd 17.0"} })
    table.insert(config.launch_menu, { label = "VS Command Prompt 2019", args = {"powershell.exe", "-NoLogo", "-NoExit", "-Command", "devcmd 16.0"} })
else
    table.insert(config.launch_menu, { label = "zsh", args = {"zsh", "-l"} })
end

-- Equivalent to POSIX basename(3)
function basename(s)
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
