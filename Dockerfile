FROM ubuntu:24.04

# Noninteractive install
ENV DEBIAN_FRONTEND noninteractive

# Install core software
RUN apt-get update -q && \
  apt-get upgrade -yq && \
  apt-get install -yq apt-transport-https software-properties-common build-essential curl git sudo \
    ca-certificates gnupg \
    tmux unzip wget zsh ripgrep fd-find \
    python3-dev python3-pip python3-setuptools 

# Install a more recent version of neovim
RUN add-apt-repository ppa:neovim-ppa/stable && apt-get update -q && apt-get install -yq neovim

# Create user
RUN useradd kwsp && \
  echo "kwsp ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/kwsp && \
  chmod 0440 /etc/sudoers.d/kwsp && \
  mkdir -p /home/kwsp && \
  chown kwsp:kwsp /home/kwsp && \
  chsh -s /usr/bin/zsh kwsp

# Copy dotfiles
COPY . /home/kwsp/dotfiles
RUN chown -R kwsp:kwsp /home/kwsp/dotfiles

USER kwsp
WORKDIR /home/kwsp
ENV SHELL /usr/bin/zsh

# Install dotfiles, oh my zsh, oh my tmux, vim plug etc
RUN cd /home/kwsp/dotfiles && ./install.sh

CMD /usr/bin/zsh
