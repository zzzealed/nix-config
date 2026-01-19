{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11"; # 25.11
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # Input pinned in `flake.lock`
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11"; # 25.11
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #yazi.url = "github:sxyazi/yazi";
    #tagstudio.url = "github:TagStudioDev/TagStudio";
    tidaluna = {
     url = "github:inrixia/tidaluna";
     #inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    steam-config-nix.url = "github:different-name/steam-config-nix";
    #niri.url = "github:YaLTeR/niri";
    #nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";
    agenix.url = "github:ryantm/agenix";
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    glance-ical-events.url = "github:AWildLeon/Glance-iCal-Events";
    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    prismlauncher.url = "github:prismlauncher/prismlauncher";
    glide-browser.url = "github:glide-browser/glide.nix";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    lan-mouse.url = "github:feschber/lan-mouse";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    tidaluna,
    steam-config-nix,
    nix-gaming,
    agenix,
    stylix,
    glance-ical-events,
    nix-on-droid,
    nix-minecraft,
    prismlauncher,
    nixpkgs-wayland,
    lan-mouse,
    ghostty,
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
            {
              nix.settings = {
                experimental-features = [ "nix-command" "flakes" ];
                download-buffer-size = 524288000; # https://github.com/NixOS/nix/issues/11728#issuecomment-2725297584
                trusted-substituters = [
                  "https://prismlauncher.cachix.org"
                  "https://lan-mouse.cachix.org"
                ];
                trusted-public-keys = [
                  "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
                  "lan-mouse.cachix.org-1:KlE2AEZUgkzNKM7BIzMQo8w9yJYqUpor1CAUNRY6OyM="
                ];
              };
            }
            { nixpkgs.config.allowUnfree = true; }
            { networking.hostName = name; }
            ./secrets
            ./overlays
            (./hosts + "/${name}/configuration.nix")
            (./hosts + "/${name}/hardware-configuration.nix")
          ];
        };
      in {
        # Hosts: "name" "arch"
        desktop-nixos = mkSystem "desktop-nixos" "x86_64-linux";
        server-nixos = mkSystem "server-nixos" "x86_64-linux";
        pi-nixos = mkSystem "pi-nixos" "aarch64-linux";
        phone-nix = mkSystem "phone-nix" "aarch64-linux";
      };
      # Same ordeal for nix-on-droid
      nixOnDroidConfigurations = let
        mkSystem = name: arch: nix-on-droid.lib.nixOnDroidConfiguration {
          specialArgs = {
            flakeInputs = inputs;
            inherit inputs;
            system = arch;
          };
          modules = [
            {
              nix.settings = {
                experimental-features = [ "nix-command" "flakes" ];
                download-buffer-size = 524288000; # https://github.com/NixOS/nix/issues/11728#issuecomment-2725297584
              };
            }
            {
              nixpkgs.config = {
                allowUnfree = true;
              };
            }
            { networking.hostName = name; }
            ./secrets
            ./overlays
            (./hosts + "/${name}/configuration.nix")
            (./hosts + "/${name}/hardware-configuration.nix")
          ];
        };
      in {
        phone-nix = mkSystem "phone-nix" "aarch64-linux";
      };
    };
}
