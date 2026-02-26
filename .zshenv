# Set XDG directories
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_STATE_HOME="${HOME}/.local/state"

# Set default applications
export EDITOR="nano"
export TERMINAL="ghostty"
export BROWSER="firefox"
export PAGER="less"

# Respect XDG directories
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CIPD_CACHE_DIR="${XDG_CACHE_HOME}/ci-packages"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export GIT_CONFIG="${XDG_CONFIG_HOME}/git/.gitconfig"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export KUBECONFIG="${XDG_CONFIG_HOME}/kube/.yaml"
export LESSHISTFILE="-"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export PIP_LOG_FILE="${XDG_DATA_HOME}/pip/log"
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"
export PLATFORMIO_CORE_DIR="${XDG_DATA_HOME}/platformio"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export TMUX_CONF="${XDG_CONFIG_HOME}/tmux/tmux.conf"
export WGETRC="${XDG_CONFIG_HOME}/wget/.wgetrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZLIB="${ZDOTDIR}/lib"

# Locale Variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYTHONIOENCODING='UTF-8';

# History configuration
export HISTFILE="${XDG_CACHE_HOME}/zsh/.zsh_history"
export HISTSIZE=50000
export HISTFILESIZE=50000
export SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history

# Add language-specific bins to PATH
export PATH="$GOPATH/bin:$PNPM_HOME:${XDG_DATA_HOME}/cargo/bin:$PATH"

# make sure user‐installed scripts are on PATH
if [[ -d "$XDG_BIN_HOME" ]]; then
  export PATH="$XDG_BIN_HOME:$PATH"
fi
