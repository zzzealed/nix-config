{ pkgs, ... }:
let
  # Template for fetching
  f = url: hash: pkgs.fetchurl { inherit url hash; };
in
{
  nix-nineish = {
    default = f "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-nineish.png?raw=true" "sha256-EMSD1XQLaqHs0NbLY0lS1oZ4rKznO+h9XOGDS121m9c=";
    dark-gray = f "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-nineish-dark-gray.png?raw=true" "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
    solarized-dark = f "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-nineish-solarized-dark.png?raw=true" "sha256-ZBrk9izKvsY4Hzsr7YovocCbkRVgUN9i/y1B5IzOOKo=";
    solarized-light = f "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-nineish-solarized-light.png?raw=true" "sha256-gb5s5ePdw7kuIL3SI8VVhOcLcHu0cHMJJ623vg1kz40=";
  };
  quintuplets-bride = {
    # https://reddit.com/r/5ToubunNoHanayome/comments/d5znfx/my_quintuplets_wallpaper_the_final_version_of_the/
    v1 = f "https://files.catbox.moe/0amxzg.png" "sha256-cY0GyV5q1WknPUZtbb8cvsQoeOthhg2LRpxvUuntT+Q=";
    v2 = f "https://files.catbox.moe/ku2nj1.png" "sha256-splVQH4OyTQ7c90zEOS+lcluiXUHvCNDPwoJmTzttVg=";
    v3 = f "https://files.catbox.moe/rj4ip5.png" "sha256-8GEri7X+H6uKeVsrhUhNaDnpAk2NO+T03kUoYMEPhLA=";
    v4 = f "https://files.catbox.moe/n3t89y.png" "sha256-QCxjgKGaFPlZ8iT5E64RKGfiCT7z51eQzyB2esnIRbw=";
  };
  phaethon = f "https://w.wallhaven.cc/full/8g/wallhaven-8g5w52.png" "sha256-z9KVl3hYQmmyGkPU8lnM5mTBbEiPbhysUb6oEVO7reA=";
  subnautica = f "https://w.wallhaven.cc/full/8o/wallhaven-8ogq21.jpg" "sha256-NeOFn7cv1KrcqY/XmI0h6Y0qsgWGnuw9C4aCgJXnOXM=";
  firewatch = {
    dark = f "https://w.wallhaven.cc/full/md/wallhaven-mdjrqy.jpg" "sha256-/d+zAl53Mn3f8sK8biThC0MevjXChmSN27rWEKSqPxo=";
    sunset = f "https://w.wallhaven.cc/full/95/wallhaven-95mxp8.png" "sha256-E+BZQScFwVzi6cuXCIMpzFco0uepmPS9g+rIUWAirb4=";
  };
  uzumaki = f "https://w.wallhaven.cc/full/kx/wallhaven-kxo91d.png" "sha256-l2HpNeleo8jmWNtMxxSIo1nHGdgjdc4BuCougF4loqY=";
}
