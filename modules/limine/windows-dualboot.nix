{ ... }:
{
  boot.loader.limine.extraEntries = ''
    /Windows 11
      protocol: efi_chainload
      image_path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';
}
