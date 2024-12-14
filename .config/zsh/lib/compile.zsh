# Zcompile script files in `lib` for faster loading

for file in $ZDOTDIR/lib/{*.zsh,*.sh}(N); do
    # Do zcompile when zwc doesn't exist OR source file is newer
    if [[ ! $file.zwc -nt $file ]]; then
        # Make sure having read and write access
        [[ -r $file && -w ${file:h} ]] && zcompile ${file}
    fi
done
