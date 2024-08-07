<h2 align="center">Halcyon</h1>

<h4 aligh="center">This is my collection of config files for both Darwin and Linux. </h4>

<img src="https://github.com/NieTiger/halcyon-assets/raw/master/macOS-neofetch.png" alt="img" align="center" width="700px">

| Software    | Linux                                                                                 | Darwin                                   |
| ----------- | ------------------------------------------------------------------------------------- | ---------------------------------------- |
| Distro      | [Debian Testing](https://www.debian.org/releases/testing/)                            | macOS Catalina                           |
| WM          | [sway](https://github.com/swaywm/sway)                                                | [Rectangle](https://rectangleapp.com/)   |
| Bar         | swaybar                                                                               | [Übersicht](http://tracesof.net/uebersicht/) + [Pecan](https://github.com/zzzeyez/Pecan) |
| Launcher    | [j4-dmenu-desktop](https://github.com/enkore/j4-dmenu-desktop)                        | Spotlight                                |
| Screenshot  | [grim](https://github.com/emersion/grim)                                              | screencapture                            |
| Terminal    | [kitty](https://sw.kovidgoyal.net/kitty/)                                             | [iTerm2](https://iterm2.com/)            |
| Shell       | [zsh](http://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)                           | ditto                          |
| Multiplexer | [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux) | ditto                        |
| PDF Viewer  | [zathura](https://pwmt.org/projects/zathura/)                                         | [Skim](https://skim-app.sourceforge.io/) |
| Editor      | [Neovim](https://neovim.io/)                                                          | ditto                                    |

- iTerm2 theme:   [halcyon-iterm](https://github.com/bchiang7/halcyon-iterm)
- NeoVim theme: [halcyon-neovim](https://github.com/NieTiger/halcyon-neovim)
- kitty theme: custom halcyon in config
- Pecan theme: custom halcyon in config

## Usage

The install script installs all config files. It also takes care of Oh My Zsh, Oh My Tmux, and (if on Darwin) Pecan + Übersicht . You need to install some software manually (brew, zsh, NeoVim, Python3, NodeJS, ripgrep).

```bash
cd && git clone https://github.com/NieTiger/dotfiles && cd dotfiles
./install.sh
```

## Try the shell in Docker

The Dockerfile completely reproduces the CLI environment. NeoVim will attempt to install all plugins the first time you open it. Give it a shot :)

```bash
docker run -it tigernie/dotfiles
```
