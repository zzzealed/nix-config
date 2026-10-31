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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    teapot.url = "github:amaanq/teapot";
    redlib = {
      #url = "github:redlib-org/redlib";
      url = "github:EnkryptattuDev/redlib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable-small";
    };
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
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    degoog = {
      url = "github:degoog-org/degoog";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    glide = {
      url = "github:glide-browser/glide.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-25-11,
      nix-on-droid,
      nixos-wsl,
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
            {
              system,
              modules ? [ ],
            }:
            nixpkgs.lib.nixosSystem {
              inherit system specialArgs;
              modules = [
                commonModule
                (./hosts + "/${hostName}/configuration.nix")
                {
                  networking = {
                    inherit hostName;
                    domain = "lan";
                    hostId = hosts.${hostName}.hostId;
                    # Map all host's IPs to a name+domain for the `/etc/hosts`-file
                    hosts = nixpkgs.lib.mapAttrs' (
                      name: host: nixpkgs.lib.nameValuePair host.lanIp [ "${name}.lan" ]
                    ) hosts;
                  };
                }
                ./secrets
                ./overlays
              ]
              ++ modules;
            }
          )
          {
            desktop1 = {
              system = "x86_64-linux";
              modules = [
                nixos-wsl.nixosModules.default
                { wsl.enable = true; }
              ];
            };
            srv1 = {
              system = "x86_64-linux";
              modules = [ ./hosts/srv1/hardware-configuration.nix ];
            };
            rpi1 = {
              system = "aarch64-linux";
              modules = [ ./hosts/rpi1/hardware-configuration.nix ];
            };
            vps1 = {
              system = "x86_64-linux";
              modules = [ ./hosts/vps1/hardware-configuration.nix ];
            };
            laptop1 = {
              system = "x86_64-linux";
              modules = [
                nixos-wsl.nixosModules.default
                { wsl.enable = true; }
              ];
            };
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
            phone1.system = "aarch64-linux";
          };

      legacyPackages.aarch64-linux.nix-on-droid-proot-static =
        nix-on-droid.packages.x86_64-linux.prootTermux-aarch64;

      checks.aarch64-linux.phone1 = nixOnDroidConfigurations.phone1.config.build.activationPackage;
    };
}
