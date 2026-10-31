{ ... }:
{
  programs.bash = {
    interactiveShellInit = "set -o vi";
    shellAliases = {
      "rsync" = "rsync --verbose --archive --progress --human-readable";
    };
  };
}
