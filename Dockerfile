from ubuntu:20.04

# Noninteractive install
ENV DEBIAN_FRONTEND noninteractive

# Install core software
RUN apt-get update -qq && \
  apt-get upgrade -qq -y && \
  apt-get install -qq -y \
    apt-transport-https \
    build-essential \
    curl \
    git \
    neovim \
    python3-dev \
    python3-pip \
    python3-setuptools \
    software-properties-common \
    sudo \
    tmux \
    unzip \
    wget \
    zsh

# Install node and yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install yarn

# Create user
RUN useradd tiger && \
  echo "tiger ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/tiger && \
  chmod 0440 /etc/sudoers.d/tiger && \
  mkdir -p /home/tiger && \
  chown tiger:tiger /home/tiger && \
  chsh -s /usr/bin/zsh tiger

# Copy dotfiles
COPY . /home/tiger/dotfiles
RUN chown -R tiger:tiger /home/tiger/dotfiles

USER tiger
WORKDIR /home/tiger
ENV SHELL /usr/bin/zsh

# Install dotfiles, oh my zsh, oh my tmux, vim plug etc
RUN cd /home/tiger/dotfiles && ./install.sh

CMD /usr/bin/zsh
