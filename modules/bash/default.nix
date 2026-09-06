{ ... }:
{
  programs.bash = {
    interactiveShellInit = "set -o vi";
    shellAliases = {
      "nod" = "nix-on-droid"
      "rsync" = "rsync --verbose --archive --progress --human-readable";
    };
  };
}
