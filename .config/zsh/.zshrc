# Sourcing lib scripts
for file in $ZDOTDIR/lib/{*.zsh,*.sh}(N); do
    [ -r $file ] && source $file
done

if [ -f "$XDG_DATA_HOME/miniplug/miniplug.zsh" ]; then
    source "$XDG_DATA_HOME/miniplug/miniplug.zsh"

    # Load plugins with miniplug
    miniplug plugin 'reegnz/jq-zsh-plugin'
    miniplug plugin 'hlissner/zsh-autopair'
    miniplug plugin 'zsh-users/zsh-completions'
    miniplug plugin 'zsh-users/zsh-autosuggestions'
    miniplug plugin 'zsh-users/zsh-syntax-highlighting'
    # zsh-syntax-highlighting must be the last plugin sourced

    miniplug load
else
    print "Miniplug doesn't seem to be installed. It can be installed from its repo: https://git.sr.ht/~yerinalexey/miniplug"
fi

# Options
SAVEHIST=100000
HISTSIZE=100000
ZSH_AUTOSUGGEST_STRATEGY=( completion )

# Program Settings
if type rg &>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m'
fi
if type sccache &>/dev/null; then
    export RUSTC_WRAPPER=sccache
fi
if type eza &>/dev/null; then
    export EZA_ICONS_AUTO=1
    alias ls="eza"
fi

# Aliases
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias vimdiff='nvim -d'

# Starship prompt
eval "$(starship init zsh)"

export PATH=$PATH:/home/eggrror404/.spicetify
