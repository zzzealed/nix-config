{ inputs, ... }:
{
  imports = [ inputs.steam-config-nix.homeModules.default ];
  programs.steam.config = {
    enable = true;
    closeSteam = true; # See 'Important' note at beginning of this readme
    # Configuration for apps across all users
    apps = {
      # App IDs can be found through the game's store URL
      #"252950".compatTool = "GE-Proton"; # Rocket League
      #"252490".compatTool = "Proton 9.0-4"; # Rust
      #"2379780".compatTool = "GE-Proton"; # Balatro
      #"504230".compatTool = ""; # Celeste (works natively)
      #
      #??? wtf "option does not exist"
      # 
      #"268910".compatTools = "GE-Proton"; # Cuphead
      #"22380".compatTools = "GE-Proton"; # Fallout: New Vegas
      #"3240220".compatTools = "GE-Proton"; # Grand Theft Auto V Enhanced
      #"264710".compatTools = "GE-Proton"; # Subnautica
      #"1794680".compatTools = "GE-Proton"; # Vampire Survivors
    };
    # Configuration per user's steamID3
    users."239321722".apps = {
      # Per user config only supports launchOptions, compat tools must be set globally
      "252950".launchOptions = ''gamemoderun %command%'';
      "252490".launchOptions = ''LD_PRELOAD="" gamemoderun %command%''; # TODO: LD_PRELOAD="" doesn't work
      "2379780".launchOptions = ''WINEDLLOVERRIDES="version=n,b" gamemoderun %command%'';
      "504230".launchOptions = ''FNA3D_FORCE_DRIVER=Vulkan gamemoderun %command%'';
      "268910".launchOptions = ''gamemoderun %command%'';
      "22380".launchOptions = ''DXVK_FRAME_RATE=60 gamemoderun %command%'';
      "3240220".launchOptions = ''gamemoderun %command% -nobattleye'';
      "264710".launchOptions = ''LD_PRELOAD="" gamemoderun %command%'';
      "1794680".launchOptions = ''gamemoderun %command%'';
    };
  };
}
