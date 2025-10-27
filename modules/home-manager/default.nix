{ inputs, flakeInputs, flakeOutputs, pkgs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  environment.systemPackages = [ pkgs.home-manager ];
  home-manager = {
    #useGlobalPkgs = true; # Apparently deprecated?
    extraSpecialArgs = { inherit flakeInputs flakeOutputs inputs; };
    backupFileExtension = "bak";
    users.mads.home.stateVersion = "24.11";
  };
}
