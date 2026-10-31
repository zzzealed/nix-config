{
  config,
  lib,
  pkgs,
  ...
}:
let
  winHome = "/mnt/c/Users/mads";
  winAppData = "${winHome}/AppData/Roaming";
  winConfig = "${winHome}/.config";
  wslHome = "${config.home.homeDirectory}";

  copyDir = source: target: ''
    run ${pkgs.coreutils}/bin/mkdir -p "${target}"
    run ${pkgs.rsync}/bin/rsync --archive --copy-links "${source}/" "${target}/"
  '';

  copyFile = source: target: ''
    run ${pkgs.coreutils}/bin/install -D --mode=644 "${source}" "${target}"
  '';
in
{
  home.activation.exportWindowsConfigs = lib.hm.dag.entryAfter [ "writeBoundary" ] (
    lib.concatStringsSep "\n" [
      (copyDir "${wslHome}/.config/mpv" "${winAppData}/mpv")

      (copyDir "${wslHome}/.config/helix" "${winAppData}/helix")

      (copyFile ./.wslconfig "${winHome}/.wslconfig")

      (copyFile "${wslHome}/.config/glide/glide.ts" "${winConfig}/glide/glide.ts")
      (copyFile "${wslHome}/.config/glide/glide/mads/user.js" "${winAppData}/Glide/glide/Profiles/mads/user.js")

      (copyFile "${wslHome}/.ssh/config" "${winHome}/.ssh/config")
    ]
  );
}
