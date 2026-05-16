{ pkgs, ... }:
{
  # Nix modules
  imports = [
    ../../modules/yt-dlp.nix
    ../../modules/users
    ../../modules/users/groups.nix
    ../../modules/users/mads.nix
    ../../modules/users/linus.nix
    ../../modules/cli-tools
    ../../modules/git
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/nvidia
    ../../modules/networkmanager
    ../../modules/networkmanager/local-dns.nix
    ../../modules/locale
    ../../modules/bash
    ../../modules/ungoogled-chromium.nix
    ../../modules/python3.nix
    ../../modules/nh
    ../../modules/pipewire
    ../../modules/rclone
    ../../modules/rclone/mnt-hbd.nix
    ../../modules/thermald
    ../../modules/zfs
    ../../modules/zfs/vault-pool.nix
    ../../modules/nix-gc
    ../../modules/nix-optimise
    ../../modules/zmx
    ../../modules/nix-index-database
    # Services
    ../../modules/home-assistant
    ../../modules/wg-quick
    ../../modules/wg-quick/wg_hbd-2.nix
    ../../modules/changedetection-io
    ../../modules/openssh
    ../../modules/scrutiny
    ../../modules/vaultwarden
    ../../modules/radicale
    ../../modules/samba-shares
    ../../modules/samba-shares/vault-share.nix
    ../../modules/samba-shares/home-share.nix
    ../../modules/pihole
    ../../modules/unbound
    ../../modules/searx
    ../../modules/glance
    ../../modules/karakeep
    ../../modules/rust-gameserver
    ../../modules/nginx
    ../../modules/nginx/zzzealed.com.nix
    ../../modules/minecraft-server
    ../../modules/minecraft-server/mads-sp.nix
    ../../modules/minecraft-server/mads-sp-skyblock.nix
    ../../modules/ddclient
    ../../modules/ddclient/home.zzzealed.com.nix
    ../../modules/forgejo
    ../../modules/endlessh
    ../../modules/teapot
    ../../modules/harmonia
    ../../modules/github-runners
    ../../modules/redlib
    #../../modules/speedtest-tracker # FIXME: uncomment once added to nixpkgs-25.11
    ../../modules/pr-tracker
    ../../modules/pr-tracker/git.nix
    ../../modules/ollama
    ../../modules/ntfy-sh
    ../../modules/gatus
    ../../modules/gatus/gatus-local.nix
    ../../modules/qbittorrent
    ../../modules/fail2ban
    ../../modules/authelia
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
    dig
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
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Networking
  networking.hostId = "3f39026e";
  networking.interfaces.enp3s0.wakeOnLan.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 8000 ];
    allowedUDPPorts = [ 8000 ];
  }; # For dev stuff

  # State
  system.stateVersion = "24.05";
}
