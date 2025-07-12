# Add zfunc dir
fpath+="$HOME/.config/zsh/zfunc"

# Load compinit
autoload -Uz compinit bashcompinit
zstyle ':completion:*' menu select
compinit
bashcompinit

# app completions
if type register-python-argcomplete &>/dev/null; then
  eval "$(register-python-argcomplete pipx)"
  eval "$(register-python-argcomplete pmbootstrap)"
fi
