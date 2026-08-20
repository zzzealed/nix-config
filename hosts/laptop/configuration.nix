{ ... }:
{
  imports = [
    ../../modules/limine
    ../../modules/limine/windows-dualboot.nix
    ../../modules/ly
    ../../modules/niri
    ../../modules/pipewire
    ../../modules/playerctl
    ../../modules/networking/firewall.nix
    ../../modules/networking/networkmanager.nix
    ../../modules/networking/nameservers.nix
    ../../modules/users/mads.nix
    ../../modules/cli-tools
    ../../modules/fish
    ../../modules/nh
    ../../modules/git
    ../../modules/bluetooth
    ../../modules/home-manager
    ../../modules/openssh
    ../../modules/locale
    ../../modules/stylix
    ../../modules/bash
    ../../modules/wireguard
    ../../modules/nix-gc
    ../../modules/zmx
    ../../modules/nix-index-database
  ];
  home-manager.users.mads = {
    home.file.".config/mpv/host.conf".source = ../../modules/mpv/config/desktop-nixos.conf;
    imports = [
      ../../modules/waybar/home.nix
      ../../modules/fuzzel/home.nix
      ../../modules/dunst/home.nix
      ../../modules/swaylock/home.nix
      ../../modules/wpaperd/home.nix
      ../../modules/ghostty/home.nix
      ../../modules/fish/home.nix
      ../../modules/bat/home.nix
      ../../modules/glide-browser/home.nix
      ../../modules/mpv/home.nix
      ../../modules/git/home.nix
      ../../modules/helix/home.nix
      ../../modules/niri/home.nix
      ../../modules/stylix/home.nix
      ../../modules/btop/home.nix
      ../../modules/legcord/home.nix
      ../../modules/yazi/home.nix
      ../../modules/opencode/home.nix
      ../../modules/thunderbird/home.nix
      ../../modules/lan-mouse/home.nix
    ];
  };

  # State
  system.stateVersion = "26.05";
}
