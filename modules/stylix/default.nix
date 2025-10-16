{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/danqing-light.yaml";
    image = ./config/wallhaven-rr5rq7_1920x1080.png;
#    fonts = { # TODO
#      emoji = {
#        name = "";
#        package = "";
#      };
#    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    icons.enable = true;
    #polarity = "dark";
    polarity = "light";
    opacity.popups = "0.75";
 };
}
