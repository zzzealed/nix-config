{ config, ... }:
{
  age.secrets."mads-password".file = ../../secrets/mads-password.age;
  users.users.mads = {
    description = "Mads";
    home = "/home/mads";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "gamemode"
      "networkmanager"
      "libvirtd"
      "vault"
      "vault2"
      "media"
      "uinput"
    ];
    hashedPasswordFile = config.age.secrets."mads-password".path;
    linger = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHVWXUuISFGQ3fF27a35k4zqzAxMV8+hfvTREcWGAnEEAAAACHNzaDptYWRz mads@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICSX+uG+W5BIhlcO+kd39ngmRVtOtJirGO5oBlkZuopO mads@nixos"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAHLOvslO6CzqB6TBCQ1IcJPDh2+6FeYG8YDj5jrwc4nAAAACHNzaDptYWRz mads@laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos"
    ];
  };
  nix.settings.trusted-users = [ "mads" ]; # Needed for remote rebuilds
}
