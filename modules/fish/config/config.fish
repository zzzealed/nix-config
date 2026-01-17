# Aliases
alias cat bat
alias cp "uutils-cp --verbose --interactive --progress"
alias du dust
alias grep rg
alias ls "ls --color=always --indicator-style=slash"
alias mv "uutils-mv --verbose --interactive --progress"
alias rm "rm --verbose --interactive=once"
alias find fd
alias fzf sk
alias vid_length "bash /mnt/vault/Documents/nix-config/modules/bash/config/list_vid_length.sh"
alias rsync "rsync --verbose --archive --progress --human-readable"

# Rebuild alias
function rbld-desktop
    command ssh -A -t mads@server.l.zzzealed.com "nh os $argv /vault/Documents/nix-config --hostname desktop-nixos --target-host mads@desktop.l.zzzealed.com --cores 10 --max-jobs 10 --ask"
end

function rbld-server
    command ssh -A -t mads@server.l.zzzealed.com "nh os $argv /vault/Documents/nix-config --hostname server-nixos --cores 10 --max-jobs 10 --ask"
end

function rbld-pi
    command ssh -A -t mads@server.l.zzzealed.com "nh os $argv /vault/Documents/nix-config --hostname pi-nixos --target-host mads@pi.l.zzzealed.com --cores 10 --max-jobs 10 --ask"
end

# Interactive shell initialisation
set fish_greeting # Disable greeting

# Vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Set $EDITOR
set -gx EDITOR hx

# Send desktop-noti if command longer than 10s
function notify_long_tasks --on-event fish_postexec
    if [ "$CMD_DURATION" -gt 10000 ] # 10 seconds
        notify-send --app-name=Ghostty --icon=com.mitchellh.ghostty --expire-time=1000 "Command finished" $argv
    end
end
