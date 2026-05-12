{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: _prev: {
      nur = import inputs.nur {
        nurpkgs = final;
        pkgs = final; # some NUR repos also want `pkgs`
      };
    })
  ];
}
