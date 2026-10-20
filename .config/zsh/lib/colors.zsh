# LS_COLORS for eza, fd, and the completion menu (macOS has no dircolors)
if (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid generate catppuccin-macchiato)"
fi

# Colored output for BSD ls
export CLICOLOR=1
