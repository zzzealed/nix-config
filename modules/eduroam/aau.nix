{ config, ... }:
let
  interface = "wlp2s0";
in
{
  age.secrets."eduroam-environment-file".file = ../../secrets/eduroam-environment-file.age;
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.age.secrets."eduroam-environment-file".path ];
    profiles."eduroam" = {
      connection = {
        id = "eduroam";
        type = "wifi";
        interface-name = interface;
      };
      wifi = {
        mode = "infrastructure";
        ssid = "eduroam";
      };
      wifi-security.key-mgmt = "wpa-eap";
      "802-1x" = {
        eap = "peap";
        phase2-auth = "mschapv2";
        identity = "$AAU_LAPTOP_USER";
        password = "$AAU_LAPTOP_PASS";
        ca-cert = ./aau_wi-fi_root_ca.crt;
        altsubject-matches = "DNS:wifi.aau.dk";
      };
      ipv4.method = "auto";
      ipv6.method = "auto";
    };
  };
}
