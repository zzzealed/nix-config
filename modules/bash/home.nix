{ ... }:
{
  programs.bash = {
    enable = true;
    initExtra = "set -o vi";
    shellAliases = {
      "nod" = "nix-on-droid switch --flake .#phone-droid";
      "rsync" = "rsync --verbose --archive --progress --human-readable";
    };
  };
}
