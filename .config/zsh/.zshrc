# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# MacOS-specific services
if [[ "$OSTYPE" = darwin* ]]; then
  # Add Brew to path, if it's installed
  if [[ -d /opt/homebrew/bin ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
  fi
  ln -sf "$HOME/.config/ghostty/config.macos" "$HOME/.config/ghostty/config"
fi

# Source all ZSH config files (if present)
if [[ -d $ZDOTDIR ]]; then
  # Import alias files
  source ${ZDOTDIR}/aliases/alias-tips.zsh
  source ${ZDOTDIR}/aliases/general.zsh
  source ${ZDOTDIR}/aliases/git.zsh
  source ${ZDOTDIR}/aliases/rust.zsh

  # Configure ZSH stuff
  source ${ZDOTDIR}/lib/colors.zsh
  source ${ZDOTDIR}/lib/completion.zsh
  source ${ZDOTDIR}/lib/cursor.zsh
  source ${ZDOTDIR}/lib/expansions.zsh
  source ${ZDOTDIR}/lib/functions.zsh
  source ${ZDOTDIR}/lib/history.zsh
  source ${ZDOTDIR}/lib/keybindings.zsh
  source ${ZDOTDIR}/lib/navigation.zsh
fi

# Linux-specific services
if [[ "$OSTYPE" = linux-gnu* ]]; then
    ln -sf "$HOME/.config/ghostty/config.linux" "$HOME/.config/ghostty/config"
fi

# Starship
eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh --config ${XDG_CONFIG_HOME}/ohmyposh/ohmyposh.json)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf
source <(fzf --zsh) 2>/dev/null

# If not running in nested shell, then show welcome message :)
#if [[ "${SHLVL}" -lt 2 ]] && \
#  { [[ -z "$SKIP_WELCOME" ]] || [[ "$SKIP_WELCOME" == "false" ]]; }; then
#  fastfetch
#fi

eval "$(mise activate zsh)"

eval "$(atuin init zsh)"
