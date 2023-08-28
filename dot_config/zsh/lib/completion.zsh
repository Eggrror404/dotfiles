# Add zfunc dir
fpath+="$HOME/.config/zsh/zfunc"

# Load compinit
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# app completions
if type register-python-argcomplete &>/dev/null; then
  eval "$(register-python-argcomplete pipx)"
fi
