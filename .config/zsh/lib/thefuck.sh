if type thefuck &>/dev/null; then
    alias fuck='if ! declare -f fuck &>/dev/null; then eval -- "$(thefuck -a)"; fi && fuck'
fi
