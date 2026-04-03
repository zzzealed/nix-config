{ flakeInputs, ... }:
{
  nixpkgs.overlays = [
    (final: _prev: {
      nur = import flakeInputs.nur {
        nurpkgs = final;
        pkgs = final;  # some NUR repos also want `pkgs`
      };
    })
  ];
}
