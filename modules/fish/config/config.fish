# Interactive shell initialisation
set fish_greeting # Disable greeting

# Vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Set $EDITOR
set -gx EDITOR hx

# Custom alias function
function als # Custom alias function
    echo "\$ $argv"
    command $argv
end

# Aliases
## Rebuild
function rbld
    als nh os $argv[1] $HOME/nix-config#$argv[2] $argv[3..]
end
function rbld-desktop
    als ssh -tA mads@server.l.zzzealed.com "nh os $argv[1] git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#desktop-nixos --ask --target-host mads@desktop.l.zzzealed.com" $argv[2..]
end
function rbld-server
    als ssh -tA mads@server.l.zzzealed.com "nh os $argv[1] git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#server-nixos --ask" $argv[2..]
end
function rbld-pi
    als ssh -tA mads@server.l.zzzealed.com "nh os $argv[1] git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#pi-nixos --ask --target-host mads@pi.l.zzzealed.com" $argv[2..]
end
function rbld-vps
    als ssh -tA mads@server.l.zzzealed.com "nh os $argv[1] git+ssh://mads@desktop.l.zzzealed.com/home/mads/nix-config#vps-nixos --ask --target-host mads@vps.rotte.city" $argv[2..]
end

## Misc.
function cat
    als bat $argv
end
function cp
    als uutils-cp --verbose --interactive --progress $argv
end
function du
    als dust $argv
end
function ls
    als ls --color=always --indicator-style=slash $argv
end
function mv
    als uutils-mv --verbose --interactive --progress $argv
end
#function rm
#    als rm --verbose --interactive=once
#end
function rm
    als echo use Gomi!
end
function gomi
    als gomi --verbose $argv
end
function rsync
    als rsync --verbose --archive --progress --human-readable $argv
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
