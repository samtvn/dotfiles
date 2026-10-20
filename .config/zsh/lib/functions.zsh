#!/usr/bin/env zsh

# Extract archives
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7za x "$1" ;;
        esac
    fi
}

# Unlock Bitwarden
function bwu() {
    # Attempt to grab the session key from macOS Keychain
    export BW_SESSION=$(security find-generic-password -a $USER -s BW_SESSION -w 2>/dev/null)

    # Check if the Bitwarden vault is successfully unlocked
    if bw status | grep -q '"status":"unlocked"'; then
        echo "🔓 Bitwarden vault unlocked via Keychain!"
    else
        echo "🔒 Vault locked or session expired. Enter Master Password:"
        # Prompt for password and output raw session key
        export BW_SESSION=$(bw unlock --raw)

        # If unlocking was successful, update the Keychain
        if [ -n "$BW_SESSION" ]; then
            security add-generic-password -a $USER -s BW_SESSION -w "$BW_SESSION" -U
            echo "✅ Session key saved to macOS Keychain."
        fi
    fi
}
