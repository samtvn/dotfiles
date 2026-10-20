
command_exists () {
  hash "$1" 2> /dev/null
}

alias_not_used () {
  ! alias "$1" >/dev/null && ! hash "$1" 2> /dev/null
}

# Single-letter aliases, for frequently used basics, only if not already set
if alias_not_used a; then; alias a='alias'; fi
if alias_not_used e; then; alias e='exit'; fi
if alias_not_used f; then; alias f='find'; fi
if alias_not_used h; then; alias h='history'; fi
if alias_not_used i; then; alias i='id'; fi
if alias_not_used j; then; alias j='jobs'; fi
if alias_not_used m; then; alias m='man'; fi
if alias_not_used n; then; alias n='nc'; fi
if alias_not_used p; then; alias p='pwd'; fi
if alias_not_used s; then; alias s='sudo'; fi
if alias_not_used t; then; alias t='touch'; fi
if alias_not_used v; then; alias v='vim'; fi

# File listing options
alias lr='ls -R' # List files in sub-directories, recursivley
alias lf='ls -A | grep' # Use grep to find files
alias lc='find . -type f | wc -l' # Shows number of files
alias ld='ls -l | grep "^d"' # List directories only

# If eza installed, use it for ls commands
if command_exists eza ; then
  alias l='eza -F --icons'
  la() { eza -aF --icons "$@" }
  ll() { eza -laF --icons "$@" }
  alias lt='eza --tree --level=2 --icons'
  lm() { eza -laF --sort=modified --icons "$@" }
  lb() { eza -laF --sort=size --icons "$@" }
else
  alias l='ls'
  alias la='ls -A'
  ll() { ls -lAFh "$@" }
  alias lb='ls -lhSA'
  lm() { ls -tA -1 "$@" }
fi

# List contents of packed file, depending on type
ls-archive () {
  if [ -z "$1" ]; then
    echo "No archive specified"
    return;
  fi
  if [[ ! -f $1 ]]; then
    echo "File not found"
    return;
  fi
  case "$1" in
    *.zip) unzip -l "$1" ;;
    *.rar) unrar l "$1" ;;
    *.tar|*.tar.gz|*.tgz|*.tar.bz2|*.tbz2|*.tar.xz) tar tf "$1" ;;
    *.7z) 7za l "$1" ;;
    *) echo "Unknown Archive Format" ;;
  esac
}

alias lz='ls-archive'

# Make directory, and cd into it
mkcd() {
  local dir="$*";
  mkdir -p "$dir" && cd "$dir";
}

# Make dir and copy
mkcp() {
  local dir="$2"
  local tmp="$2"; tmp="${tmp: -1}"
  [ "$tmp" != "/" ] && dir="$(dirname "$2")"
  [ -d "$dir" ] ||
    mkdir -p "$dir" &&
    cp -r "$@"
}

# Move dir and move into it
mkmv() {
  local dir="$2"
  local tmp="$2"; tmp="${tmp: -1}"
  [ "$tmp" != "/" ] && dir="$(dirname "$2")"
  [ -d "$dir" ] ||
      mkdir -p "$dir" &&
      mv "$@"
}

# Getting outa directories
alias c~='cd ~'
alias c.='cd ..'
alias c..='cd ../../'
alias c...='cd ../../../'
alias c....='cd ../../../../'
alias c.....='cd ../../../../../'
alias cg='cd `git rev-parse --show-toplevel`' # Base of git project

# Finding files and directories
alias dud='du -d 1 -h' # List sizes of files within directory
alias duf='du -sh *' # List total size of current directory
alias ff='fd --type f' # Find a file by name within current directory
alias fdir='fd --type d'
(( $+commands[fd] )) || alias fd='find . -type d -name' # Find direcroy by name

# Command line history
alias h-search='fc -El 0 | grep' # Searchses for a word in terminal history
alias top-history='history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head' 
alias histrg='history -500 | rg' # Rip grep search recent history

# Ctrl+R is handled by atuin (see .zshrc)

# Clearing terminal
alias c='clear'

