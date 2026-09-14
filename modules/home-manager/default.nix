{
  hosts,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  environment.systemPackages = [ pkgs.home-manager ];
  home-manager = {
    useGlobalPkgs = true; # Apparently deprecated?
    extraSpecialArgs = { inherit inputs hosts; };
    backupFileExtension = "bak";
    users.mads.home.stateVersion = "24.11";
  };
}
