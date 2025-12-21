{ inputs, pkgs, ... }:
{
   environment.systemPackages = [ inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher ];
#  environment.systemPackages = with pkgs; [
#  (prismlauncher.override {
#    # Add binary required by some mod
#    additionalPrograms = [ ffmpeg ];
#
#    # Change Java runtimes available to Prism Launcher
#    jdks = [
#      graalvmPackages.graalvm-ce
#      zulu8
#      zulu17
#      zulu
#    ];
#  })
#  ];
}
