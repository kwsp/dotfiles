# Halcyon

This is my collection of config files for *nix systems.

| **Linux**                                                                                                   | **Darwin**                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/kwsp/halcyon-assets/raw/master/halcyon-debian.png" alt="debian" align="right"> | <img src="https://github.com/kwsp/halcyon-assets/raw/master/macOS-neofetch.png" alt="macos" align="right"> |

| Software    | Linux                                                                                 | Darwin                                                                                   |
| ----------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| Distro      | [Debian Testing](https://www.debian.org/releases/testing/)                            | macOS Sonoma                                                                           |
| WM          | [sway](https://github.com/swaywm/sway)                                                | [Rectangle](https://rectangleapp.com/)                                                   |
| Bar         | swaybar                                                                               | [Übersicht](http://tracesof.net/uebersicht/) + [Pecan](https://github.com/zzzeyez/Pecan) |
| Launcher    | [j4-dmenu-desktop](https://github.com/enkore/j4-dmenu-desktop)                        | Spotlight                                                                                |
| Screenshot  | [grim](https://github.com/emersion/grim)                                              | screencapture                                                                            |
| Terminal    | [kitty](https://sw.kovidgoyal.net/kitty/)                                             | [iTerm2](https://iterm2.com/)                                                            |
| Shell       | [zsh](http://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)                           | [zsh](http://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)                              |
| Multiplexer | [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux) | [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux)    |
| PDF Viewer  | [zathura](https://pwmt.org/projects/zathura/)                                         | [Skim](https://skim-app.sourceforge.io/)                                                 |
| Editor      | [Neovim](https://neovim.io/)                                                          | [Neovim](https://neovim.io/)                                                             |

- iTerm2 theme: [halcyon-iterm](https://github.com/bchiang7/halcyon-iterm)
- NeoVim theme: [halcyon-neovim](https://github.com/kwsp/halcyon-neovim)
- kitty theme: custom halcyon in config
- Pecan theme: custom halcyon in config

I basically live inside tmux, NeoVim and friends (ripgrep, fzf, ...) so a lot of config is in my Neovim config.

## Usage

The install script installs all config files. It also takes care of Oh My Zsh, Oh My Tmux, and (if on Darwin) Pecan + Übersicht . You need to install some software manually (brew, zsh, NeoVim, Python3, NodeJS, ripgrep).

```bash
cd && git clone https://github.com/kwsp/dotfiles && cd dotfiles
./install.sh
```

## Try the shell in Docker

The Dockerfile completely reproduces the CLI environment. NeoVim will attempt to install all plugins the first time you open it. Give it a shot :)

```bash
docker run --rm -it kwsp/dotfiles
```
