# Add zfunc dir
fpath+="$HOME/.config/zsh/zfunc"

# Load compinit
autoload -Uz compinit bashcompinit
zstyle ':completion:*' menu select
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
bashcompinit

# python app completions
if type register-python-argcomplete &>/dev/null; then
  apps=(pipx pmbootstrap)
  for app in "${apps[@]}"; do
    if type "$app" &>/dev/null; then
      eval "$(register-python-argcomplete "$app")"
    fi
  done
fi
