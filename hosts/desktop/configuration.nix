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
    ../../modules/networkmanager/server-dns.nix
    # Everything else
    ../../modules/yt-dlp.nix
    ../../modules/libreoffice.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/fish
    ../../modules/nh
    ../../modules/rclone
    ../../modules/rclone/mnt-hbd.nix
    ../../modules/steam
    ../../modules/obs-studio
    ../../modules/localsend
    ../../modules/tidal
    ../../modules/adb
    ../../modules/git
    ../../modules/wine
    ../../modules/bluetooth
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/nvidia
    ../../modules/bitwarden
    ../../modules/samba-mounts/vault-mount.nix
    ../../modules/samba-mounts/vault2-mount.nix
    ../../modules/samba-mounts/home-mount.nix
    ../../modules/openssh
    ../../modules/locale
    ../../modules/stylix
    ../../modules/navi
    ../../modules/bash
    ../../modules/wg-quick
    ../../modules/wg-quick/wg_hbd-1.nix
    ../../modules/wg-quick/wg_pi-nixos-3.nix
    ../../modules/prismlauncher
    ../../modules/ungoogled-chromium.nix
    ../../modules/python3.nix
    ../../modules/streamlink.nix
    #../../modules/virt-manager
    ../../modules/mysql
    #../../modules/locale/espanol.nix
    ../../modules/earlyoom
    ../../modules/thermald
    ../../modules/yubikey
    ../../modules/xdg-portal
    ../../modules/tokei.nix
    ../../modules/tealdeer.nix
    ../../modules/nix-gc
    ../../modules/zmx
    ../../modules/nix-index-database
  ];

  # Home manager modules
  home-manager.users.mads = {
    home.file.".config/mpv/host.conf".source = ../../modules/mpv/config/desktop-nixos.conf;
    imports = [
      # Stack
      ../../modules/waybar/home.nix # Bar
      #../../modules/ashell/home.nix
      ../../modules/fuzzel/home.nix # Launcher
      ../../modules/dunst/home.nix # Notifications
      ../../modules/swaylock/home.nix # Lock screen
      ../../modules/wpaperd/home.nix # Wallpaper
      ../../modules/ghostty/home.nix # Terminal
      ../../modules/fish/home.nix # Shell
      # Everything else
      ../../modules/bat/home.nix
      ../../modules/glide-browser/home.nix
      ../../modules/mpv/home.nix
      ../../modules/git/home.nix
      ../../modules/helix/home.nix
      ../../modules/navi/home.nix
      ../../modules/niri/home.nix
      ../../modules/stylix/home.nix
      ../../modules/btop/home.nix
      ../../modules/legcord/home.nix
      ../../modules/yazi/home.nix
      ../../modules/opencode/home.nix
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    ntfs3g
    kdePackages.dolphin
    krita
    kdePackages.kdenlive
    rpcs3
    unstable.ryubing
    gparted
    calibre
    unstable.servo
    unstable.thunderbird
    lm_sensors
    espeak
    hollywood
    usbutils
    llm
    wooting-udev-rules
  ];

  # xdg.mime
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.kde.dolphin.desktop";
      "text/html" = "glide-browser.desktop";
      "x-scheme-handler/http" = "glide-browser.desktop";
      "x-scheme-handler/https" = "glide-browser.desktop";
      "x-scheme-handler/about" = "glide-browser.desktop";
      "image/jpeg" = "mpv.desktop";
      "image/png" = "mpv.desktop";
      "image/gif" = "mpv.desktop";
      "image/webp" = "mpv.desktop";
      "image/svg+xml" = "mpv.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mkv" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/avi" = "mpv.desktop";
      "video/mov" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
    };
  };

  # Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Secondary SSD
  fileSystems."/mnt/Samsung" = {
    device = "/dev/disk/by-uuid/EEA23721A236EE29";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
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
  services.fstrim.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  # Networking
  networking.firewall = {
    allowedTCPPorts = [ 8000 ];
    allowedUDPPorts = [ 8000 ];
  }; # For dev stuff

  # State
  system.stateVersion = "24.11";
}
