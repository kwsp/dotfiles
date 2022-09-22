REM Backup config files on Windows

xcopy /s /i /y %localappdata%\nvim ".\config\nvim"
xcopy /i /y %UserProfile%\.vsvimrc ".\win\.vsvimrc"
xcopy /i /y %UserProfile%\.wezterm.lua ".\win\.wezterm.lua"
xcopy /y %UserProfile%\.gitconfig ".\dotfiles\.gitconfig"
