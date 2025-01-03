# Add any commands which depend on conda here
lazy_conda_aliases=('conda')

load_conda() {
  for lazy_conda_alias in $lazy_conda_aliases; do
    unalias $lazy_conda_alias
  done

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
      . "/usr/etc/profile.d/conda.sh"
    else
      export PATH="/usr/bin:$PATH"
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  unfunction load_conda
}

for lazy_conda_alias in $lazy_conda_aliases; do
  alias $lazy_conda_alias="load_conda && $lazy_conda_alias"
done
