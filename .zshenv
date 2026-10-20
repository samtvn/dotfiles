# Read by every zsh (including scripts), so keep this to environment variables only.
# Interactive settings live in $ZDOTDIR/.zshrc.

# Drop duplicate entries from PATH/FPATH automatically
typeset -U path fpath

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
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="-"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export PIP_LOG_FILE="${XDG_DATA_HOME}/pip/log"
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"
export PLATFORMIO_CORE_DIR="${XDG_DATA_HOME}/platformio"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
export WGETRC="${XDG_CONFIG_HOME}/wget/.wgetrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Locale Variables
export LANG=en_US.UTF-8
export PYTHONIOENCODING='UTF-8'

# Add language-specific bins to PATH
path=("$XDG_BIN_HOME" "$GOPATH/bin" "$PNPM_HOME" "$CARGO_HOME/bin" $path)
