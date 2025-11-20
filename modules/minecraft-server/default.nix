{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_10.override { loaderVersion = "0.17.3"; };
    };
    servers.mads-sp = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_10;
      openFirewall = true;
      whitelist = {
        # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
        zzzealed = "10baa937-a2d4-489f-a3e5-b6286df5d0f6";
      };
      operators = {
        zzzealed = {
          uuid = "10baa937-a2d4-489f-a3e5-b6286df5d0f6";
          level = 4;
          bypassesPlayerLimit = true;
        };
      };
      serverProperties = {
        server-port = 43000;
        difficulty = "normal";
        enforce-whitelist = true;
        force-gamemode = true;
        gamemode = "survival";
        level-name = "world";
        #level-seed = "";
        level-type = "minecraft:normal";
        max-players = 1;
        motd = "Mads' Single Player (glitchless)";
        simulation-distance = 32;
        spawn-protection = 0;
        view-distance = 32;
        white-list = true;
      };
      jvmOpts = "-Xms2048M -Xmx12288M"; # Inital 2gb, then max 12gb
        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" ( builtins.attrValues {
            Fabric-API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/dQ3p80zK/fabric-api-0.138.3%2B1.21.10.jar";
                                         sha256 = "sha256-rCB1kEGet1BZqpn+FjliQEHB1v0Ii6Fudi5dfs9jOVM="; };
            FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/MGoveONm/ferritecore-8.0.2-fabric.jar";
                                          sha256 = "sha256-LGn9gXMEu2l1zUti/TK/IaXVyPDDUj6sxzTAwlB+2nc="; };
            Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/NsswKiwi/lithium-fabric-0.20.1%2Bmc1.21.10.jar";
                                      sha256 = "sha256-R4Z0hlDjXdFlcrhenM0YOadgbATGdqWbZEUOhEadKJo="; };
            YetAnotherConfigLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/UZmV6xf4/yet_another_config_lib_v3-3.8.0%2B1.21.9-fabric.jar";
                                                  sha256 = "sha256-Su3K8eC2kHqCrIn2R9j4cuzBVPZzvVhE0FrsGvz29DY="; };
            SimpleVoiceChat = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/BjR2lc4k/voicechat-fabric-1.21.10-2.6.6.jar";
                                              sha256 = "sha256-yC5pMBLsi4BnUq4CxTfwe4MGTqoBg04ZaRrsBC3Ds3Y="; };
            Krypton = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
                                      sha256 = "sha256-lCkdVpCgztf+fafzgP29y+A82sitQiegN4Zrp0Ve/4s="; };
            C2MFabric = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/2EKX8Hiv/c2me-fabric-mc1.21.10-0.3.6%2Balpha.0.9.jar";
                                        sha256 = "sha256-CKyjlpFTLY3a/+zWWFieCc0aQW9sdUektPUSZhQDsFo="; };
            #ImprovedSigns = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/tEcCNQe7/versions/qj2uONOj/improved-signs-1.6.0%2Bmc1.21.9.jar";
            #                                sha256 = "sha256-iPYknfreQ0ZqmdL/1FCMhoLpLb3AdgW5AeqOKmI68Ns="; };
            ScalableLux = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar";
                                          sha256 = "sha256-ekpzcThhg8dVUjtWtVolHXWsLCP0Cvik8PijNbBdT8I="; };
            AppleSkin = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/8sbiz1lS/appleskin-fabric-mc1.21.9-3.0.7.jar";
                                        sha256 = "sha256-ejEbFTr0wrdgm4SSpjsk3Zt6/TOLrBoj32qJGm6AC4k="; };
          } );
        };
      };
    };
}
