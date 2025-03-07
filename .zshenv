# XDG user dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# zsh paths
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE=$XDG_STATE_HOME/zsh/history

# application paths
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node_repl_history
export NUGET_PACKAGES=$XDG_CACHE_HOME/NuGetPackages
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export GOPATH=$XDG_DATA_HOME/go
export GOMODCACHE=$XDG_CACHE_HOME/go/mod
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config

# Applications
export TERM=alacritty
export EDITOR=nvim
export DIFFPROG="nvim -d"

# PATH
export PATH="$HOME/.local/bin:$HOME/.local/share/cargo/bin:$HOME/.local/share/npm/bin:$HOME/.local/share/go/bin:$HOME/.spicetify:$PATH"
