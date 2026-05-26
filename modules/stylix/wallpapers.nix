{ pkgs, ... }:
let
  fetchurl = pkgs.fetchurl;
in
{
  # NixOS
  nixos = {
    black = fetchurl {
      url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
      hash = "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
    };
    white = fetchurl {
      url = "https://w.wallhaven.cc/full/e7/wallhaven-e7djlk.png";
      hash = "sha256-EMSD1XQLaqHs0NbLY0lS1oZ4rKznO+h9XOGDS121m9c=";
    };
    dark = fetchurl {
      url = "https://w.wallhaven.cc/full/2y/wallhaven-2y2wg6.png";
      hash = "sha256-nFoNfk7Y/CGKWtscOE5GOxshI5eFmppWvhxHzOJ6mCA=";
    };
  };
  # The Quintessential Quintuplets bride covers mix
  # https://reddit.com/r/5ToubunNoHanayome/comments/d5znfx/my_quintuplets_wallpaper_the_final_version_of_the/
  quintuplets-bride = {
    v1 = fetchurl {
      url = "https://files.catbox.moe/0amxzg.png";
      hash = "sha256-cY0GyV5q1WknPUZtbb8cvsQoeOthhg2LRpxvUuntT+Q=";
    };
    v2 = fetchurl {
      url = "https://files.catbox.moe/ku2nj1.png";
      hash = "sha256-splVQH4OyTQ7c90zEOS+lcluiXUHvCNDPwoJmTzttVg=";
    };
    v3 = fetchurl {
      url = "https://files.catbox.moe/rj4ip5.png";
      hash = "sha256-8GEri7X+H6uKeVsrhUhNaDnpAk2NO+T03kUoYMEPhLA=";
    };
    v4 = fetchurl {
      url = "https://files.catbox.moe/n3t89y.png";
      hash = "sha256-QCxjgKGaFPlZ8iT5E64RKGfiCT7z51eQzyB2esnIRbw=";
    };
  };
  # Phaethon
  phaethon = fetchurl {
    url = "https://w.wallhaven.cc/full/8g/wallhaven-8g5w52.png";
    hash = "sha256-z9KVl3hYQmmyGkPU8lnM5mTBbEiPbhysUb6oEVO7reA=";
  };
}
