{ ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      set -o vi
       nod() {
        nix-on-droid "$@" --flake /sdcard/nix-config/.#phone1
      }
      zmx ls
    '';
    shellAliases = {
      "rsync" = "rsync --verbose --archive --progress --human-readable";
    };
  };
}
