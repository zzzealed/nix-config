{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.yubioath-flutter ];
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.services = {
    login.u2f.enable = true;
    sudo.u2f.enable = true;
  };

  # Lock on disconnect
  # this barely works and also sucks ass
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.util-linux}/bin/runuser -u mads -- ${pkgs.coreutils}/bin/env XDG_RUNTIME_DIR=/run/user/1000 WAYLAND_DISPLAY=wayland-1 ${pkgs.swaylock}/bin/swaylock"
  '';
}
