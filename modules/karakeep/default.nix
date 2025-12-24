{ pkgs, config, ... }:
{
  services.karakeep = {
    enable = true;
    package = pkgs.unstable.karakeep;
    extraEnvironment = {
      PORT = "7890";
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      # Inference
      OPENAI_API_KEY = "secret";
      OPENAI_BASE_URL = "https://g4f.l.zzzealed.com/v1";
      INFERENCE_TEXT_MODEL = "deepseek-v3";
      INFERENCE_IMAGE_MODEL = "gptimage";
      INFERENCE_CONTEXT_LENGTH = "16384";
      # Crawler
      CRAWLER_FULL_PAGE_SCREENSHOT = "true";
      CRAWLER_FULL_PAGE_ARCHIVE = "true";
      CRAWLER_VIDEO_DOWNLOAD = "true";
      CRAWLER_VIDEO_DOWNLOAD_MAX_SIZE = "-1";
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
