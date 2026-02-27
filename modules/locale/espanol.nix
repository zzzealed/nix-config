{ lib, ... }:
{
  i18n.defaultLocale = lib.mkForce "es_ES.UTF-8";
  i18n.extraLocaleSettings.LC_MESSAGES = lib.mkForce "es_ES.UTF-8";
}
