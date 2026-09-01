{ inputs, pkgs, ... }:
let
  # Helper to add both my own local and externally fetched Fish-functions.
  functions = pkgs.symlinkJoin {
    name = "fish-functions";
    paths = [
      # `./config/functions` first so files in there takes priority
      ./config/functions
      "${inputs.fish-helix}/functions"
    ];
  };
in
{
  home.file.".config/fish" = {
    source = ./config;
    recursive = true;
  };
  home.file.".config/fish/functions" = {
    source = functions;
    recursive = true;
  };
}
