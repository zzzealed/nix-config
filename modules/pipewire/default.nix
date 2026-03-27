{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.alsa-utils ];
  services.pipewire = {
    enable = true;
    audio.enable = true; # Set as primary sound server
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
