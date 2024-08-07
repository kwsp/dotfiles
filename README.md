<h1 align="center">Halcyon</h1>

<h4 align="center">Collection of config files to reproduce my work environment.</h4>

| Software    | Linux                                                                                 | macOS                                    |
| ----------- | ------------------------------------------------------------------------------------- | ---------------------------------------- |
| Distro      | [Debian Testing](https://www.debian.org/releases/testing/)                            | Catalina                                 |
| WM          | [sway](https://github.com/swaywm/sway)                                                | [Rectangle](https://rectangleapp.com/)   |
| Launcher    | [j4-dmenu-desktop](https://github.com/enkore/j4-dmenu-desktop)                        | Spotlight                                |
| Screenshot  | [grim](https://github.com/emersion/grim)                                              | screencapture                            |
| Terminal    | [kitty](https://sw.kovidgoyal.net/kitty/)                                             | [iTerm2](https://iterm2.com/)            |
| Shell       | [zsh](http://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)                           | zsh + Oh My Zsh                          |
| Multiplexer | [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux) | tmux + Oh My Tmux                        |
| PDF Viewer  | [zathura](https://pwmt.org/projects/zathura/)                                         | [Skim](https://skim-app.sourceforge.io/) |
| Editor      | [Neovim](https://neovim.io/) + [Vim Plug](https://github.com/junegunn/vim-plug)       | Neovim                                   |

## Usage

Install config files:

```bash
git clone https://github.com/NieTiger/dotfiles
cd dotfiles
./install.sh
```

NOTE: The script only installs the config files and core terminal software (Oh My Zsh, Oh My Tmux). Depending on your distro, some of the software listed above require compilation from source.

## Try the shell in Docker

```bash
docker run -it tigernie/dotfiles
```
