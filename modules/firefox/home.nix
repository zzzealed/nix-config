{ ... }:
{
  programs.firefox.profiles = {
    mads = {
      settings = ./config/user.js;
#      extensions = {
#        packages = with pkgs.nur.repos.rycee.firefox-addons; [
#          ublock-origin
#          bitwarden
#          darkreader
#          private-grammar-checker-harper
#          sponsorblock
#          return-youtube-dislikes
#        ];
#      };
#     };
    };
  };
}
