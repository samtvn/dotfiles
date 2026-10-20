# LS_COLORS for eza, fd, and the completion menu
if (( $+commands[vivid] )); then
  export LS_COLORS="$(vivid generate catppuccin-macchiato)"
elif (( $+commands[dircolors] )); then
  eval "$(dircolors -b)" # Linux fallback when vivid isn't installed
fi

# Colored output for BSD ls (macOS); GNU ls needs --color
export CLICOLOR=1
[[ "$OSTYPE" == linux* ]] && alias ls='ls --color=auto'
