# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Shell options
setopt AUTO_CD              # Type a directory name to cd into it
setopt INTERACTIVE_COMMENTS # Allow # comments in pasted commands
setopt NO_BEEP

# Source all ZSH config files (if present)
if [[ -d $ZDOTDIR ]]; then
  # Import alias files
  source ${ZDOTDIR}/aliases/general.zsh
  source ${ZDOTDIR}/aliases/git.zsh
  source ${ZDOTDIR}/aliases/rust.zsh

  # Configure ZSH stuff
  source ${ZDOTDIR}/lib/colors.zsh
  source ${ZDOTDIR}/lib/completion.zsh
  source ${ZDOTDIR}/lib/expansions.zsh
  source ${ZDOTDIR}/lib/functions.zsh
  source ${ZDOTDIR}/lib/history.zsh
  source ${ZDOTDIR}/lib/keybindings.zsh
  source ${ZDOTDIR}/lib/navigation.zsh
fi

# Starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf (Ctrl+T files, Alt+C dirs; Ctrl+R is rebound by atuin below)
source <(fzf --zsh) 2>/dev/null

# Plugins (brew install fzf-tab zsh-you-should-use zsh-autosuggestions zsh-fast-syntax-highlighting)
# fzf-tab must come after fzf so it owns Tab; syntax highlighting is sourced last (below).
_brew_share=/opt/homebrew/share
[[ -r $_brew_share/fzf-tab/fzf-tab.zsh ]] && source $_brew_share/fzf-tab/fzf-tab.zsh
[[ -r $_brew_share/zsh-you-should-use/you-should-use.plugin.zsh ]] && source $_brew_share/zsh-you-should-use/you-should-use.plugin.zsh
[[ -r $_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh
unset _brew_share

eval "$(mise activate zsh)"

eval "$(atuin init zsh)"

# Must be sourced after everything that defines widgets
[[ -r /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] && \
  source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Welcome message in the first Ghostty shell only (not in nested shells or other terminals)
if [[ $TERM_PROGRAM == ghostty && $SHLVL -le 1 ]] && (( $+commands[fastfetch] )); then
  fastfetch
fi
