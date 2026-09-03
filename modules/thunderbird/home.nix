{ pkgs, ... }:
{
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird;
    languagePacks = [
      "en-US"
      "da"
    ];
    settings = {
      "intl.regional_prefs.use_os_locales" = true;
    };
    profiles."mads" = {
      isDefault = true;
    };
  };

  accounts = {
    calendar.accounts."Personal" = {
      primary = true;
      remote = {
        type = "caldav";
        url = "https://radicale.l.zzzealed.com/mads/ce920a41-e0f3-6f31-a4d7-b3d20ac78a67/";
        userName = "mads";
      };
      thunderbird = {
        enable = true;
        color = "#000000";
        profiles = [ "mads" ];
      };
    };
    email.accounts."Personal" = {
      primary = true;
      address = "mads@mhjensen.com";
      realName = "Mads H. Jensen";
      userName = "mads@mhjensen.com";
      smtp = {
        host = "smtp.porkbun.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };
      imap = {
        host = "imap.porkbun.com";
        port = 993;
        tls.enable = true;
      };
      thunderbird = {
        enable = true;
        profiles = [ "mads" ];
      };
    };
  };
}
