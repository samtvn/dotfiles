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

# Source the first plugin file found in the usual install locations:
# Homebrew, Arch (/usr/share/zsh/plugins), Debian (/usr/share), or a manual clone in $XDG_DATA_HOME/zsh/plugins.
# Usage: load_plugin <file> <dir-name>...   (dir names differ between package managers)
load_plugin() {
  local file=$1 dir base; shift
  for base in ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/share} /usr/share/zsh/plugins /usr/share $XDG_DATA_HOME/zsh/plugins; do
    for dir in "$@"; do
      [[ -r $base/$dir/$file ]] && { source $base/$dir/$file; return 0; }
    done
  done
  return 1
}

# Starship
(( $+commands[starship] )) && eval "$(starship init zsh)"

# zoxide
(( $+commands[zoxide] )) && eval "$(zoxide init --cmd cd zsh)"

# fzf (Ctrl+T files, Alt+C dirs; Ctrl+R is rebound by atuin below)
(( $+commands[fzf] )) && source <(fzf --zsh) 2>/dev/null

# Plugins. macOS: brew install fzf-tab zsh-you-should-use zsh-autosuggestions zsh-fast-syntax-highlighting
# Arch: pacman -S zsh-autosuggestions; yay -S fzf-tab-git zsh-you-should-use zsh-fast-syntax-highlighting
# fzf-tab must come after fzf so it owns Tab; syntax highlighting is sourced last (below).
load_plugin fzf-tab.zsh fzf-tab fzf-tab-git
load_plugin you-should-use.plugin.zsh zsh-you-should-use
load_plugin zsh-autosuggestions.zsh zsh-autosuggestions

(( $+commands[mise] )) && eval "$(mise activate zsh)"

(( $+commands[atuin] )) && eval "$(atuin init zsh)"

# Must be sourced after everything that defines widgets
load_plugin fast-syntax-highlighting.plugin.zsh zsh-fast-syntax-highlighting fast-syntax-highlighting

# Welcome message in the first Ghostty shell only (not in nested shells or other terminals)
if [[ $TERM_PROGRAM == ghostty && $SHLVL -le 1 ]] && (( $+commands[fastfetch] )); then
  fastfetch
fi
