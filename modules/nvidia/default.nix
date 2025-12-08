{ lib, config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = { # See: https://github.com/lutris/docs/blob/master/InstallingDrivers.md#nvidia-3
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true; # Set to false to use the proprietary kernel module
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Apparently `beta` is better?
#    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
#      version = "580.95.05";
#      sha256_64bit = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
#      sha256_aarch64 = "sha256-hJ7w746EK5gGss3p8RwTA9VPGpp2lGfk5dlhsv4Rgqc=";
#      openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
#      settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
#      persistencedSha256 = lib.fakeSha256;
#    };
  };
  #nixpkgs.config.cudaSupport = true;
}
