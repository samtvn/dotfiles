eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew LLVM before Apple clang (remove if Xcode builds misbehave)
path=(/opt/homebrew/opt/llvm/bin $path)
export MallocNanoZone='0'

# Added by Toolbox App
export PATH="$PATH:/Users/sam/Library/Application Support/JetBrains/Toolbox/scripts"


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Point Ghostty at this OS's config (only when the link is missing, so no work on normal startups)
if [[ ! -e $XDG_CONFIG_HOME/ghostty/platform.conf ]]; then
  case $OSTYPE in
    darwin*) ln -s config.macos $XDG_CONFIG_HOME/ghostty/platform.conf ;;
    linux*)  ln -s config.linux $XDG_CONFIG_HOME/ghostty/platform.conf ;;
  esac
fi
