{ config, inputs, pkgs, ... }:
{
  imports = [
    inputs.glide.homeModules.default
    inputs.agenix.homeManagerModules.default
  ];

  # Mozilla+NVIDIA = kms
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  programs.glide-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.ff2mpv ];
    policies = {
      EnableTrackingProtection = true;
      DisableTelemetry = true;
    };
    languagePacks = [
      "en-us"
      "da-dk"
      "es-es" # Como esta shawty
    ];
    profiles = {
      mads = {
        name = "mads";
        isDefault = true;
        bookmarks = {
          force = true;
          settings = [
            {
              name = "Glance";
              tags = [];
              keyword = ",glance";
              url = "https://glance.l.zzzealed.com";
            }
            {
              name = "Gatus";
              tags = [];
              keyword = ",gatus";
              url = "https://status.rotte.city";
            }
            {
              name = "JetKVM";
              tags = [];
              keyword = ",jetkvm";
              url = "http://192.168.0.104";
            }
          ];
        };
        extensions = {
          force = true;
#          packages = [
             # I don't actually wanna install my extensions from NUR so this is just a list of the ones I use
             # AdNauseam
             # Augmented Steam
             # Bitwarden
             # Consent-O-Matic
             # Dark Reader
             # ff2mpv
             # HLTV Fantasy Values
             # Karakeep
             # Nixpkgs PR Tracker
             # Redirector
             # Refined GitHub
             # Return YouTube Dislike
             # Search by Image
             # SponsorBlock
             # TWP
             # Violentmonkey
#          ];
        };
        search = {
          force = true;
          engines = {
            "SearXNG" = {
              urls = [ { template = "https://searx.l.zzzealed.com/search?q={searchTerms}"; } ];
              icon = "https://searx.l.zzzealed.com/static/themes/simple/img/favicon.png";
              definedAliases = [ "@searx" ];
            };
            "NixOS package search" = {
              urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
              icon = "https://search.nixos.org/images/nix-logo.png";
              definedAliases = [ "@nixpkgs" ];
            };
            "NixOS option search" = {
              urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
              icon = "https://search.nixos.org/images/nix-logo.png";
              definedAliases = [ "@nixopts" ];
            };
            "Home Manager manual options" = {
              urls = [ { template = "https://nix-community.github.io/home-manager/options.xhtml#opt-{searchTerms}"; } ];
              icon = "";
              definedAliases = [ "@hmopts" ];
            };
          };
          default = "SearXNG";
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
          "widget.use-xdg-desktop-portal.file-picker" = 1; # Use KDE file picker
          "browser.contentblocking.category" = "strict";
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.search.separatePrivateDefault" = false;
          "browser.urlbar.trimURLs" = false;
          "browser.startup.homepage" = "https://searx.l.zzzealed.com/preferences?preferences=eJx1WEuzo7oR_jXxhorr3kwqqSy8SlW2SdW9e0pIDfQg1Bw9bHN-fVoITGM8i-MZPolWv_sTWkXoyCOEWwcOvLIXq1yXVAc3lSJdLGll4Qbukh81jZOFCLdLq-6oydUeAtk7-NsFR36pnjw959t_lA1wGSH2ZG7_--8ff16CaiGA8rq__XaJPYxwC5iFXVhCsjHULMzBo46qWV83hLt4Uvx4Jd9dymt1iLNdddTgIvhaWezcyP9f31fmrpwGU6_nFvQrgZ9rdHXEyAL-9AkuZUPWQBd_zPyOBR3Lck9xgDncDLSKVb0kb-uW_KhiRNfd2mTtxWBQjeXDwHXo2J0__vHbKrZePfuXv_37BVZ3NEChrsu_vPSvTnV1HUijstUIBhWDSrfJiU3shAaqwIEY6npx-Bta5H5-o1LJIK-NKaDOS3ZiTSuLLj2rSekhi2OxMa85p0KVNcU71HWLtpzkgqpzmJaHaahG9J682DBxbCr-zUf6w5uK08WoVb7DJ4XqgQNuB_qIWtrkY4gqIsdEgGGQ3mwUmnQCqrJdvFbgQWG7Hd9g1H2KIBzFUJP0AHHbMjUH0dFg1-32LBG6aq2vRkrRSvdzxaa9-VN7CsFDyxHWCJyVBXuYO3LOi3NmmN4ez_ZkMMfgFQkD8M0F8IqsgcV3vIG41HxGTFdx-qLD7NIgj2BtZm3pnKzA-qERMtg9-a-jt9N3_AEqb97fKfkwqom382-WOtJPnLL39l1cRjCDPPv3p7C3NZ6yIpvvWw-c0tTGh_JQGfRcqblmi6tbj25AJZOpnZ2R0tt5FnZ1gN899waBcGtQzRY6MtCA79ZHXgMOPI3bM5HxoIx8nahjqyer5lwKYddcrozEsZcdgPsJ-Fz9ubHKePeq8Sr_rEf2nFvgSwwKAM9XnrGQcM1lvjyjrSYK8RWrPnXcnrpWadje3ZHKqKgCxPBhKXBCv7IZR9Ps5qJTwgqOrecsm4X--IUzii0_MfS0v2-RzfNzleMTUHhrW6C2Yo90PAukV7hvdXclw2qpCRGuflOT54_Sk3LbI-Yq5LSpLOf6C6XvHqWU8TE2VgIux4P_hAVu2sLvZqV2jclaNW5NhiZwPDufsuYztpolj8gwawvCKxnyMJHwR-kpGLYWNeFTNZxJpwaxLZyGzOThXOcv8IOg19Im6tNrh24wpYZb4n1V8Sspf-jZC3A-yIMxGE_zz2PXR05LkiI8xchTnrheCETZFW3GOWA89BIe5W0f4qmsAnV0GB8LcNatwCdfFvgBuld7fTEN0CmE6zQz9dlSTCtj5twyxrRWRoneX3uycMIDjMrxMKyC5nXlZfpweqtR9E0aZorE1TTkLN_yJGbF-W11sE6iq7bxUMezciZnq5g-C_JhABV8GTf71Hlgc0jqPN0boiG8g1-JjhHKYKDk9RmdQC9d8hfw7poMM1EMiyOPu-80Z2oqUbKt50q1U3_oIOM88nzilhM9Ux3LvfQwN37_8eOfz93PJhlwMv--XY6OEEc_AYYzcvboih8qaRkQE1qK-xluoURcIfdks8wGLRu8NO6GW_fWlNQ9D2HRwjJwPrXAh0MLdEp2n5q5g3HrrBOAj6mRzGcpWdZyyIzmAY1YmpWej2mlPzQtn7jvSomW47mMHYE96IkDOe4wVZgdOY6XCABHTcdDRd-73EPFKen54LkhgDtTi4UCr6blhBmZJx0GCzb7VCmJyuxx88XQXTsSPS-AC9oz0eKrxq4cywSezjx9Cutd8AtPiMOtYemnhZEfyPET7zLZGy5ArcZJFt-wsSpBWjk78t-B5mbr5RbXfWDMGT3kxYKc0iIPqVx0IN7VPbQD5RGzma6T95llynPZXchtjmm-eDWDb03aUOY6VZ8aEZ-c7gdhLwb6GT0bKNZORkGcR-Ip7UT0mDmbyI2e24O0tbWoBy8APh1T2MPS5UG1kTGmjrsdhQpKfVdyeNJ1xQ_hWLGT7iv-YXT063krgeuSVHtgM1SQ1AvGca620VRa7XE0lx0pgP_VWiaev1rLktk1H5aTRiNdPCq-SRpyvzjqtdyr0POI-7DD7ATwyRedZPbw8KQdEDZeTWYOAG_prfh6sfPiI5PLa8x3OAnUeq06rnNDAoh879kuP5PJPXPfNPU8vt1rFfN3DAiyJCbMjJ7JnKCBxLUf-M60TOstQ4selWFahK4k0X5_38WlZswzTagwT1ub-XpwRR7IWgaOiVegU44W-Dw2lEGqGr5IBnk_9cB3b78LDTzm1EZMBcFK3OWOAeN7rR6IW05r6bF1xzCkJrmYtv6b-AqSwiusIXeZ6Y0BvMCjeTv8gQZaNHzP9CVvt2gkF_g6F_oDPeqJjgOPgeNBM6W3AfpCXrd4hZY7UfkG8tp2x_HwgSf3w4NkBhaOkG8YW3LkTbnkOEevJ8Pk4imCcvHt-5FcWrwhmBHq-E3ujXN543CQ7JVi7qs5UG81-4jRX1FwK74x3Q_SFuBsS4FPVhT4ONDi37fPOfvHu8kmnsPhRqouXx8fPMdh0dXXPNj08JrY29bcd9aHvM8vd_M6fyL0TCXvZQAqqxOzSfJLwvBFh6ccL8WVN9q2RtdSbsxu-UYDf_BV1S6sncNdZ1demOxzR7n9H5QeLEo=";
          "browser.download.dir" = "${config.home.homeDirectory}/Downloads";
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf_-browser-action","sponsorblocker_ajay_app-browser-action","firefoxcolor_mozilla_com-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","gdpr_cavi_au_dk-browser-action","ff2mpv_yossarian_net-browser-action","hltv-fantasy-values_zzzealed-browser-action","nixpkgs-pr-tracker_tahayassine_me-browser-action","redirector_einaregilsson_com-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"nav-bar":["reset-pbm-toolbar-button","sidebar-button","glide-toolbar-mode-button","back-button","forward-button","stop-reload-button","customizableui-special-spring3","urlbar-container","customizableui-special-spring4","vertical-spacer","downloads-button","adnauseam_rednoise_org-browser-action","addon_darkreader_org-browser-action","addon_karakeep_app-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","developer-button","screenshot-button","firefoxcolor_mozilla_com-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","adnauseam_rednoise_org-browser-action","gdpr_cavi_au_dk-browser-action","addon_darkreader_org-browser-action","ff2mpv_yossarian_net-browser-action","hltv-fantasy-values_zzzealed-browser-action","addon_karakeep_app-browser-action","nixpkgs-pr-tracker_tahayassine_me-browser-action","redirector_einaregilsson_com-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action","sponsorblocker_ajay_app-browser-action","_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action","_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action","_3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action"],"dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","PersonalToolbar","unified-extensions-area","toolbar-menubar"],"currentVersion":23,"newElementCount":7}
          '';

          # History/cookies
          "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
          "privacy.clearOnShutdown_v2.cache" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown_v2.formdata" = true;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
          "privacy.clearOnShutdown_v2.siteSettings" = false;

          # Firefox, the AI-first browser
          "browser.ai.control.default" = "blocked";
          "browser.ai.control.pdfjsAltText"	= "blocked";
          "browser.ai.control.sidebarChatbot"	= "blocked";
          "browser.ai.control.smartTabGroups"	= "blocked";
          "browser.ai.control.translations" = "blocked";

          # https://github.com/elFarto/nvidia-vaapi-driver#firefox
          "media.ffmpeg.vaapi.enabled" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          "media.rdd-process.enabled" = true;
          "media.av1.enabled" = false;
          "gfx.x11-egl.force-enabled" = true;
          "widget.dmabuf.force-enabled" = true;
        };        
      };
    };
  };
  stylix.targets.glide-browser = {
    profileNames = [ "mads" ];
    enable = true;
    colorTheme.enable = true;
    #firefoxGnomeTheme.enable = true;
  };
}
