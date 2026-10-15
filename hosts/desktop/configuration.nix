{ pkgs, ... }:
{
  wsl.defaultUser = "mads";

  imports = [
    ../../modules/users
    ../../modules/users/mads.nix
    ../../modules/fish
    ../../modules/nh
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/openssh
    ../../modules/locale
    ../../modules/navi
    ../../modules/mysql
    ../../modules/nix-gc
    ../../modules/zmx
    ../../modules/nix-index-database
  ];

  # Home manager modules
  home-manager.users.mads = {
    home.file = {
      ".config/mpv/host.conf".source = ../../modules/mpv/config/desktop.conf;
    };
    imports = [
      ../../modules/fish/home.nix # Shell
      ../../modules/openssh/home.nix
      ../../modules/mpv/home.nix
      ../../modules/git/home.nix
      ../../modules/helix/home.nix
      ../../modules/navi/home.nix
      ../../modules/legcord/home.nix
      ../../modules/yazi/home.nix
      ../../modules/opencode/home.nix
      ../../modules/gpg/home.nix
      ../../modules/yt-dlp/home.nix
      ../../modules/bash/home.nix
    ];
  };

  # Packages
  environment.systemPackages =
    (import ../../modules/cli-tools { inherit pkgs; }).packages
    ++ (with pkgs; [
      unstable.servo
      hollywood
    ]);

  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # State
  system.stateVersion = "24.11";
}
