{ lib, ... }:
{
  # http://localhost:7657
  services.i2p.enable = true;
  systemd.services.i2p.wantedBy = lib.mkForce [ ];
}
