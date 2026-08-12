{ pkgs, ... }:
{
  hardware.uinput.enable = true;
  # For PS5 controller
  boot.kernelModules = [ "uhid" ];
  services.udev.extraRules = ''
    KERNEL=="uhid", SUBSYSTEM=="misc", TAG+="uaccess"
  '';

  services.sunshine = {
    enable = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
    };
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false;
    settings = {
      port = 47989;
      output_name = "DP-1";
    };
  };
}
