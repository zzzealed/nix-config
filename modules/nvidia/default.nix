{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = { # See: https://github.com/lutris/docs/blob/master/InstallingDrivers.md#nvidia-3
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true; # Set to false to use the proprietary kernel module
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Apparently `beta` is better?
  };
}
