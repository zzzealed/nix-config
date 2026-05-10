# Interactive shell initialisation
set fish_greeting # Disable greeting

# Vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Set $EDITOR
set -gx EDITOR hx

# zmx
functions -c fish_prompt _original_fish_prompt 2>/dev/null

function fish_prompt --description 'Write out the prompt'
    if set -q ZMX_SESSION
        echo -n "[$ZMX_SESSION] "
    end
    _original_fish_prompt
end

# Aliases
## Rebuild
function rbld
    command nh os $argv[1] $HOME/nix-config#$argv[2] $argv[3..]
end
function _rbld
    set host $argv[1]
    command ssh -tA mads@server.l.zzzealed.com \
        "rsync --archive --info=progress2 --filter=':- .gitignore' mads@desktop.l.zzzealed.com:/home/mads/nix-config/ ~/nix-config/ && \
        nh os $argv[2] ~/nix-config#$host --ask $argv[3..]"
end
function rbld-desktop
    _rbld desktop-nixos $argv --target-host mads@desktop.l.zzzealed.com
end
function rbld-server
    _rbld server-nixos $argv
end
function rbld-pi
    _rbld pi-nixos $argv --target-host mads@pi.l.zzzealed.com
end
function rbld-vps
    _rbld vps-nixos $argv --target-host mads@vps.zzzealed.com
end

## Misc.
function cat
    command bat $argv
end
function cp
    command uutils-cp --verbose --interactive --progress $argv
end
function du
    command dust $argv
end
function ls
    command ls --color=always --indicator-style=slash $argv
end
function mv
    command uutils-mv --verbose --interactive --progress $argv
end
#function rm
#    command rm --verbose --interactive=once
#end
function rm
    command echo use Gomi!
end
function gomi
    command gomi --verbose $argv
end
function rsync
    command rsync --verbose --archive --progress --human-readable $argv
end

## Custom
# TIP: use like `duration *.mkv */*.mkv | sort -V`
function duration
    for f in $argv
        printf "%s - %s\n" \
            (ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 -sexagesimal "$f") \
            (path basename "$f")
    end
end
function bangers
    command mpv /mnt/vault/Videos/Memes/bangers.m3u8 --directory-mode=ignore
end
