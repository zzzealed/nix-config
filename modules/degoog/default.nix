{ inputs, ... }:
{
  imports = [
    inputs.degoog.nixosModules.default
    # TODO
    # ./proxy.nix
    # ./status.nix
  ];
  services.degoog = {
    enable = true;
    # environmentFile = ""; # TODO
    configurePostgres = true;
    environment = {
      DEGOOG_BIND_ADDRESS = "127.0.0.1";
      DEGOOG_PORT = 4444;
      DEGOOG_WIZARD = false;
      DEGOOG_PUBLIC_INSTANCE = true;
      DEGOOG_DANGEROUSLY_NO_PASSWORD = false;
    };
  };
}
