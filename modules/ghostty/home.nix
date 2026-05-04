{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
    enableBashIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    systemd.enable = true;
    settings = {
      font-feature = [
        "-calt"
        "-liga"
        "-dlig"
      ];
      font-size = 16;
      command = "fish --init-command 'zmx list'";
      initial-command = "zmx attach 1 fish";
      notify-on-command-finish = "always";
      notify-on-command-finish-action = [
        "bell"
        "notify"
      ];
      notify-on-command-finish-after = "15s";
      working-directory = "inherit";
      keybind = [
        "ctrl+k=scroll_page_lines:-1"
        "ctrl+j=scroll_page_lines:1"
      ];
      window-inherit-working-directory = true;
      copy-on-select = false;
      quit-after-last-window-closed = false;
      shell-integration-features = true;
      bell-features = [
        "system"
        "attention"
      ];
    };
  };
}
