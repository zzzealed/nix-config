{ pkgs, ... }:
{
  boot.loader.limine = {
    enable = true;
    package = pkgs.limine;
    # Windows dual-boot
    extraEntries = ''
      /Windows 11
          protocol: efi_chainload
          image_path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
}
