REM Install config files on Windows

xcopy /s /i /y ".\config\nvim" %localappdata%\nvim
xcopy /s /i /y ".\win" %UserProfile%
xcopy /y ".\dotfiles\.gitconfig" %UserProfile%
