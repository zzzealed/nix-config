{ inputs, pkgs, ... }:
{
  # Nix modules
  imports = [
    # Stack
    ../../modules/limine # Bootloader
    ../../modules/limine/windows-dualboot.nix
    ../../modules/ly # Display manager
    ../../modules/niri # Compositor
    ../../modules/pipewire # Audio
    ../../modules/networkmanager # Network
    # Everything else
    ../../modules/yt-dlp.nix
    ../../modules/libreoffice.nix
    ../../modules/legcord.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/fish
    ../../modules/nh
    ../../modules/rclone
    ../../modules/steam
    ../../modules/obs-studio
    ../../modules/localsend
    ../../modules/tidal
    ../../modules/adb
    ../../modules/git
    ../../modules/wine
    ../../modules/bluetooth
    ../../modules/wooting
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
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
    ../../modules/prismlauncher
    ../../modules/ungoogled-chromium.nix
    ../../modules/python3.nix
    ../../modules/streamlink.nix
    ../../modules/ghostty
    #../../modules/virt-manager
    #../../modules/mysql
    #../../modules/locale/espanol.nix
    ../../modules/earlyoom
  ];

  # Home manager modules
  home-manager.users.mads = {
    home.file.".config/mpv/host.conf".source = ../../modules/mpv/config/desktop.conf;
    imports = [
      # Stack
      ../../modules/waybar/home.nix # Bar
      ../../modules/fuzzel/home.nix # Launcher
      ../../modules/dunst/home.nix # Notifications
      ../../modules/swaylock/home.nix # Lock screen
      ../../modules/wpaperd/home.nix # Wallpaper
      # Everything else
      ../../modules/bat/home.nix
      ../../modules/lan-mouse/home.nix
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
    kdePackages.xdg-desktop-portal-kde
    krita
    kdePackages.kdenlive
    rpcs3
    unstable.ryubing
    gparted
    hakuneko
    calibre
    unstable.servo
    unstable.thunderbird
    lm_sensors
    espeak
    hollywood
    usbutils
    wlsunset
  ];

  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Secondary SSD
  fileSystems."/mnt/Samsung" = {
    device = "/dev/disk/by-uuid/EEA23721A236EE29";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" ];
  };

  # GPU
  #services.xserver.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  hardware.nvidia.open = true;

  # Random
  powerManagement.cpuFreqGovernor = "performance";
  boot.kernelParams = [ "nvidia.NVreg_EnableMSI=0" ];
  services.gvfs.enable = true;
  time.hardwareClockInLocalTime = true; # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#System_time

  # Networking
  networking.firewall = { allowedTCPPorts = [ 8000 ]; allowedUDPPorts = [ 8000 ]; }; # For dev stuff

  # State
  system.stateVersion = "24.11";
}
