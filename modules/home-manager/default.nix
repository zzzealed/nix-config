{ flakeInputs, flakeOutputs, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit flakeInputs flakeOutputs; };
    backupFileExtension = "bak";
    users.mads.home.stateVersion = "24.11";
  };
}
