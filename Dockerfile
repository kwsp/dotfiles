from ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

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
    unzip \
    wget \
    zsh

RUN useradd tiger && \
  echo "tiger ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/tiger && \
  chmod 0440 /etc/sudoers.d/tiger && \
  mkdir -p /home/tiger && \
  chown tiger:tiger /home/tiger && \
  chsh -s /usr/bin/zsh tiger

COPY . /home/tiger/dotfiles

USER tiger
WORKDIR /home/tiger
ENV SHELL /usr/bin/zsh
CMD /usr/bin/zsh
