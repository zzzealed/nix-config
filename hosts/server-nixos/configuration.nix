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
    ../../modules/bat
    ../../modules/nvidia
    ../../modules/networkmanager
    ../../modules/locale
    ../../modules/stylix
    ../../modules/bash
    ../../modules/ungoogled-chromium
    ../../modules/python3.nix
    # Services
    ../../modules/home-assistant
    #../../modules/wg-quick
    ../../modules/changedetection-io
    ../../modules/openssh
    ../../modules/open-webui
    ../../modules/scrutiny
    ../../modules/calibre-web
    ../../modules/vaultwarden
    #../../modules/radicale
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
    ../../modules/minecraft-server
    ../../modules/rclone
    ../../modules/rclone/hbd.nix
    ../../modules/pipewire
    #../../modules/nitter
    ## Compose2Nix
    ../../modules/gpt4free_docker/docker-compose.nix
    ../../modules/chrome_docker/docker-compose.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    zfs
    dig
    screen
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sde";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false; # Import with `sudo zpool import (-l) vault`
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # shit11
  services.xserver.enable = true;

  # ZFS
  services.sanoid.datasets."vault".daily = 1; # Snapshot "vault" once a day
  services.sanoid.datasets."vault2".daily = 1; # Snapshot "vault2" once a day

  # Networking
  networking.hostId = "3f39026e";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # State
  system.stateVersion = "24.05";
}
