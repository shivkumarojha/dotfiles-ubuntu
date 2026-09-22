# ~/.bashrc
# Bash configuration for Shiv
# Merged from old laptop workflow + new Ubuntu installation

# ============================================================
# Bash defaults
# ============================================================

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# Update terminal dimensions after commands
shopt -s checkwinsize

# Optional: recursive globbing with **
# shopt -s globstar

# less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Debian/Ubuntu chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# ============================================================
# Prompt
# ============================================================

case "$TERM" in
xterm-color | *-256color)
  color_prompt=yes
  ;;
esac

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# Terminal title
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
esac

# ============================================================
# Colors / aliases
# ============================================================

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors &&
    eval "$(dircolors -b ~/.dircolors)" ||
    eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

# ============================================================
# Bash aliases file
# ============================================================

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# ============================================================
# Bash completion
# ============================================================

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ============================================================
# System / graphics
# ============================================================

# Useful on this machine for applications that have GPU issues
export LIBGL_ALWAYS_SOFTWARE=1

# ============================================================
# Neovim
# ============================================================

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# ============================================================
# NVM / Node.js
# ============================================================

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] &&
  . "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] &&
  . "$NVM_DIR/bash_completion"

# ============================================================
# Cargo / Rust
# ============================================================

[ -f "$HOME/.cargo/env" ] &&
  . "$HOME/.cargo/env"

# ============================================================
# Go
# ============================================================

export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

export PATH="$PATH:$(go env GOPATH)/bin"

# ============================================================
# Python / pyenv
# ============================================================

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# ============================================================
# pnpm
export PNPM_HOME="/home/shiv/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME/bin:"*) ;;
*) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# pnpm end
# pnpm alias
alias pnd="pnpm dev"
alias pns="pnpm start"
alias psd="pnpm start:dev"

# j for jump
eval "$(jump shell)"

# opencode
export PATH=/home/shiv/.opencode/bin:$PATH

# alias
alias server="ssh -i ~/.ssh/server.key ubuntu@161.118.185.126"

# opencode
alias oc="opencode"
alias occ="opencode --continue"
alias bashrc="source ~/.bashrc"



# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
