if type -p dircolors &>/dev/null; then
    #  Enable custom colors if it exists.
    [ -e "${XDG_CONFIG_HOME}/dircolors" ] && \
    eval "$(dircolors -b "${XDG_CONFIG_HOME}/dircolors")" || \
    eval "$(dircolors -b)"
fi