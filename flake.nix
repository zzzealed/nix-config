{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05"; # 26.05
    #nixpkgs.url = "git+file:///home/mads/Documents/nixpkgs";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # Input pinned in `flake.lock`
    nixpkgs-unstable-small.url = "nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05"; # 26.05
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      #url = "git+file:///home/mads/Documents/stylix";
      # url = "github:zzzealed/stylix/release-25.11";
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
    teapot.url = "github:amaanq/teapot";
    redlib = {
      #url = "github:redlib-org/redlib";
      url = "github:redlib-org/redlib/pull/552/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable-small";
    };
    opendeck-nix = {
      url = "github:Kitt3120/opendeck-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lan-mouse.url = "github:feschber/lan-mouse";
    sparkyfitness.url = "github:codewithcj/sparkyfitness";
    zzzealed-com = {
      url = "git+https://codeberg.org/zzzealed/zzzealed.com";
      flake = false;
    };
    rotte-city = {
      url = "git+https://codeberg.org/zzzealed/rotte.city";
      flake = false;
    };
    fish-helix = {
      url = "github:sshilovsky/fish-helix";
      flake = false;
    };
    autosave-lua = {
      url = "git+https://gist.github.com/2f71a97fb85ed42146f6d9f522bc34ef";
      flake = false;
    };
  };

  outputs =
    # Bind all inputs from above to `inputs` attr
    inputs@{ ... }:
    let
      mkNixosConfig =
        hostName: system: hostId:
        inputs.nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            {
              networking = {
                hostName = hostName;
                domain = "internal"; # https://en.wikipedia.org/wiki/.internal
                hostId = hostId; # `head -c 8 /etc/machine-id`
              };
            }
            ./nix.nix
            ./secrets
            ./overlays
            (./hosts + "/${hostName}/configuration.nix")
            (./hosts + "/${hostName}/hardware-configuration.nix")
          ];
          # https://wiki.nixos.org/wiki/NixOS_system_configuration#Accessing_flake_inputs
          specialArgs = { inherit inputs; };
        };
    in
    {
      nixosConfigurations = {
        desktop-nixos = mkNixosConfig "desktop" "x86_64-linux" "19fa2096";
        server-nixos = mkNixosConfig "server" "x86_64-linux" "adb2c089";
        pi-nixos = mkNixosConfig "pi" "aarch64-linux" "cf20a29f";
        vps-nixos = mkNixosConfig "vps" "x86_64-linux" "2c363b2d";
        laptop-nixos = mkNixosConfig "laptop" "x86_64-linux" "4115249e";
      };
    };
}
