{ inputs, ... }:
{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];
  services.pipewire = {
    enable = true;
    audio.enable = true; # Set as primary sound server
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    lowLatency = {
      # enable this module
      enable = true;
      # defaults (no need to be set unless modified)
      quantum = 128;
      rate = 48000;
    };
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
