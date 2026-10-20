# Login-shell setup. Shared between macOS and Linux: guard anything OS-specific.

# Homebrew (macOS: /opt/homebrew, Linux: Linuxbrew if installed)
for _brew in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x $_brew ]] && { eval "$($_brew shellenv)"; break; }
done
unset _brew

if [[ $OSTYPE == darwin* ]]; then
  # Homebrew LLVM before Apple clang (remove if Xcode builds misbehave)
  path=(/opt/homebrew/opt/llvm/bin $path)
  export MallocNanoZone='0'

  # JetBrains Toolbox
  path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")

  # OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
else
  # JetBrains Toolbox
  [[ -d $XDG_DATA_HOME/JetBrains/Toolbox/scripts ]] && path+=("$XDG_DATA_HOME/JetBrains/Toolbox/scripts")
fi

# Point Ghostty at this OS's config (only when the link is missing, so no work on normal startups)
if [[ -d $XDG_CONFIG_HOME/ghostty && ! -e $XDG_CONFIG_HOME/ghostty/platform.conf ]]; then
  case $OSTYPE in
    darwin*) ln -s config.macos $XDG_CONFIG_HOME/ghostty/platform.conf ;;
    linux*)  ln -s config.linux $XDG_CONFIG_HOME/ghostty/platform.conf ;;
  esac
fi
