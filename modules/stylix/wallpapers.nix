{ pkgs, ... }:
let
  fetchurl = pkgs.fetchurl;
in
{
  # NixOS
  nixos-dark = fetchurl {
    url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
    hash = "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
  };
  nixos-light = fetchurl {
    url = "https://w.wallhaven.cc/full/e7/wallhaven-e7djlk.png";
    hash = "sha256-EMSD1XQLaqHs0NbLY0lS1oZ4rKznO+h9XOGDS121m9c=";
  };
  # The Quintessential Quintuplets bride covers mix
  # https://reddit.com/r/5ToubunNoHanayome/comments/d5znfx/my_quintuplets_wallpaper_the_final_version_of_the/
  quintuplets-bride = fetchurl {
    url = "https://files.catbox.moe/0amxzg.png";
    hash = "sha256-cY0GyV5q1WknPUZtbb8cvsQoeOthhg2LRpxvUuntT+Q=";
  };
  # Phaethon
  phaethon = fetchurl {
    url = "https://w.wallhaven.cc/full/8g/wallhaven-8g5w52.png";
    hash = "sha256-z9KVl3hYQmmyGkPU8lnM5mTBbEiPbhysUb6oEVO7reA=";
  };
}
