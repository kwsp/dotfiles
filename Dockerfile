FROM debian:bookworm-slim

ARG USERNAME=tnie
ARG UID=1000

ENV DEBIAN_FRONTEND=noninteractive \
    USERNAME=${USERNAME} \
    USER=${USERNAME} \
    USER_UID=${UID}

# Install core packages (apt cache cleaned in same layer to save ~30MB)
RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq \
        build-essential \
        ca-certificates \
        curl \
        fd-find \
        git \
        git-lfs \
        gnupg \
        openssh-client \
        python3-dev \
        python3-pip \
        python3-setuptools \
        ripgrep \
        sudo \
        tmux \
        unzip \
        wget \
        zsh && \
    rm -rf /var/lib/apt/lists/*

# Install Neovim v0.11.6 from GitHub releases (arch-aware, statically linked)
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
      x86_64)  NVIM_ARCH=x86_64 ;; \
      aarch64) NVIM_ARCH=arm64  ;; \
      *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-${NVIM_ARCH}.tar.gz" \
        -o /tmp/nvim.tar.gz && \
    tar -xzf /tmp/nvim.tar.gz -C /usr/local --strip-components=1 && \
    rm /tmp/nvim.tar.gz

# Install fzf 0.68.0 from GitHub releases (arch-aware, ensures fzf --zsh is available)
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
      x86_64)  FZF_ARCH=amd64 ;; \
      aarch64) FZF_ARCH=arm64 ;; \
      *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-linux_${FZF_ARCH}.tar.gz" \
        -o /tmp/fzf.tar.gz && \
    tar -xzf /tmp/fzf.tar.gz -C /usr/local/bin fzf && \
    rm /tmp/fzf.tar.gz

# Bake GitHub SSH host key (public info — avoids interactive prompt when cloning via SSH)
RUN mkdir -p /etc/ssh && \
    ssh-keyscan -t ed25519 github.com >> /etc/ssh/ssh_known_hosts

# Create user
RUN useradd -m -u "$USER_UID" -s /usr/bin/zsh "$USERNAME" && \
    echo "$USERNAME ALL=(root) NOPASSWD:ALL" > "/etc/sudoers.d/$USERNAME" && \
    chmod 0440 "/etc/sudoers.d/$USERNAME"

# Copy and install entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy dotfiles and set ownership
COPY . /home/$USERNAME/dotfiles
RUN chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/dotfiles"

USER $USERNAME
WORKDIR /home/$USERNAME
ENV SHELL=/usr/bin/zsh

# Install dotfiles, oh-my-zsh, oh-my-tmux, etc.
RUN cd "/home/$USERNAME/dotfiles" && ./install.sh

# Enable git-lfs for the user
RUN git lfs install

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/zsh"]
