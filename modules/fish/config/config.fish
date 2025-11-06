# Aliases
alias cat bat
alias cp "uutils-cp --verbose --interactive --progress"
alias du dust
alias grep rg
alias ls "ls --color=always --indicator-style=slash"
alias mv "uutils-mv --verbose --interactive --progress"
alias rm "rm --verbose --interactive=once"
alias btm "btm --enable_gpu"
alias find fd
alias fzf sk
alias vid_length "bash /home/mads/nix-config/modules/bash/config/list_vid_length.sh"

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
