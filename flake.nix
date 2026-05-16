{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11"; # 25.11
    #nixpkgs.url = "git+file:///home/mads/Documents/nixpkgs";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # Input pinned in `flake.lock`
    nixpkgs-unstable-small.url = "nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11"; # 25.11
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      #url = "github:nix-community/stylix/release-25.11";
      #url = "git+file:///vault/Documents/Projects/stylix";
      url = "github:zzzealed/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    glide = {
      url = "github:glide-browser/glide.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    teapot = {
      url = "github:amaanq/teapot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    redlib = {
      #url = "github:redlib-org/redlib";
      url = "github:redlib-org/redlib/pull/552/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zmx = {
      url = "github:neurosnap/zmx";
      #url = "git+file:///home/mads/Documents/zmx";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable-small";
    };
  };

  outputs =
    # Bind all inputs from above to `inputs` attr
    inputs@{ ... }:
    let
      mkNixosConfig =
        hostName: system: domain:
        inputs.nixpkgs.lib.nixosSystem {
          system = system;
          # https://wiki.nixos.org/wiki/NixOS_system_configuration#Accessing_flake_inputs
          specialArgs = { inherit inputs; };
          modules = [
            {
              networking = {
                hostName = hostName;
                domain = domain;
              };
            }
            ./nix.nix
            ./secrets
            ./overlays
            (./hosts + "/${hostName}/configuration.nix")
            (./hosts + "/${hostName}/hardware-configuration.nix")
          ];
        };
    in
    {
      nixosConfigurations = {
        desktop-nixos = mkNixosConfig "desktop" "x86_64-linux" "l.zzzealed.com";
        server-nixos = mkNixosConfig "server" "x86_64-linux" "l.zzzealed.com";
        pi-nixos = mkNixosConfig "pi" "aarch64-linux" "l.zzzealed.com";
        vps-nixos = mkNixosConfig "vps" "x86_64-linux" "zzzealed.com";
      };
    };
}
