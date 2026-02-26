#!/usr/bin/env zsh

# Configure completion cache.
zstyle ':completion::complete:*'    use-cache           yes                               # Enable cache for completions.
zstyle ':completion::complete:*'    cache-path          "${ZDOTDIR:-$HOME}/.zcompcache" # Configure completion cache path.

# Configure matches and grouping in completion menu.
zstyle ':completion:*'              matcher-list        'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # Enable case insensitive completion.
zstyle ':completion:*:*:*:*:*'      menu                select                                      # Enable highlighting in menu.
zstyle ':completion:*:options'      auto-description    '%d'
zstyle ':completion:*:options'      description         yes
zstyle ':completion:*:matches'      group               yes                                         # Separate matches in menu into groups.
zstyle ':completion:*'              group-name          ''                                          # Separate matches in menu into groups.

# Format group matches in completion menu.
#zstyle ':completion:*:descriptions' format              '%F{yellow}-- %d --%f'             # Comment when using fzf-tab plugin. For more information,
zstyle ':completion:*:descriptions' format              '[%d]'                              # see https://github.com/Aloxaf/fzf-tab/issues/43.
zstyle ':completion:*:corrections'  format              '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages'     format              '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings'     format              '%F{red}-- no matches found --%f'

# Configure completion of directories.
zstyle ':completion:*'              list-colors         ${(s.:.)LS_COLORS}  # Enable $LS_COLORS for directories in completion menu.
zstyle ':completion:*'              special-dirs        yes                 # Enable completion menu of ./ and ../ special directories.

# Configure completion of 'kill' command.
zstyle ':completion:*:*:*:*:processes'      command             'ps -u $USER -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes'   list-colors         '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:kill:*'             menu                yes select
zstyle ':completion:*:*:kill:*'             force-list          always
zstyle ':completion:*:*:kill:*'             insert-ids          single

# Configure completion of 'man' command.
zstyle ':completion:*:man:*'                menu                yes select
zstyle ':completion:*:manuals'              separate-sections   yes
zstyle ':completion:*:manuals.*'            insert-sections     yes

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' \
    hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Instantly filter out any non-existent directories from fpath
fpath=($^fpath(N-/))

# Initialize completion
autoload -Uz compinit

# Enable extended globbing for the time check.
setopt extendedglob

# Location for completions
# Note: We must ensure the zsh cache directory actually exists first, or compinit will silently fail.
zcompdir="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh"
[[ -d "$zcompdir" ]] || mkdir -p "$zcompdir"
zcompdump="${zcompdir}/.zcompdump"

# Check if the cache file exists and is older than 24 hours
if [[ -n "$zcompdump"(#qN.mh+24) ]]; then
    # It is older than 24h (or missing). Run the full audit and rebuild cache.
    compinit -d "$zcompdump"
    touch "$zcompdump"
else
    # It is fresh. Bypass the slow audit (-C) for instant loading.
    compinit -C -d "$zcompdump"
fi

# Compile the compdump file to .zwc if it's newer than the compiled version.
# By adding `&!` at the end, we push this compilation to a background process 
# so it doesn't block your terminal prompt from appearing!
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump" &!
fi

# Disable extended globbing so that ^ will behave as normal.
unsetopt extendedglob

# Disable eza completion (not available for zsh, causes errors)
compdef -d eza