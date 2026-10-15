{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.unstable.river ];
  # TODO: river -c untitled-wm
}
