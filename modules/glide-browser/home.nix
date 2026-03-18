{  inputs, pkgs, ... }:
{
  imports = [
    inputs.glide.homeModules.default
    inputs.agenix.homeManagerModules.default
  ];

  programs.glide-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.ff2mpv ];
    policies = {
      EnableTrackingProtection = true;
    };
    languagePacks = [
      "en-us"
      "da-dk"
      "es-es"
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
              url = "https://glance.l.zzzealed.com";
            }
            {
              name = "JetKVM";
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
             # Enhancer
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
             # YouTube Watch Later
#          ];
        };
        search = {
          force = true;
          engines = {
            "SearXNG" = {
              urls = [ { template = "https://searx.l.zzzealed.com/search?q={searchTerms}"; } ];
              definedAliases = [ "@searx" ];
            };
          };
          default = "SearXNG";
        };
        settings = {
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
          "browser.startup.homepage" = "https://searx.l.zzzealed.com/preferences?preferences=eJx1WEuzo7oR_jXxhorr3kwqqSy8SlW2SdW9e0pIDfQg1Bw9bHN-fVoITGM8i-MZPolWv_sTWkXoyCOEWwcOvLIXq1yXVAc3lSJdLGll4Qbukh81jZOFCLdLq-6oydUeAtk7-NsFR36pnjw959t_lA1wGSH2ZG7_--8ff16CaiGA8rq__XaJPYxwC5iFXVhCsjHULMzBo46qWV83hLt4Uvx4Jd9dymt1iLNdddTgIvhaWezcyP9f31fmrpwGU6_nFvQrgZ9rdHXEyAL-9AkuZUPWQBd_zPyOBR3Lck9xgDncDLSKVb0kb-uW_KhiRNfd2mTtxWBQjeXDwHXo2J0__vHbKrZePfuXv_37BVZ3NEChrsu_vPSvTnV1HUijstUIBhWDSrfJiU3shAaqwIEY6npx-Bta5H5-o1LJIK-NKaDOS3ZiTSuLLj2rSekhi2OxMa85p0KVNcU71HWLtpzkgqpzmJaHaahG9J682DBxbCr-zUf6w5uK08WoVb7DJ4XqgQNuB_qIWtrkY4gqIsdEgGGQ3mwUmnQCqrJdvFbgQWG7Hd9g1H2KIBzFUJP0AHHbMjUH0dFg1-32LBG6aq2vRkrRSvdzxaa9-VN7CsFDyxHWCJyVBXuYO3LOi3NmmN4ez_ZkMMfgFQkD8M0F8IqsgcV3vIG41HxGTFdx-qLD7NIgj2BtZm3pnKzA-qERMtg9-a-jt9N3_AEqb97fKfkwqom382-WOtJPnLL39l1cRjCDPPv3p7C3NZ6yIpvvWw-c0tTGh_JQGfRcqblmi6tbj25AJZOpnZ2R0tt5FnZ1gN899waBcGtQzRY6MtCA79ZHXgMOPI3bM5HxoIx8nahjqyer5lwKYddcrozEsZcdgPsJ-Fz9ubHKePeq8Sr_rEf2nFvgSwwKAM9XnrGQcM1lvjyjrSYK8RWrPnXcnrpWadje3ZHKqKgCxPBhKXBCv7IZR9Ps5qJTwgqOrecsm4X--IUzii0_MfS0v2-RzfNzleMTUHhrW6C2Yo90PAukV7hvdXclw2qpCRGuflOT54_Sk3LbI-Yq5LSpLOf6C6XvHqWU8TE2VgIux4P_hAVu2sLvZqV2jclaNW5NhiZwPDufsuYztpolj8gwawvCKxnyMJHwR-kpGLYWNeFTNZxJpwaxLZyGzOThXOcv8IOg19Im6tNrh24wpYZb4n1V8Sspf-jZC3A-yIMxGE_zz2PXR05LkiI8xchTnrheCETZFW3GOWA89BIe5W0f4qmsAnV0GB8LcNatwCdfFvgBuld7fTEN0CmE6zQz9dlSTCtj5twyxrRWRoneX3uycMIDjMrxMKyC5nXlZfpweqtR9E0aZorE1TTkLN_yJGbF-W11sE6iq7bxUMezciZnq5g-C_JhABV8GTf71Hlgc0jqPN0boiG8g1-JjhHKYKDk9RmdQC9d8hfw7poMM1EMiyOPu-80Z2oqUbKt50q1U3_oIOM88nzilhM9Ux3LvfQwN37_8eOfz93PJhlwMv--XY6OEEc_AYYzcvboih8qaRkQE1qK-xluoURcIfdks8wGLRu8NO6GW_fWlNQ9D2HRwjJwPrXAh0MLdEp2n5q5g3HrrBOAj6mRzGcpWdZyyIzmAY1YmpWej2mlPzQtn7jvSomW47mMHYE96IkDOe4wVZgdOY6XCABHTcdDRd-73EPFKen54LkhgDtTi4UCr6blhBmZJx0GCzb7VCmJyuxx88XQXTsSPS-AC9oz0eKrxq4cywSezjx9Cutd8AtPiMOtYemnhZEfyPET7zLZGy5ArcZJFt-wsSpBWjk78t-B5mbr5RbXfWDMGT3kxYKc0iIPqVx0IN7VPbQD5RGzma6T95llynPZXchtjmm-eDWDb03aUOY6VZ8aEZ-c7gdhLwb6GT0bKNZORkGcR-Ip7UT0mDmbyI2e24O0tbWoBy8APh1T2MPS5UG1kTGmjrsdhQpKfVdyeNJ1xQ_hWLGT7iv-YXT063krgeuSVHtgM1SQ1AvGca620VRa7XE0lx0pgP_VWiaev1rLktk1H5aTRiNdPCq-SRpyvzjqtdyr0POI-7DD7ATwyRedZPbw8KQdEDZeTWYOAG_prfh6sfPiI5PLa8x3OAnUeq06rnNDAoh879kuP5PJPXPfNPU8vt1rFfN3DAiyJCbMjJ7JnKCBxLUf-M60TOstQ4selWFahK4k0X5_38WlZswzTagwT1ub-XpwRR7IWgaOiVegU44W-Dw2lEGqGr5IBnk_9cB3b78LDTzm1EZMBcFK3OWOAeN7rR6IW05r6bF1xzCkJrmYtv6b-AqSwiusIXeZ6Y0BvMCjeTv8gQZaNHzP9CVvt2gkF_g6F_oDPeqJjgOPgeNBM6W3AfpCXrd4hZY7UfkG8tp2x_HwgSf3w4NkBhaOkG8YW3LkTbnkOEevJ8Pk4imCcvHt-5FcWrwhmBHq-E3ujXN543CQ7JVi7qs5UG81-4jRX1FwK74x3Q_SFuBsS4FPVhT4ONDi37fPOfvHu8kmnsPhRqouXx8fPMdh0dXXPNj08JrY29bcd9aHvM8vd_M6fyL0TCXvZQAqqxOzSfJLwvBFh6ccL8WVN9q2RtdSbsxu-UYDf_BV1S6sncNdZ1demOxzR7n9H5QeLEo=";
        };        
      };
    };
  };
  stylix.targets.glide-browser = {
    profileNames = [ "mads" ];
    enable = true;
    colorTheme.enable = true;
  };
}
