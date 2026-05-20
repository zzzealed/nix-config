{ pkgs, config, ... }:
{
  age.secrets."karakeep_environment-file".file = ../../secrets/karakeep_environment-file.age;

  services.karakeep = {
    enable = true;
    package = pkgs.karakeep;
    environmentFile = config.age.secrets."karakeep_environment-file".path;
    extraEnvironment = {
      NEXTAUTH_URL = "https://karakeep.l.zzzealed.com";
      PORT = "7890";
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
      # Inference
      OPENAI_API_KEY = "ollama";
      OPENAI_BASE_URL = "https://ollama.l.zzzealed.com/v1";
      INFERENCE_TEXT_MODEL = "qwen3:0.6b";
      INFERENCE_IMAGE_MODEL = "qwen2.5vl:3b";
      INFERENCE_CONTEXT_LENGTH = "16384";
      # Crawler
      CRAWLER_FULL_PAGE_SCREENSHOT = "true";
      CRAWLER_FULL_PAGE_ARCHIVE = "true";
      CRAWLER_VIDEO_DOWNLOAD = "true";
      CRAWLER_VIDEO_DOWNLOAD_MAX_SIZE = "-1";
    };
  };
  #networking.firewall = { allowedTCPPorts = [ 7890 ]; };
  services.nginx.virtualHosts."karakeep.l.zzzealed.com" = {
    useACMEHost = "zzzealed.com";
    forceSSL = true;
    locations."/".proxyPass =
      "http://127.0.0.1:${toString config.services.karakeep.extraEnvironment.PORT}";
  };
}
