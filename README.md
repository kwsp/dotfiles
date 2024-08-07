<h1 align="center">Dotfiles</h1>

<h4 align="center">Collection of config files to reproduce my work environment.</h4>

| Software    | Name                                                                                                                           |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------ |
| Distro      | [Debian Testing](https://www.debian.org/releases/testing/)                                                                     |
| WM          | [sway](https://github.com/swaywm/sway)                                                                                         |
| Launcher    | [j4-dmenu-desktop](https://github.com/enkore/j4-dmenu-desktop)                                                                 |
| Terminal    | [kitty](https://sw.kovidgoyal.net/kitty/)                                                                                      |
| Shell       | [zsh](http://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)                                                                    |
| Multiplexer | [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux)                                          |
| PDF Viewer  | [zathura](https://pwmt.org/projects/zathura/)                                                                                  |
| Editor      | [Neovim](https://neovim.io/) + [Vim Plug](https://github.com/junegunn/vim-plug)                                                |

I'm currently using a Dell XPS 13 7390 and I get really bad screen tearing with Xorg, regardless of desktop environment and window manager. The only solution I found for my problem was Wayland. Sway is an incredible clone of i3 on Wayland (including features like gaps, bar, Dmenu) that just works out of the box. 

My XPS shipped with Ubuntu 18.04, but Canonical has really been annoying me with snaps so I switched to Debian Testing because 1. I want a Debian based (ha) distro and 2. I want relatively updated packages.

I previously used a complex setup that includes i3wm, polybar, compton, deadd to do all kinds of stuff, but since switching to Wayland and Sway full time I've taken on a more minimalistic approach, and I've actually quite enjoyed a lot of the defaults offered by Sway (they are definitely more sane).

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
