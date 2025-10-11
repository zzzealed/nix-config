{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05"; # 25.05
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # Input pinned in `flake.lock`
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; # 25.05
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #yazi.url = "github:sxyazi/yazi";
    #tagstudio.url = "github:TagStudioDev/TagStudio";
    tidaLuna.url = "github:Inrixia/TidaLuna";
    steam-config-nix.url = "github:different-name/steam-config-nix";
    #niri.url = "github:YaLTeR/niri";
    #nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    tidaLuna,
    steam-config-nix,
    nix-gaming,
    agenix,
    ...
    } @ inputs: {
      nixosConfigurations = let
        # Global configuration, so applies to *all* hosts 
        mkSystem = name: arch: nixpkgs.lib.nixosSystem {
          specialArgs = { # See: https://wiki.nixos.org/wiki/NixOS_system_configuration#Accessing_flake_inputs
            flakeInputs = inputs;
            inherit inputs;
            system = arch;
          };
          modules = [
            { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
            { nixpkgs.config.allowUnfree = true; }
            { networking.hostName = name; }
            ./secrets
            ./overlays
            (./hosts + "/${name}/configuration.nix")
            (./hosts + "/${name}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
          ];
        };
      in {
        # Hosts: "name" "arch"
        desktop-nixos = mkSystem "desktop-nixos" "x86_64-linux";
        server-nixos = mkSystem "server-nixos" "x86_64-linux";
        pi-nixos = mkSystem "pi-nixos" "aarch64-linux";
        # TODO: phone 
      };
    };
}
