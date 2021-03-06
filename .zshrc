autoload -U compinit compaudit

export ZSH="${HOME}/.zsh"
ZSH_CACHE_DIR="$ZSH/cache"
SHORT_HOST=${HOST/.*/}
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

for config_file ($ZSH/lib/*.zsh); do
  source $config_file
done

if [[ $ZSH_DISABLE_COMPFIX != true ]]; then
  # If completion insecurities exist, warn the user
  handle_completion_insecurities
  # Load only from secure directories
  compinit -i -C -d "${ZSH_COMPDUMP}"
else
  # If the user wants it, load from all found directories
  compinit -u -C -d "${ZSH_COMPDUMP}"
fi

# Load the theme
source $ZSH/theme

### QoL / theming
alias v=nvim
alias g=git
alias icat="kitty +kitten icat" # display image in terminal
alias d="nvim -d" # diff files
alias config='/usr/bin/git --git-dir=${DOTFILES_REPO} --work-tree=$HOME' # handle dotfiles
if [ "$TERM" = "xterm-kitty" ]
then;
    alias ssh="kitty +kitten ssh"
fi
export EDITOR='nvr -s --remote-wait-silent'
export GIT_EDITOR='nvr -s --remote-wait-silent'
export FZF_DEFAULT_COMMAND='rg --files --glob "!third_party/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--color=light"
export CMAKE_EXPORT_COMPILE_COMMANDS=1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias rcp="rsync -avhW --no-compress --progress"
