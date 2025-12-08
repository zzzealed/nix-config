{ inputs, pkgs, ... }:
{
  # Nix modules
  imports = [
    ../../modules/yt-dlp.nix
    ../../modules/libreoffice.nix
    ../../modules/legcord.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/fish
    ../../modules/mpv
    ../../modules/ly
    ../../modules/niri
    ../../modules/nh
    #../../modules/firefox
    ../../modules/systemd-boot
    ../../modules/rclone
    ../../modules/steam
    ../../modules/ghostty
    ../../modules/obs-studio
    ../../modules/localsend
    ../../modules/tidal
    ../../modules/adb
    ../../modules/git
    ../../modules/polkit
    ../../modules/wine
    ../../modules/bluetooth
    ../../modules/wooting
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
    ../../modules/pipewire
    ../../modules/bat
    ../../modules/nvidia
    ../../modules/bitwarden
    ../../modules/samba-mounts
    ../../modules/openssh
    ../../modules/glide-browser
    ../../modules/locale
    ../../modules/stylix
    ../../modules/navi
    ../../modules/bash
    #../../modules/wg-quick
    ../../modules/qbittorrent
    ../../modules/networkmanager
    ../../modules/prismlauncher
    ../../modules/ungoogled-chromium
    ../../modules/btop
    ../../modules/python3.nix
    inputs.chaotic.nixosModules.default
  ];

  # Home manager modules
  home-manager.users.mads = {
    imports = [
      ./mpv/home.nix
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    scrcpy
    ntfs3g
    kdePackages.dolphin
    krita
    rpcs3
    unstable.ryubing
    gparted
    hakuneko
    unstable.kcc
    calibre
    unstable.servo
  ];

  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Secondary SSD
  fileSystems."/mnt/Samsung" =
    { device = "/dev/disk/by-uuid/EEA23721A236EE29";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000"];
    };

  # GPU
  services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  hardware.graphics = {
    enable = true;
    package = pkgs.mesa;
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  #chaotic.mesa-git.enable = true;

  # Networking
  networking.firewall = { allowedTCPPorts = [ 8080 ]; allowedUDPPorts = [ 8080 ]; }; # For dev stuff

  # State
  system.stateVersion = "24.11";
}
