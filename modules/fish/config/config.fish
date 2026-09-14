# Interactive shell initialisation
set fish_greeting # Disable greeting

# Helix mode ah ah ahhhh
set -g fish_key_bindings fish_helix_key_bindings

# Set $EDITOR
set -gx EDITOR hx

# ZMX autoattach
if status is-interactive; and type -q zmx; and test -z "$ZMX_SESSION"
    set name (if type -q petname; petname -w 2; else; __zmx_next_session_name; end)
    env ZMX_SESSION_PREFIX=$name SHELL=fish zmx a
end

# https://zmx.sh/#fish
functions -c fish_prompt _original_fish_prompt 2>/dev/null

function fish_prompt --description 'Write out the prompt'
    if set -q ZMX_SESSION
        echo -n "[$ZMX_SESSION] "
    end
    _original_fish_prompt
end

# Aliases
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
    command echo "use `gomi`!"
end
function gomi
    command gomi --verbose $argv
end
function rsync
    command rsync --verbose --archive --progress --human-readable $argv
end

# NOTE: use like `duration *.mkv */*.mkv | sort -V`
function duration
    for f in $argv
        printf "%s - %s\n" \
            (ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 -sexagesimal "$f") \
            (path basename "$f")
    end
end
function hash_url
    command nix-prefetch-url $argv | xargs nix hash convert --hash-algo sha256
end
