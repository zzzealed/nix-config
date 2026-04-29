# Aliases
alias cat bat
alias cp "uutils-cp --verbose --interactive --progress"
alias du dust
alias ls "ls --color=always --indicator-style=slash"
alias mv "uutils-mv --verbose --interactive --progress"
#alias rm "rm --verbose --interactive=once"
alias rm "echo use Gomi!"
alias gomi "gomi --verbose"
alias rsync "rsync --verbose --archive --progress --human-readable"

# Rebuild alias
function rbld-desktop
    command nh os $argv /home/mads/nix-config --ask
end
function rbld-server
    command ssh mads@server.l.zzzealed.com "nh os $argv git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#server-nixos --ask"
end
function rbld-pi
    command ssh mads@server.l.zzzealed.com "nh os $argv git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#pi-nixos --ask --target-host mads@pi.l.zzzealed.com"
end
function rbld-vps
    command ssh mads@server.l.zzzealed.com "nh os $argv git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#vps-nixos --ask --target-host mads@vps.rotte.city"
end

# Duration alias
# TIP: use like `duration *.mkv */*.mkv | sort -V`
function duration
    for f in $argv
        printf "%s - %s\n" \
            (ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 -sexagesimal "$f") \
            (path basename "$f")
    end
end

# Bangers alias
function bangers
    command mpv /mnt/vault/Videos/Memes/bangers.m3u8 --directory-mode=ignore
end

# Interactive shell initialisation
set fish_greeting # Disable greeting

# Vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Set $EDITOR
set -gx EDITOR hx

# Send desktop-noti if command longer than 10s
#function notify_long_tasks --on-event fish_postexec
#    if [ "$CMD_DURATION" -gt 10000 ] # 10 seconds
#        notify-send --app-name=Ghostty --icon=com.mitchellh.ghostty --expire-time=1000 "Command finished" $argv
#    end
#end
