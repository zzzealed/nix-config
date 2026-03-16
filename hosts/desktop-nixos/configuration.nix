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
    ../../modules/obs-studio
    ../../modules/localsend
    ../../modules/tidal
    ../../modules/adb
    ../../modules/git
    #../../modules/polkit
    ../../modules/wine
    ../../modules/bluetooth
    ../../modules/wooting
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
    ../../modules/pipewire
    ../../modules/nvidia
    ../../modules/bitwarden
    ../../modules/samba-mounts
    ../../modules/openssh
    ../../modules/locale
    ../../modules/stylix
    ../../modules/navi
    ../../modules/bash
    ../../modules/wg-quick/wg_hbd-1.nix
    ../../modules/qbittorrent
    ../../modules/networkmanager
    ../../modules/prismlauncher
    ../../modules/ungoogled-chromium
    ../../modules/python3.nix
    ../../modules/streamlink.nix
    ../../modules/ghostty
    ../../modules/virt-manager
    #../../modules/mysql
    ../../modules/locale/espanol.nix
    ../../modules/earlyoom
  ];

  # Home manager modules
  home-manager.users.mads = {
    imports = [
      ./mpv/home.nix
      ../../modules/fuzzel/home.nix
      ../../modules/bat/home.nix
      ../../modules/swaynotificationcenter/home.nix
      ../../modules/swaylock/home.nix
      ../../modules/wpaperd/home.nix
      ../../modules/lan-mouse/home.nix
      ../../modules/waybar/home.nix
      ../../modules/glide-browser/home.nix
      ../../modules/fish/home.nix
      ../../modules/mpv/home.nix
      ../../modules/ghostty/home.nix
      ../../modules/git/home.nix
      ../../modules/helix/home.nix
      ../../modules/navi/home.nix
      ../../modules/niri/home.nix
      ../../modules/stylix/home.nix
      ../../modules/btop/home.nix
      #../../modules/steam/home.nix
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    scrcpy
    ntfs3g
    kdePackages.dolphin
    krita
    kdePackages.kdenlive
    rpcs3
    unstable.ryubing
    gparted
    hakuneko
    unstable.kcc
    calibre
    unstable.servo
    unstable.thunderbird
    lm_sensors
    espeak
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
  #services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  hardware.nvidia.open = true;

  powerManagement.cpuFreqGovernor = "performance";

  boot.kernelParams = [ "nvidia.NVreg_EnableMSI=0" ];

  #chaotic.mesa-git.enable = true;

  # Networking
  networking.firewall = { allowedTCPPorts = [ 8000 ]; allowedUDPPorts = [ 8000 ]; }; # For dev stuff

  # State
  system.stateVersion = "24.11";
}
