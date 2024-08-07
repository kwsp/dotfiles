<h1 align="center">Dotfiles</h1>

<h4 align="center">Collection of config files to reproduce my work environment.</h4>

| Software    | Name                                                                                                                           |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Distro      | [Debian Testing](https://www.debian.org/releases/testing/)                                                                     |
| WM          | [i3-gaps](https://github.com/Airblader/i3)                                                                                     |
| Lock        | [i3lock-color](https://github.com/Raymo111/i3lock-color) + [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) |
| Launcher    | [Rofi](https://github.com/davatorium/rofi)                                                                                     |
| Bar         | [Polybar](https://github.com/polybar/polybar)                                                                                  |
| Compositor  | [compton-tryone](https://github.com/tryone144/compton)                                                                         |
| Terminal    | [kitty](https://sw.kovidgoyal.net/kitty/)                                                                                      |
| Shell       | [zsh](http://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)                                                                    |
| Multiplexer | [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux)                                          |
| PDF Viewer  | [zathura](https://pwmt.org/projects/zathura/)                                                                                  |
| Editor      | [Neovim](https://neovim.io/) + [Vim Plug](https://github.com/junegunn/vim-plug)                                                |

## Usage

Install config files:

```bash
git clone https://github.com/tiega/dotfiles
cd dotfiles
./install.sh
```

NOTE: The script only installs the config files and core terminal software (Oh My Zsh, Oh My Tmux). Depending on your distro, some of the software listed above require compilation from source.

## Try the shell in Docker

```bash
docker run -it tigernie/dotfiles
```
