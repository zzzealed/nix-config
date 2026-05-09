{
  pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  },
}:

pkgs.mkShell {
  packages = with pkgs; [
    nodejs
  ];
  shellHook = ''
    alias p:serve="php -S localhost:8000"
  '';
}
