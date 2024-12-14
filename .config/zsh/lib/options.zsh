# directories
setopt AUTO_CD
# setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# history
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
# setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# others
setopt MULTIOS                # enable redirect to multiple streams: echo >file1 >file2
setopt LONG_LIST_JOBS         # show long list format job notifications
setopt INTERACTIVE_COMMENTS   # recongnize comments
