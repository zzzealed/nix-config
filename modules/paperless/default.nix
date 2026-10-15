{ config, pkgs, ... }:
{
  imports = [
    ./proxy.nix
    ./bind.nix
  ];
  age.secrets."password-file".file = ../../secrets/paperless/password-file.age;
  services.paperless = {
    enable = true;
    package = pkgs.paperless-ngx;
    port = 28981;
    passwordFile = config.age.secrets."password-file".path;
    domain = "paperless.l.zzzealed.com";
  };
}
