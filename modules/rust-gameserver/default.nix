{ pkgs, lib, ... }:
{
  imports = [ ./bind.nix ];
  environment.systemPackages = [
    pkgs.steam-run
    pkgs.steamcmd
    pkgs.unzip
  ];
  systemd.services.rust-gameserver = {
    enable = true;
    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.steam-run} ./runds.sh";
      WorkingDirectory = "/var/lib/rust-gameserver";
    };
    wantedBy = lib.mkForce [ ]; # Don't autostart
  };
  networking.firewall = {
    allowedUDPPorts = [ 28015 ];
    allowedTCPPorts = [ 28016 ];
  };
}
