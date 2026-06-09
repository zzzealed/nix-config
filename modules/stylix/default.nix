{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  wallpapers = import ./wallpapers.nix pkgs;
  # Themes: https://tinted-theming.github.io/tinted-gallery/
  # danqing-modified
  dark-scheme = ./config/danqing-modified.yaml;
  light-scheme = ./config/danqing-light-modified.yaml;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      glance.enable = false;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "NotoSans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "NotoSerif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      size = 24;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
    };
    opacity.popups = 0.90;

    # Default theme is dark
    image = lib.mkDefault wallpapers.nix-nineish.solarized-dark;
    base16Scheme = lib.mkDefault dark-scheme;
    polarity = lib.mkDefault "dark";
    icons.dark = lib.mkDefault "Papirus-Dark";
    cursor.name = lib.mkDefault "Bibata-Modern-Classic";
  };
  # A specialisation you can use on rebuild with `--specialistation light-theme`
  # See: https://wiki.nixos.org/wiki/Specialisation
  specialisation.light-theme.configuration = {
    environment.etc."specialisation".text = "light-theme"; # https://github.com/nix-community/nh#specialisations-support
    stylix = {
      image = lib.mkForce wallpapers.nix-nineish.solarized-light;
      base16Scheme = lib.mkForce light-scheme;
      polarity = lib.mkForce "light";
      icons.light = lib.mkForce "Papirus-Light";
      cursor.name = lib.mkForce "Bibata-Modern-Ice";
    };
  };
}
