{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  wallpapers = import ../../modules/stylix/wallpapers.nix pkgs;
in
{
  system.extraDependencies = lib.collect lib.isDerivation wallpapers ++ [
    inputs.rotte-city
    inputs.zzzealed-com
  ];

  # Nix modules
  imports = [
    ../../modules/yt-dlp.nix
    ../../modules/users
    ../../modules/users/groups.nix
    ../../modules/users/mads.nix
    ../../modules/users/linus.nix
    ../../modules/cli-tools
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/nvidia
    ../../modules/networking/firewall.nix
    ../../modules/networking/networkmanager.nix
    ../../modules/networking/nameservers.nix
    ../../modules/locale
    ../../modules/bash
    ../../modules/ungoogled-chromium.nix
    ../../modules/python3.nix
    ../../modules/nh
    ../../modules/pipewire
    ../../modules/rclone
    ../../modules/thermald
    ../../modules/zfs
    ../../modules/zfs/vault-pool.nix
    ../../modules/nix-gc
    ../../modules/nix-optimise
    ../../modules/zmx
    ../../modules/nix-index-database
    # Services
    ../../modules/wireguard
    ../../modules/wireguard/server.nix
    ../../modules/changedetection-io
    ../../modules/openssh
    ../../modules/scrutiny
    ../../modules/vaultwarden
    ../../modules/radicale
    ../../modules/samba-shares
    ../../modules/samba-shares/vault-share.nix
    ../../modules/samba-shares/home-share.nix
    ../../modules/samba-shares/qbittorrent-share.nix
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
    ../../modules/ddclient/server.nix
    ../../modules/forgejo
    ../../modules/endlessh
    ../../modules/teapot
    ../../modules/harmonia
    ../../modules/github-runners
    ../../modules/redlib
    ../../modules/pr-tracker
    ../../modules/pr-tracker/git.nix
    ../../modules/ollama
    ../../modules/ntfy-sh
    ../../modules/gatus
    ../../modules/gatus/gatus-local.nix
    ../../modules/qbittorrent
    ../../modules/fail2ban
    ../../modules/authelia
    ../../modules/teamspeak/server.nix
    # ../../modules/renovate/default.nix
    ../../modules/actual
    ../../modules/home-assistant/proxy.nix
    ## Compose2Nix
    ../../modules/gpt4free_docker
    ../../modules/chrome_docker
  ];

  home-manager.users.mads.imports = [
    ../../modules/git/home.nix
    ../../modules/helix/home.nix
    ../../modules/navi/home.nix
    ../../modules/btop/home.nix
    ../../modules/mpv/home.nix
    ../../modules/openssh/home.nix
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    dig
    unstable.kcc
  ];

  # Use proprietary drivers
  hardware.nvidia.open = false;
  nixpkgs.config.cudaSupport = true;

  # shit11
  #services.xserver.enable = true;

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/ata-Samsung_SSD_870_QVO_1TB_S5RRNF0W804580E";
  boot.kernelModules = [ "nvidia-uvm" ];

  # Build
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  age.secrets."nix_builder_key".file = ../../secrets/nix_builder_key.age;
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "nixremote@pi.internal:2267";
        sshKey = config.age.secrets."nix_builder_key".path;
        protocol = "ssh-ng";
        systems = [ "aarch64-linux" ];
        maxJobs = 1;
        speedFactor = 2;
        supportedFeatures = [ ];
        publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUJ6WE5iU0Z6RWpuUVMrOEQzZ3VWdjFVZWRDMkU5RUswTVpMYUJEWE1lK2Mgcm9vdEBleGFtcGxlCg==";
      }
    ];
  };

  # Networking
  nameserver.primary = "127.0.0.1"; # Override for this host
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # State
  system.stateVersion = "24.05";
}
