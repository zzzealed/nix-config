{ config, ... }:
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
    settings = {
      gui = {
        user = "mads";
        # `mkpasswd --method=bcrypt`
        password = "$2b$05$Jfj3ddKNjhy3yp21HCFBrOW9/VHsysx1qp/gSJHeXgZ0d.q4e1iCG";
      };
      devices = {
        "server".id = "OOK47Z3-ORH37U5-5KONJ3H-G3F47V7-OGMYWG7-SAGEXH5-LYZZPNQ-4LPBDQG";
        "desktop".id = "MBQLFZN-LK6GGWC-7XZVWMV-FGODFIK-QVD4YCU-TBEAHON-4U43M5A-V6WKKQ5";
        "laptop".id = "MA26Z4O-F5NTLOF-NHTLYS6-F3QAIGF-I3JIH6E-IZBK5ZX-PIXVFTW-VA3IQQC";
        "phone".id = "23NK2MQ-XK5ULNB-HVCHOVR-VDBHGCP-UON2HH7-RDMEI2O-Y4ADPKF-VH23XAQ";
        "kindle".id = "6WV3W3S-BUQVI4S-575SGUP-65JXNQX-43ASGG3-CRO74AS-DPEQ7XJ-6NERLAK"; # Via KOReader plugin
      };
      folders = {
        "mpv-watch-later" = {
          label = "MPV watch-later files";
          path = "~/.local/state/mpv/watch_later";
          devices = [
            "server"
            "desktop"
            "laptop"
            "phone"
          ];
        };
        "aau" = {
          label = "AAU";
          path = "~/Documents/AAU";
          devices = [
            "server"
            "desktop"
            "laptop"
            "phone"
          ];
        };
        "books" = {
          label = "Books";
          path = "~/Documents/Books";
          devices = [
            "server"
            "desktop"
            "laptop"
            "kindle"
          ];
        };
      };
    };
  };
}
