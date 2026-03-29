{ pkgs, ... }:
{
  # Nix modules
  imports = [
    ../../modules/yt-dlp.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/git
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
    ../../modules/nvidia
    ../../modules/networkmanager
    ../../modules/locale
    ../../modules/bash
    ../../modules/ungoogled-chromium
    ../../modules/python3.nix
    ../../modules/nh
    #../../modules/prismlauncher
    # Services
    ../../modules/home-assistant
    #../../modules/wg-quick
    ../../modules/changedetection-io
    ../../modules/openssh
    ../../modules/open-webui
    ../../modules/scrutiny
    ../../modules/calibre-web
    ../../modules/vaultwarden
    ../../modules/radicale
    ../../modules/samba-shares
    ../../modules/n8n
    ../../modules/pihole
    ../../modules/unbound
    ../../modules/podman
    #../../modules/docker
    ../../modules/searx
    ../../modules/glance
    ../../modules/karakeep
    ../../modules/rust-gameserver
    ../../modules/nginx
    ../../modules/nginx/zzzealed.com.nix
    ../../modules/nginx/rotte.city.nix
    ../../modules/minecraft-server
    ../../modules/rclone
    ../../modules/rclone/mnt-hbd.nix
    ../../modules/pipewire
    ../../modules/ddclient
    ## Compose2Nix
    ../../modules/gpt4free_docker
    ../../modules/chrome_docker
  ];

  home-manager.users.mads = {
    imports = [
      ../../modules/git/home.nix
      ../../modules/helix/home.nix
      ../../modules/navi/home.nix
      ../../modules/btop/home.nix
      ../../modules/mpv/home.nix
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    zfs
    dig
    screen
    unstable.kcc
  ];

  # Use proprietary drivers
  hardware.nvidia.open = false;

  # shit11
  #services.xserver.enable = true;

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sde";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false; # Import with `sudo zpool import (-l) vault`
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # ZFS
  services.zfs.autoSnapshot = {
    enable = true;
    weekly = 2;
  };
  
  # Networking
  networking.hostId = "3f39026e";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;
  networking.firewall = { allowedTCPPorts = [ 8000 ]; allowedUDPPorts = [ 8000 ]; }; # For dev stuff

  # State
  system.stateVersion = "24.05";
}
