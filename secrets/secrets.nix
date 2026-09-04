let
  # Inside `/etc/ssh`
  root_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEU3Cy4L/zlUm3lJmVbeN5XnnKA1us4incL+d6JH4Dg9 root@nixos";
  root_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/rJS1hRE1N7E7B52yBPb1fkDwWaP6oYtF+3/ArdK8l root@nixos";
  root_pi-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzXNbSFzEjnQS+8D3guVv1UedC2E9EK0MZLaBDXMe+c root@example";
  root_vps-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQzGmZC5c7kFKe/GcHNNuvhF6uFOh8ZYG0H1mb6luL/ root@instance-20260423-1921";
  root_laptop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4tKknECJ43CH0oelw/zgEIfEGwqQjAxfsIEWr73SD9 root@nixos";
  decodingKeys = [
    root_desktop-nixos
    root_server-nixos
    root_pi-nixos
    root_vps-nixos
    root_laptop-nixos
  ];

  mads_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos";
  mads_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos";
  mads_laptop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICSX+uG+W5BIhlcO+kd39ngmRVtOtJirGO5oBlkZuopO mads@nixos";
  nix-on-droid_phone-droid = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAjVJSt549ILg+pVz7g+tiOT0dGBg/VWZL9+UGjFz8rr nix-on-droid@localhost";
  interactiveKeys = [
    mads_desktop-nixos
    mads_server-nixos
    mads_laptop-nixos
    nix-on-droid_phone-droid
  ];

  secrets = {
    "mads-password.age".publicKeys = decodingKeys ++ interactiveKeys;
    "searx-secret_key.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "glance-weather_location.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "glance-custom-api_kredslob_skrald.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "porkbun-nginx_api_key.age".publicKeys = [
      root_server-nixos
      root_vps-nixos
    ]
    ++ interactiveKeys;
    "porkbun-nginx_api_secret.age".publicKeys = [
      root_server-nixos
      root_vps-nixos
    ]
    ++ interactiveKeys;
    "changedetection-io_api_key.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "pihole-app_password.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "changedetection-io_rss.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "glance-releases-token_github.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "phone-nix_wireguard_config.age".publicKeys = interactiveKeys;
    "linus-password.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "gatus_environment-file.age".publicKeys = [
      root_server-nixos
      root_vps-nixos
    ]
    ++ interactiveKeys;
    "harmonia_sign-key.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "github_nix-config_token-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "pr-tracker_github-token.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "karakeep_environment-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "speedtest-tracker_app-key-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "samba-secrets.age".publicKeys = [ root_desktop-nixos ] ++ interactiveKeys;

    # Authelia
    "authelia_jwt-secret-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "authelia_storage-encryption-key-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "authelia_oidc-hmac-secret-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "authelia_oidc-issuer-private-key-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;

    # ddclient
    "server-nixos_ddclient_config.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "pi-nixos_ddclient_config.age".publicKeys = [ root_pi-nixos ] ++ interactiveKeys;
    "vps-nixos_ddclient_config.age".publicKeys = [ root_vps-nixos ] ++ interactiveKeys;

    # Wireguard
    "wireguard-server_private-key-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "desktop-server_private-key-file.age".publicKeys = [ root_desktop-nixos ] ++ interactiveKeys;
    "pi-server_private-key-file.age".publicKeys = [ root_pi-nixos ] ++ interactiveKeys;
    "vps-server_private-key-file.age".publicKeys = [ root_vps-nixos ] ++ interactiveKeys;
    "laptop-server_private-key-file.age".publicKeys = [ root_laptop-nixos ] ++ interactiveKeys;
    "phone-server_private-key-file.age".publicKeys = interactiveKeys;

    # Proton VPN
    "desktop-proton_private-key-file.age".publicKeys = [ root_desktop-nixos ] ++ interactiveKeys;
    "server-proton_private-key-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "laptop-proton_private-key-file.age".publicKeys = [ root_laptop-nixos ] ++ interactiveKeys;

    "eduroam-environment-file.age".publicKeys = [ root_laptop-nixos ] ++ interactiveKeys;
    "nix_builder_key.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
  };

  defaults = {
    armor = true;
  };
in
builtins.mapAttrs (_name: value: defaults // value) secrets
