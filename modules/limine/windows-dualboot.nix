{ ... }:
{
  boot.loader.timeout = 10; # 10 seconds before first entry getting booted
  boot.loader.limine.extraEntries = ''
    /Windows 11
      protocol: efi_chainload
      image_path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';
}
