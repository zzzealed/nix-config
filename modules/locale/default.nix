{ lib, ... }:
{
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = lib.mkDefault "da_DK.UTF-8";
  i18n.extraLocales = [ "en_US.UTF-8/UTF-8" "da_DK.UTF-8/UTF-8" "es_ES.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
    # Keep messages english, and UI?
    LC_MESSAGES = lib.mkDefault "en_US.UTF-8";
  };
}
