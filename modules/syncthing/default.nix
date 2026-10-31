{ config, ... }:
let
  isWsl = config.wsl.enable or false;
  winHome = "/mnt/c/Users/mads";
in
{
  age.secrets = {
    syncthing-key.file = ../../secrets/syncthing/${config.networking.hostName}-key.age;
    syncthing-cert.file = ../../secrets/syncthing/${config.networking.hostName}-cert.age;
  };

  services.syncthing = {
    enable = true;
    user = "mads";
    # Generate with `syncthing --home /tmp/syncthing-keygen`
    key = config.age.secrets."syncthing-key".path;
    cert = config.age.secrets."syncthing-cert".path;
    openDefaultPorts = true; # Not actually webui's port
    guiAddress = "127.0.0.1:8384";
    settings = {
      options.urAccepted = -1;
      gui = {
        user = "mads";
        # `mkpasswd --method=bcrypt`
        password = "$2b$05$Jfj3ddKNjhy3yp21HCFBrOW9/VHsysx1qp/gSJHeXgZ0d.q4e1iCG";
      };
      devices = {
        "srv1".id = "OOK47Z3-ORH37U5-5KONJ3H-G3F47V7-OGMYWG7-SAGEXH5-LYZZPNQ-4LPBDQG";
        "desktop1".id = "MBQLFZN-LK6GGWC-7XZVWMV-FGODFIK-QVD4YCU-TBEAHON-4U43M5A-V6WKKQ5";
        "rpi1".id = "DY7GEVN-GMKJWDA-4NP4U66-4EB5UBN-3TEELCJ-Y3MALUM-D3ENBN6-44642Q4";
        "vps1".id = "GLBBBVC-A3OWVRK-2XCOKR2-YGLICMN-I3OVB5O-CG6BTZW-2B2NO5Z-BZOX5QV";
        "laptop1".id = "MA26Z4O-F5NTLOF-NHTLYS6-F3QAIGF-I3JIH6E-IZBK5ZX-PIXVFTW-VA3IQQC";
        "phone1".id = "23NK2MQ-XK5ULNB-HVCHOVR-VDBHGCP-UON2HH7-RDMEI2O-Y4ADPKF-VH23XAQ";
        "kindle1".id = "6WV3W3S-BUQVI4S-575SGUP-65JXNQX-43ASGG3-CRO74AS-DPEQ7XJ-6NERLAK"; # Via KOReader plugin
      };
      folders = {
        "sync" = {
          label = "Sync";
          path = "~/Sync";
          devices = [
            "srv1"
            "desktop1"
            "rpi1"
            "vps1"
            "laptop1"
            "phone1"
            "kindle1"
          ];
        };
        "aau" = {
          label = "AAU";
          path = if isWsl then "${winHome}/Documents/AAU" else "~/Documents/AAU";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
          ];
        };
        "books" = {
          label = "Books";
          path = if isWsl then "${winHome}/Documents/Books" else "~/Documents/Books";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
            "kindle1"
          ];
        };
        "projects" = {
          label = "Projects";
          path = "~/Documents/Projects";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
          ];
        };
        "fish" = {
          label = "Fish state";
          path = "~/.local/share/fish";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
          ];
        };
        "gomi" = {
          label = "Gomi trash";
          path = "~/.local/share/Trash";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
          ];
        };
        "mpv" = {
          label = "MPV watch-later files";
          path =
            if isWsl then "${winHome}/AppData/Local/mpv/watch_later" else "~/.local/state/mpv/watch_later";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
          ];
        };
        "nix-config" = {
          label = "nix-config";
          path = "~/nix-config";
          devices = [
            "srv1"
            "desktop1"
            "rpi1"
            "vps1"
            "laptop1"
            "phone1"
          ];
        };
        "opencode" = {
          label = "OpenCode state";
          path = "~/.local/share/opencode/";
          devices = [
            "srv1"
            "desktop1"
            "laptop1"
          ];
        };
      };
    };
  };
}
