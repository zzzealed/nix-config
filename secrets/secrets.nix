let
  # Inside `/etc/ssh`
  root_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEU3Cy4L/zlUm3lJmVbeN5XnnKA1us4incL+d6JH4Dg9 root@nixos";
  root_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/rJS1hRE1N7E7B52yBPb1fkDwWaP6oYtF+3/ArdK8l root@nixos";
  root_pi-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzXNbSFzEjnQS+8D3guVv1UedC2E9EK0MZLaBDXMe+c root@example";
  root_vps-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGQzGmZC5c7kFKe/GcHNNuvhF6uFOh8ZYG0H1mb6luL/ root@instance-20260423-1921";
  decodingKeys = [
    root_desktop-nixos
    root_server-nixos
    root_pi-nixos
    root_vps-nixos
  ];

  mads_desktop-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0bskvLTrkiFLQeS4K1uc8EwNGXrCcigrRZa/dPcycI mads@desktop-nixos";
  mads_server-nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo+0J8abiPou6UWCuolKS0RriZ5zAYrgV2zdgIYTuQ5 mads@server-nixos";
  interactiveKeys = [
    mads_desktop-nixos
    mads_server-nixos
  ];

  defaults = {
    armor = true;
  };

  secrets = {
    "mads-password.age".publicKeys = decodingKeys ++ interactiveKeys;
    "searx-secret_key.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "glance-weather_location.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "glance-custom-api_kredslob_skrald.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "hbd-wireguard_config-1.age".publicKeys = decodingKeys ++ interactiveKeys;
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
    "server-nixos_ddclient_config.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "hbd-ftps_rclone-config.age".publicKeys = decodingKeys ++ interactiveKeys;
    "phone-nix_wireguard_config.age".publicKeys = interactiveKeys;
    "linus-password.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "gatus_environment-file.age".publicKeys = [ root_vps-nixos ] ++ interactiveKeys;
    "vps-nixos_wireguard_config.age".publicKeys = [ root_vps-nixos ] ++ interactiveKeys;
    "vps-nixos_ddclient_config.age".publicKeys = [ root_vps-nixos ] ++ interactiveKeys;
    "desktop-nixos_wireguard_config.age".publicKeys = [ root_desktop-nixos ] ++ interactiveKeys;
    "harmonia_sign-key.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
    "forgejo_nix-config_token-file.age".publicKeys = [ root_server-nixos ] ++ interactiveKeys;
  };
in
builtins.mapAttrs (_name: value: defaults // value) secrets
