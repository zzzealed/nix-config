{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11"; # 25.11
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; # Input pinned in `flake.lock`
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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nur,
      stylix,
      agenix,
      nix-minecraft,
      glide,
      nixcord,
      teapot,
      ...
    }@inputs:
    {
      nixosConfigurations =
        let
          # Global configuration, so applies to *all* hosts
          mkSystem =
            name: arch:
            nixpkgs.lib.nixosSystem {
              system = arch;
              specialArgs = {
                # See: https://wiki.nixos.org/wiki/NixOS_system_configuration#Accessing_flake_inputs
                flakeInputs = inputs;
                inherit inputs;
              };
              modules = [
                {
                  nix.settings = {
                    experimental-features = [
                      "nix-command"
                      "flakes"
                    ];
                    download-buffer-size = 524288000; # https://github.com/NixOS/nix/issues/11728#issuecomment-2725297584
                    substituters = [
                      "https://cache.nixos.org"
                      "https://nix-community.cachix.org"
                      "https://cache.l.zzzealed.com"
                    ];
                    trusted-public-keys = [
                      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                      "cache.l.zzzealed.com-1:d29SnNbB+hmWUlqbc6TaYaOP8fv25hlxpQRxgCqLQhE="
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
        in
        {
          # Hosts: "name" "arch"
          desktop-nixos = mkSystem "desktop-nixos" "x86_64-linux";
          server-nixos = mkSystem "server-nixos" "x86_64-linux";
          pi-nixos = mkSystem "pi-nixos" "aarch64-linux";
          vps-nixos = mkSystem "vps-nixos" "x86_64-linux";
        };

      checks.x86_64-linux = {
        desktop-nixos = self.nixosConfigurations.desktop-nixos.config.system.build.toplevel;
        server-nixos = self.nixosConfigurations.server-nixos.config.system.build.toplevel;
        vps-nixos = self.nixosConfigurations.vps-nixos.config.system.build.toplevel;
      };
      checks.aarch64-linux = {
        pi-nixos = self.nixosConfigurations.pi-nixos.config.system.build.toplevel;
      };
    };
}
