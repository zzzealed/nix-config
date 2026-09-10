{ ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
       nod() {
        nix-on-droid "$@" --flake /sdcard/Documents/nix-config/.#phone
      }
    '';
    shellAliases = {
      "rsync" = "rsync --verbose --archive --progress --human-readable";
    };
  };
}
