{ flakeInputs, ... }:
{
  nixpkgs.overlays = [
    (final: _prev: {
      unstable = import flakeInputs.nixpkgs-unstable {
        config.allowUnfree = true; # This is a different nixpkgs instance so we need to pass this again
        system = final.system;
      };
    })
  ];
}
