{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking.firewall = { allowedUDPPorts = [ 24454 ]; }; # For "Simple Voice Chat" mod.

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_11.override { loaderVersion = "0.18.3"; };
    };
    servers.mads-sp = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_11;
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
        difficulty = "hard";
        enforce-whitelist = true;
        force-gamemode = true;
        gamemode = "survival";
        level-name = "world";
        #level-seed = "";
        level-type = "minecraft:normal";
        max-players = 1;
        motd = "Mads' Single Player (glitchless)";
        simulation-distance = 64;
        spawn-protection = 0;
        view-distance = 64;
        white-list = true;
      };
      jvmOpts = "-Xms2048M -Xmx12288M"; # Inital 2gb, then max 12gb
        symlinks = {
          mods = with pkgs; pkgs.linkFarmFromDrvs "mods" ( builtins.attrValues {
            # Get with `nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- <VERSION ID>`
            Fabric-API = fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/5oK85X7C/fabric-api-0.140.0%2B1.21.11.jar"; sha512 = "f33d3aa6d4da877975eb0f814f9ac8c02f9641e0192402445912ddab43269efcc685ef14d59fd8ee53deb9b6ff4521442e06e1de1fd1284b426711404db5350b"; };
            FerriteCore = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/eRLwt73x/ferritecore-8.0.3-fabric.jar"; sha512 = "be600543e499b59286f9409f46497570adc51939ae63eaa12ac29e6778da27d8c7c6cd0b3340d8bcca1cc99ce61779b1a8f52b990f9e4e9a93aa9c6482905231"; };
            Lithium = fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/4DdLmtyz/lithium-fabric-0.21.1%2Bmc1.21.11.jar"; sha512 = "0857d30d063dc704a264b2fe774a7e641926193cfdcde72fe2cd603043d8548045b955e30c05b1b2b96ef7d1c0f85d55269da26f44a0644c984b45623e976794"; };
            SimpleVoiceChat = fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/YECcGHNV/voicechat-fabric-1.21.11-2.6.9.jar"; sha512 = "e96414e96f36c8344c27d5ae0477699fa41e1fd1098036604063732d4b60e8004d2c24ddb4fad7ae84a0766c1930d56a67ac6acab9aeb75372758e431770e2f9"; };
            Krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar"; sha512 = "4dcd7228d1890ddfc78c99ff284b45f9cf40aae77ef6359308e26d06fa0d938365255696af4cc12d524c46c4886cdcd19268c165a2bf0a2835202fe857da5cab"; };
            C2MeFabric = fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/DLKF3HZk/c2me-fabric-mc1.21.11-0.3.6%2Bbeta.1.0.jar"; sha512 = "d4f983aeb5083033b525522e623a9a9ba86b6fc9c83db008cc0575d0077e736ac9bee0b6b0e03b8d1c89ae27a4e5cdc269041f61eb0d1a10757de4c30b065467"; };
            ImprovedSigns = fetchurl { url = "https://cdn.modrinth.com/data/tEcCNQe7/versions/wUAKh1yn/improved-signs-1.6.0%2Bmc1.21.11.jar"; sha512 = "f23b7ed1baa185e319794e9ba15a638fd36a2efdde1c9332f0b477cd78caf61838f34800bcbf10e0ea5349decdc9da24522cdba7133da48737fe54807e872c54"; };
            ScalableLux = fetchurl { url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar"; sha512 = "729515c1e75cf8d9cd704f12b3487ddb9664cf9928e7b85b12289c8fbbc7ed82d0211e1851375cbd5b385820b4fedbc3f617038fff5e30b302047b0937042ae7"; };
            AppleSkin = fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/pvcLnrm0/appleskin-fabric-mc1.21.11-3.0.7.jar"; sha512 = "dfc990170b969f3213a9912d13c3fc0d067e2e88faf1a6c7a69bd1a463cd6144ac2dcaeb6a2a3150b595378c1f9449fb0740714ff7703c18c93f8ae3c9eceaa3"; };
            AlternateCurrent = fetchurl { url = "https://cdn.modrinth.com/data/r0v8vy1s/versions/XdouG8YV/alternate-current-mc1.21.11-1.9.0.jar"; sha512 = "6c6f9411fad87f5ad04648fe47946764bce5f9121af2155aa2be7731e52b11e9150ac2de1657e0407ecc4cf1c373ef605b4de020aa71db32ba051bf88aec2535"; };
            Clumps = fetchurl { url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/OgBE8Rz4/Clumps-fabric-1.21.11-29.0.0.1.jar"; sha512 = "3cff3cd2d600a6d84030b38ce6244143d13774d5287627bb7312adae5edc7ae2d9151a2c9c39a00681c354d549b0a62ac48c0077ba586cc10c00d32f39e87f18"; };
            Chunky = fetchurl { url = "https://cdn.modrinth.com/data/fALzjamp/versions/bk9YUabA/Chunky-Fabric-1.4.54.jar"; sha512 = "bf15fdb0c0e204c294766c6b92f0dc89d96e94ce4f70b98ac42eaa46b87802af56cfeb6548778f4945b1fdc2fe561a25477f711937dbf390e20b94c1bd006cae"; };
            Carpet = fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/JV4Dlp7j/fabric-carpet-1.21.11-1.4.193%2Bv251211.jar"; sha512 = "7cc29adfe7de824aad4a32ba2b6d8c899c788a2e5d920e8e63dbddd23ca0702deeedc4948bf562d0326b24402806dc819e6132d26e5513a20495f819d8858dd6"; };
          } );
        };
      };
    };
}
