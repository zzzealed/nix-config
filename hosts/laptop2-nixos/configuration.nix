{ inputs, pkgs, ... }:
{
  # Nix modules
  imports = [
    ../../modules/yt-dlp.nix
    ../../modules/users/mads.nix
    ../../modules/fish
    ../../modules/mpv
    ../../modules/ly
    ../../modules/niri
    ../../modules/nh
    ../../modules/firefox
    ../../modules/systemd-boot
    ../../modules/rclone
    ../../modules/ghostty
    ../../modules/localsend
    ../../modules/tidal
    ../../modules/git
    ../../modules/bluetooth
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
    ../../modules/pipewire
    ../../modules/bat
    ../../modules/samba-mounts
    ../../modules/openssh
    ../../modules/glide-browser
    ../../modules/locale
    ../../modules/stylix
    ../../modules/navi
    ../../modules/bash
    #../../modules/wg-quick
    ../../modules/networkmanager
    ../../modules/fuzzel
    ../../modules/swaynotificationcenter
    ../../modules/swaylock
    ../../modules/wpaperd
    ../../modules/streamlink.nix
  ];

  # Home manager modules
  home-manager.users.mads = {
    imports = [
      #./mpv/home.nix
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    gparted
  ];

  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # GPU
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Networking
  networking.firewall = { allowedTCPPorts = [ 8000 ]; }; # For dev stuff

  # State
  system.stateVersion = "24.11";
}
