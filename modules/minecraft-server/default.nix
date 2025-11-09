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
      package = pkgs.fabricServers.fabric-1_21_8.override { loaderVersion = "0.17.3"; };
    };
    servers.mads-sp = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_8;
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
            Fabric-API = pkgs.fetchurl          { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/RMahJx2I/fabric-api-0.136.0%2B1.21.8.jar"; sha256 = "sha256-EDZwSZGz77+KPQP/04NVJ0ywAgKuRcdoqPYwwZTRLtY="; };
            FerriteCore = pkgs.fetchurl         { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar"; sha256 = "sha256-K5C/AMKlgIw8U5cSpVaRGR+HFtW/pu76ujXpxMWijuo="; };
            Lithium = pkgs.fetchurl             { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/qxIL7Kb8/lithium-fabric-0.18.1%2Bmc1.21.8.jar"; sha256 = "sha256-BPNwwvboGdzYajxWhOOP0enEmIx8JJP/srwH60UEuUw="; };
            YetAnotherConfigLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/WxYlHLu6/yet_another_config_lib_v3-3.7.1%2B1.21.6-fabric.jar"; sha256 = "sha256-fXH77g4soPOKR1MJ0jydCEzWjt1L5lRO7Nta7B820e0="; };
            SimpleVoiceChat = pkgs.fetchurl     { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/2Z1g1v36/voicechat-fabric-1.21.8-2.6.6.jar"; sha256 = "sha256-/vvxvBq5YY6Tuu3UarBXmdiVN0hOVTwL/eNX3HLo0yE="; };
            Krypton = pkgs.fetchurl             { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar"; sha256 = "sha256-uGYia+H2DPawZQxBuxk77PMKfsN8GEUZo3F1zZ3MY6o="; };
            C2M = pkgs.fetchurl                 { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/tlZRTK1v/c2me-fabric-mc1.21.8-0.3.4.0.0.jar"; sha256 = "sha256-MkYZOI9AL7yswqEfSp8/Njs4z7xFRItuvLu96znO/v4="; };
            ImprovedSigns = pkgs.fetchurl       { url = "https://cdn.modrinth.com/data/tEcCNQe7/versions/Snd745di/improved-signs-1.5.1%2Bmc1.21.6.jar"; sha256 = "sha256-e3QLT+vCNT/TT/CnM3hzSbU7an2+P6xfkDVI7Va9fRo="; };
          } );
        };
      };
    };
}
