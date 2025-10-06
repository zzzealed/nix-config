{ pkgs, ... }:
{
  # Nix modules
  imports = [
    ../../secrets/default.nix
    ../../modules/yt-dlp.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/git
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
    ../../modules/bat
    ../../modules/nvidia
    # Services
    ../../modules/home-assistant
    ../../modules/wg-quick
    ../../modules/docker
    ../../modules/changedetection
    ../../modules/openssh
    ../../modules/open-webui
    ../../modules/scrutiny
    ../../modules/calibre-web
    ../../modules/vaultwarden
    ../../modules/radicale
    ../../modules/samba-shares
    ../../modules/n8n
    ## Compose2Nix
    ../../modules/gpt4free_docker/docker-compose.nix
    ../../modules/chrome_docker/docker-compose.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    zfs
    steamcmd
    steam-run
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sde";
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # ZFS
  services.sanoid.datasets."vault".daily = 1; # Snapshot "vault" once a day
  services.sanoid.datasets."vault2".daily = 1; # Snapshot "vault2" once a day

  # Networking
  networking.hostId = "3f39026e";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # State
  system.stateVersion = "24.05";
  home-manager.users.mads.stateVersion = "24.05";
}
