{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  networking.firewall = { allowedUDPPorts = [ 24454 ]; }; # For "Simple Voice Chat" mod.

  services.minecraft-servers = {
    servers.mads-sp = {
      enable = true;
      package = pkgs.fabricServers.fabric-26_1_2.override {
        loaderVersion = "0.19.3";
        jre_headless = pkgs.openjdk25_headless; # https://github.com/Infinidoge/nix-minecraft/issues/211#issue-4277777659
      };
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
          Fabric-API = fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/WC1KT7Yg/fabric-api-0.153.0%2B26.1.2.jar"; sha512 = "4e31da3c796714d25ca079e5277980c5439bb09dcad33d1224cccdfec6000b776ba5d16323a9c312682e773bddedae75aa697a7c0f4ad2b77b5b11ba679b480a"; };
          FerriteCore = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/d5ddUdiB/ferritecore-9.0.0-fabric.jar"; sha512 = "d81fa97e11784c19d42f89c2f433831d007603dd7193cee45fa177e4a6a9c52b384b198586e04a0f7f63cd996fed713322578bde9a8db57e1188854ae5cbe584"; };
          Lithium = fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/fQBdPR1m/lithium-fabric-0.24.6%2Bmc26.1.2.jar"; sha512 = "fac351f5b6150889b9355a01889c35b5798147d4bedb291594a590a2d41909eb8dc494ef0051317bf55886f2fc7fe134abbe2e755098df38473edb2bf43357e9"; };
          SimpleVoiceChat = fetchurl { url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/lT9C1Daj/voicechat-fabric-2.6.20%2B26.1.2.jar"; sha512 = "97a32d03d8e03ab5cc4b5fa89918c49f500d909946b0fe6ed114534a32bd9e13be36e90b47d85a5d1e60c2fb8c08bcccf66aa3ddf7dbd80ceaf21feb16eca964"; };
          Krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/kYAGItyj/krypton-0.3.0.jar"; sha512 = "14233210283a76f3cf435a3b8ddbcbd65a858d2b1a10b88ff643c0a01486dfd2bf1843bd3456cd4fb86cbb3b06f2dea0c4e663b1976a48e96de16d3b5a707ec9"; };
          C2MeFabric = fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/zzYSg63u/c2me-fabric-mc26.1.2-0.4.0-beta.1.0.jar"; sha512 = "eb6c9dd628da067c4ebbc4345b93cf6573c0ede3e5120e9444a1e0dad355a0b1fe53f9bc5d72148ff68d3aa2f79bdab6a017b18e659a77a7b0fa4489c9e2c7bd"; };
          ImprovedSigns = fetchurl { url = "https://cdn.modrinth.com/data/tEcCNQe7/versions/Uy3SVGX0/improved-signs-1.6.0%2Bmc26.1.2.jar"; sha512 = "d2f10d1accd733d2a216f1a5f2df6d0af375119c8b8a5fab0bd95576faa82a513dacb7748412406211d5c994d5407b45263322b92a9333b11362b1a6dbccef59"; };
          ScalableLux = fetchurl { url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/gYbHVCz8/ScalableLux-0.2.0%2Bfabric.2b63825-all.jar"; sha512 = "48565a4d8a1cbd623f0044086d971f2c0cf1c40e1d0b6636a61d41512f4c1c1ddff35879d9dba24b088a670ee254e2d5842d13a30b6d76df23706fa94ea4a58b"; };
          AppleSkin = fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/zLlqqiTA/appleskin-fabric-mc26.1.2-3.0.10.jar"; sha512 = "eacb134cc9e03a4fd870c3e75fedd3fba6ef9bf1611dcff5b89f0d35b22bda5709f085436ac071c018cf7d3e5a54c9783477c4f091d4ded74deb5292f25f5644"; };
          AlternateCurrent = fetchurl { url = "https://cdn.modrinth.com/data/r0v8vy1s/versions/PGm6TCxh/alternate-current-mc26.1-1.9.0.jar"; sha512 = "9541b1c5abdc675259043c1b6e71ac48680ee1746635a62b4376a09944899a78f9615bd1a9f8d0b27910dd5e62bbdf3b9d7e4dba91a34f8dd4c3a08f584c5c13"; };
          Clumps = fetchurl { url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/RXNrUIjA/Clumps-fabric-26.1.2-26.1.2.1.jar"; sha512 = "369c20d8887c36c9fd4569a7c8dac1ffc51be036bb58763605535034a5aebd9fbb35de43cc0cc8c774d8dd02b2ab1776f90be1657f3796b38107f779edb4a77a"; };
          Chunky = fetchurl { url = "https://cdn.modrinth.com/data/fALzjamp/versions/4Eotm6ov/Chunky-Fabric-1.5.3.jar"; sha512 = "b83bfe7b218d0aa6232af977ae741dc1f82b10e50cd12bb759f65cf416b8b62beccb543e587ef0b9670abe03815660f8e091bc6823624d65cf07300571573516"; };
          Carpet = fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/ygtmLbO3/fabric-carpet-26.1%2Bv260402.jar"; sha512 = "d98b02eb2bd2c7594aac3913c7ddfc8ef6ff724a6b1e86098611e09c303134626eb76e1c9fe910101c6972c8fe0993fb0b21ea99c7affc0e33a0ac64f941954b"; };
        });
      };
    };
  };
}
