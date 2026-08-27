# Interactive shell initialisation
set fish_greeting # Disable greeting

# Vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Set $EDITOR
set -gx EDITOR hx

## Misc.
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
function za
    zmx a $argv fish
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
function hash_url
    command nix-prefetch-url $argv | xargs nix hash convert --hash-algo sha256
end
