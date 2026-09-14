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
    home-manager-25-11 = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-25-11";
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
    inputs@{
      nixpkgs,
      nixpkgs-25-11,
      nix-on-droid,
      ...
    }:
    let
      settings = import ./settings.nix;
      hosts = import ./hosts/meta.nix;
      specialArgs = { inherit inputs hosts; };
      commonModule = {
        nix.settings = { inherit (settings) experimental-features substituters trusted-public-keys; };
        nixpkgs.config = { inherit (settings) allowUnfree; };
      };
    in
    rec {
      nixosConfigurations =
        nixpkgs.lib.mapAttrs
          (
            hostName:
            { system }:
            nixpkgs.lib.nixosSystem {
              inherit system specialArgs;
              modules = [
                commonModule
                (./hosts + "/${hostName}/configuration.nix")
                (./hosts + "/${hostName}/hardware-configuration.nix")
                {
                  networking = {
                    inherit hostName;
                    domain = "lan";
                    hostId = hosts.${hostName}.hostId;
                    hosts = {
                      "${hosts.server.lanIp}" = [ "server.lan" ];
                      "${hosts.desktop.lanIp}" = [ "desktop.lan" ];
                      "${hosts.pi.lanIp}" = [ "pi.lan" ];
                      "${hosts.vps.lanIp}" = [ "vps.lan" ];
                      "${hosts.laptop.lanIp}" = [ "laptop.lan" ];
                      "${hosts.phone.lanIp}" = [ "phone.lan" ];
                    };
                  };
                }
                ./secrets
                ./overlays
              ];
            }
          )
          {
            desktop.system = "x86_64-linux";
            server.system = "x86_64-linux";
            pi.system = "aarch64-linux";
            vps.system = "x86_64-linux";
            laptop.system = "x86_64-linux";
          };

      nixOnDroidConfigurations =
        nixpkgs.lib.mapAttrs
          (
            hostName:
            { system }:
            nix-on-droid.lib.nixOnDroidConfiguration {
              pkgs = import nixpkgs-25-11 {
                inherit system;
                overlays = [ nix-on-droid.overlays.default ];
                config = { inherit (settings) allowUnfree; };
              };
              extraSpecialArgs = specialArgs;
              modules = [
                (./hosts + "/${hostName}/configuration.nix")
                {
                  nix = {
                    extraOptions = "experimental-features = ${nixpkgs.lib.concatStringsSep " " settings.experimental-features}";
                    substituters = nixpkgs.lib.mkForce settings.substituters;
                    trustedPublicKeys = nixpkgs.lib.mkForce settings.trusted-public-keys;
                    registry.nixpkgs.flake = nixpkgs-25-11;
                  };
                }
              ];
            }
          )
          {
            phone.system = "aarch64-linux";
          };

      legacyPackages.aarch64-linux.nix-on-droid-proot-static =
        nix-on-droid.packages.x86_64-linux.prootTermux-aarch64;

      checks.aarch64-linux.phone = nixOnDroidConfigurations.phone.config.build.activationPackage;
    };
}
