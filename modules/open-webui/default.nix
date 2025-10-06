{ pkgs, ... }:
{
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
    openFirewall = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OPENAI_API_BASE_URL = "http://server.l.zzzealed.com:50431/v1";
    };
  };
}
