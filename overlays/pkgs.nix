{
  nixpkgs.overlays = [
    (final: prev: rec {
      glide-browser = prev.callPackage ../modules/glide-browser {};
    })
  ];
}
