{ ... }:
{
  boot.loader.timeout = 10; # 10 seconds before first entry getting booted
  boot.loader.limine.extraEntries = ''
    /Windows 11
      protocol: efi_chainload
      image_path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#System_time
  time.hardwareClockInLocalTime = true;
}
