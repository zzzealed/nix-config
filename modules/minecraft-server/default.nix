{ inputs, ... }:
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./bind.nix
  ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    managementSystem.systemd-socket.enable = true;
  };
}
