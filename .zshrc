# History: ~/.zsh_history
HISTFILE=~/.zsh_history
HISTSIZE=500
SAVEHIST=1000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/sam/.zshrc'
autoload -Uz compinit
compinit

# Go faster options
setopt auto_cd

# Locale Variables
export LC_ALL=C

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Alias definitions
if [ -r ~/.aliasrc ]; then
    . ~/.aliasrc
fi

# Scripts definitions
# Source all scripts in ~/.shell_scripts
if [ -d ~/.shell_scripts ]; then
    for script in ~/.shell_scripts/*; do
        [ -r "$script" ] && [ -f "$script" ] && source "$script"
    done
fi

# fzf

# Starship

# OhMyPosh
export OMP_INSTALL="$HOME/.ohmyposh"
export PATH=$OMP_INSTALL/bin:$PATH
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh.toml)"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# bun completions
[ -s "/Users/sam/.bun/_bun" ] && source "/Users/sam/.bun/_bun"

fastfetch
