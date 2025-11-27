{ pkgs, config, ... }:
{
  services.karakeep = {
    enable = true;
    package = pkgs.unstable.karakeep;
    extraEnvironment = {
      PORT = "7890";
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      OPENAI_API_KEY = "secret";
      OPENAI_BASE_URL = "http://server.l.zzzealed.com:9090/v1";
      INFERENCE_TEXT_MODEL = "deepseek-v3";
      INFERENCE_IMAGE_MODEL = "gptimage";
      INFERENCE_CONTEXT_LENGTH = "16384";
    };
  };
  #networking.firewall = { allowedTCPPorts = [ 7890 ]; };
  services.nginx = {
    virtualHosts."karakeep.l.zzzealed.com" = {
      useACMEHost = "zzzealed.com";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${toString config.services.karakeep.extraEnvironment.PORT}";
    };
  };
}
