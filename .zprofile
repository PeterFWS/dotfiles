# This disables running compinit from /etc/zsh
# Reduces startup time by a lot!
skip_global_compinit=1

# My stuff
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.bin/git-aliases:$PATH"
# Obv
PATH="$HOME/.cargo/bin:$PATH"
# pip-installed binaries
PATH="$HOME/.local/bin:$PATH"

export PATH

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
