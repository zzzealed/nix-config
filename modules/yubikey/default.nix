{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.yubioath-flutter ];
  services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.services = {
    login.u2f.enable = true;
    sudo.u2f.enable = true;
  };

  # https://wiki.nixos.org/wiki/Yubikey#Locking_the_screen_when_a_Yubikey_is_unplugged
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
