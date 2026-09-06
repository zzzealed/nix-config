{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05"; # 26.05
    #nixpkgs.url = "git+file:///home/mads/Documents/nixpkgs";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable-small.url = "nixpkgs/nixos-unstable-small";
    nixpkgs-25-11.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05"; # 26.05
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-25-11.url = "github:nix-community/home-manager/release-25.11";
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
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/prerelease-25.11";
      inputs = {
        nixpkgs.follows = "nixpkgs-25-11";
        home-manager.follows = "home-manager-25-11";
      };
    };
  };

  outputs =
    # Bind all inputs from above to `inputs` attr
    inputs@{ ... }:
    let
      specialArgs = { inherit inputs; };

      mkNixosConfig =
        hostName: system: hostId:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              nix.settings = {
                experimental-features = [
                  "nix-command"
                  "flakes"
                ];
                inherit (import ./cache.nix) substituters trusted-public-keys;
              };
            }
            {
              networking = {
                hostName = hostName;
                domain = "internal";
                hostId = hostId;
              };
            }
            ./secrets
            ./overlays
            (./hosts + "/${hostName}/configuration.nix")
            (./hosts + "/${hostName}/hardware-configuration.nix")
          ];
        };

      mkNixOnDroidConfig =
        hostName: system:
        inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import inputs.nixpkgs-25-11 {
            inherit system;
            overlays = [ inputs.nix-on-droid.overlays.default ];
          };
          modules = [ (./hosts + "/${hostName}/configuration.nix") ];
          extraSpecialArgs = specialArgs;
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
      nixOnDroidConfigurations.phone-droid = mkNixOnDroidConfig "phone" "aarch64-linux";
      legacyPackages.aarch64-linux.nix-on-droid-proot-static =
        inputs.nix-on-droid.packages.x86_64-linux.prootTermux-aarch64;
      checks.aarch64-linux.phone-droid =
        (mkNixOnDroidConfig "phone" "aarch64-linux").config.build.activationPackage;
    };
}
