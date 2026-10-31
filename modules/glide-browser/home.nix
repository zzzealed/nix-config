{ lib, inputs, ... }:
{
  imports = [
    inputs.glide.homeModules.default
    inputs.agenix.homeManagerModules.default
  ];

  home.file.".config/glide/glide.ts".source = ./config/glide.ts;

  programs.glide-browser = {
    enable = true;
    package = lib.mkForce null;
    profiles.mads = {
      name = "mads";
      isDefault = true;
      # bookmarks = {
      # force = true;
      # configFile = null; # FIXME
      #   settings = [
      #     {
      #       name = "Gatus";
      #       tags = [ ];
      #       keyword = ",gatus";
      #       url = "https://status.l.zzzealed.com";
      #     }
      #     {
      #       name = "Gatus 2";
      #       tags = [ ];
      #       keyword = ",gatus2";
      #       url = "https://status.rotte.city";
      #     }
      #     {
      #       name = "Router";
      #       tags = [ ];
      #       keyword = ",router";
      #       url = "http://192.168.0.1";
      #     }
      #     {
      #       name = "Router 2";
      #       tags = [ ];
      #       keyword = ",router2";
      #       url = "http://192.168.8.1";
      #     }
      #     {
      #       name = "JetKVM";
      #       tags = [ ];
      #       keyword = ",jetkvm";
      #       url = "http://192.168.0.104";
      #     }
      #     {
      #       name = "Karakeep";
      #       tags = [ ];
      #       keyword = ",kara";
      #       url = "https://karakeep.l.zzzealed.com";
      #     }
      #     {
      #       name = "nix-config";
      #       tags = [ ];
      #       keyword = ",nix-config";
      #       url = "https://github.com/zzzealed/nix-config";
      #     }
      #     {
      #       name = "Syncthing";
      #       tags = [ ];
      #       keyword = ",syncthing";
      #       url = "http://127.0.0.1:8384";
      #     }
      #   ];
      # };
      search = {
        force = true;
        engines = {
          "NixOS package search" = {
            urls = [ { template = "https://search.nixos.org/packages?channel=stable&query={searchTerms}"; } ];
            icon = "https://search.nixos.org/images/nixos-logomark-default-gradient-none.svg";
            definedAliases = [ "@nixpkgs" ];
          };
          "NixOS option search" = {
            urls = [ { template = "https://search.nixos.org/options?channel=stable&query={searchTerms}"; } ];
            icon = "https://search.nixos.org/images/nixos-logomark-default-gradient-none.svg";
            definedAliases = [ "@nixopts" ];
          };
        };
        default = "ddg";
      };
      settings = {
        force = true;
        # Misc.
        "signon.rememberSignons" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "sidebar.verticalTabs" = true;
        "sidebar.visibility" = "always-show";
        "network.trr.mode" = 5; # Disable DOH
        "media.eme.enabled" = true; # Enable DRM
        "browser.contentblocking.category" = "strict";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.search.separatePrivateDefault" = false;
        "browser.urlbar.trimURLs" = false;
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "about:home";

        # History/cookies
        "places.history.enabled" = true;
        "browser.formfill.enable" = true;
        "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
        "privacy.clearOnShutdown_v2.cache" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearOnShutdown_v2.formdata" = true;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
        "privacy.clearOnShutdown_v2.siteSettings" = false;

        # Firefox, the AI-first browser
        "browser.ai.control.default" = "blocked";
        "browser.ai.control.translations" = "available";

        # https://github.com/elFarto/nvidia-vaapi-driver#firefox
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-process.enabled" = true;
        "media.av1.enabled" = false;
        "widget.dmabuf.force-enabled" = true;
      };
    };
  };
}