# Command line head / tail shortcuts
alias -g H='| head' # Pipes output to head (the first part of a file)
alias -g T='| tail' # Pipes output to tail (the last part of a file)
alias -g G='| grep' # Pipes output to grep to search for some word
alias -g L="| less" # Pipes output to less, useful for paging
alias -g LL="2>&1 | less" # Writes stderr to stdout and passes it to less
alias -g CA="2>&1 | cat -A" # Writes stderr to stdout and passes it to cat
alias -g NE="2> /dev/null" # Silences stderr
alias -g NUL="> /dev/null 2>&1" # Silences both stdout and stderr

# Use color diff, if availible
if command_exists colordiff ; then
  alias diff='colordiff'
fi

# Find + manage aliases
alias al='alias | less' # List all aliases
alias as='alias | grep' # Search aliases
alias ar='unalias' # Remove given alias

# System Monitoring
if [[ "$OSTYPE" == darwin* ]]; then
  alias meminfo='top -l 1 -s 0 | grep PhysMem' # Show free and used memory
  alias memhog='ps -Ao pid,ppid,%mem,comm -m | head' # Processes consuming most mem
  alias cpuhog='ps -Ao pid,ppid,%cpu,comm -r | head' # Processes consuming most cpu
  alias cpuinfo='sysctl -n machdep.cpu.brand_string' # Show CPU Info
  alias distro='sw_vers' # Show OS info
  alias ports='lsof -iTCP -sTCP:LISTEN -nP' # Show listening ports (prefix with sudo for all users)
else
  alias meminfo='free -h' # Show free and used memory
  alias memhog='ps -eo pid,ppid,%mem,comm --sort=-%mem | head' # Processes consuming most mem
  alias cpuhog='ps -eo pid,ppid,%cpu,comm --sort=-%cpu | head' # Processes consuming most cpu
  alias cpuinfo="grep -m1 'model name' /proc/cpuinfo | cut -d: -f2-" # Show CPU Info
  alias distro='cat /etc/os-release' # Show OS info
  alias ports='ss -tlnp' # Show listening ports (prefix with sudo for all users)
fi

# Copy / pasting (pbcopy on macOS, wl-copy on Wayland, xclip on X11)
if [[ "$OSTYPE" == darwin* ]]; then
  alias clipcopy='pbcopy' clippaste='pbpaste'
elif [[ -n "$WAYLAND_DISPLAY" ]]; then
  alias clipcopy='wl-copy' clippaste='wl-paste'
else
  alias clipcopy='xclip -selection clipboard' clippaste='xclip -selection clipboard -o'
fi
alias cpwd='pwd | clipcopy' # Copy current path
alias pa='clippaste' # Paste clipboard contents

# macOS-style 'open' on Linux
if [[ "$OSTYPE" == linux* ]] && ! command_exists open; then
  alias open='xdg-open'
fi

# App Specific
if command_exists code ; then; alias vsc='code .'; fi # Launch VS Code in current dir
if command_exists cointop ; then; alias crypto='cointop'; fi
if command_exists gotop ; then; alias gto='gotop'; fi
if command_exists lazygit ; then; alias lg='lazygit'; fi # Launch lazygit
if command_exists dive ; then; alias dv='dive'; fi # Launch dive (Docker image analysis)
if command_exists btop ; then; alias bt='btop'; fi # Launch btop (system monitor)
if command_exists glow ; then; alias md='glow -p'; fi # Render markdown with glow

# External Services
alias myip='curl icanhazip.com'
alias weather='curl wttr.in'
alias weather-short='curl "wttr.in?format=3"'
alias cheat='curl cheat.sh/'
alias tinyurl='curl -s "http://tinyurl.com/api-create.php?url='
alias joke='curl https://icanhazdadjoke.com'
alias hackernews='curl hkkr.in'
alias worldinternet='curl https://status.plaintext.sh/t'

# Random lolz
alias cls='clear;ls' # Clear and ls
alias plz="fc -l -1 | cut -d' ' -f2- | xargs sudo" # Re-run last cmd as root
alias yolo='git add .; git commit -m "YOLO"; git push'
alias when='date' # Show date
alias whereami='pwd'
alias cat='bat'
alias gtfo='exit'

# Jump to the dotfiles repo
alias dots='cd ~/.dotfiles'
