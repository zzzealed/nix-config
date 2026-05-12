# A shell that bootstraps flake support
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  inherit (lock.nodes.nixpkgs.locked) rev narHash;
  pkgs =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
        sha256 = narHash;
      })
      {
        config = {
          allowUnfree = true;
        };
      };
in
pkgs.mkShell {
  # Enable experimental features without having to specify the argument
  NIX_CONFIG = "experimental-features = nix-command flakes";
  packages = with pkgs; [
    nix
    home-manager
    git
    vim
    nixos-rebuild-ng
  ];
}
