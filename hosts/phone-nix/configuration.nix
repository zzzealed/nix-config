{ pkgs, ... }:
{
  # Nix modules
  imports = [
    ../../modules/yt-dlp.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/fish
    ../../modules/rclone
    ../../modules/git
    ../../modules/home-manager
    ../../modules/ffmpeg
    ../../modules/helix
    ../../modules/bat
    ../../modules/openssh
    ../../modules/locale
    ../../modules/stylix
    ../../modules/navi
  ];

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
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  # Networking
  networking.firewall = { allowedTCPPorts = [ 8080 ]; allowedUDPPorts = [ 8080 ]; }; # For dev stuff

  # State
  system.stateVersion = "24.11";
}
