{ pkgs, ... }:
let
  # Bubblewrap OpenCode
  # I've watched "Age of Ultron"
  opencode-bubblewrapped = pkgs.writeShellApplication {
    name = "opencode";
    runtimeInputs = [
      pkgs.bubblewrap
      pkgs.unstable.opencode
    ];
    # This is the best I cared to come up with
    text = ''
      mkdir -p "$HOME/.config/opencode"
      mkdir -p "$HOME/.local/share/opencode"
      mkdir -p "$HOME/.local/state/opencode"
      mkdir -p "$HOME/.cache/opencode"

      exec bwrap \
        --dev /dev \
        --proc /proc \
        --tmpfs /tmp \
        --ro-bind /nix /nix \
        --ro-bind /run/current-system /run/current-system \
        --ro-bind /etc/resolv.conf /etc/resolv.conf \
        --bind "$HOME/.config/opencode" "$HOME/.config/opencode" \
        --bind "$HOME/.local/share/opencode" "$HOME/.local/share/opencode" \
        --bind "$HOME/.local/state/opencode" "$HOME/.local/state/opencode" \
        --bind "$HOME/.cache/opencode" "$HOME/.cache/opencode" \
        --bind "$HOME/.cache/nix" "$HOME/.cache/nix" \
        --bind "/run/user/$UID/zmx" "/run/user/$UID/zmx" \
        --ro-bind "$HOME/nix-config" "$HOME/nix-config" \
        --ro-bind "$HOME/Documents" "$HOME/Documents" \
        --setenv OPENCODE_DISABLE_CHANNEL_DB 1 \
        opencode "$@"
    '';
  };
in
{
  programs.opencode = {
    enable = true;
    package = opencode-bubblewrapped;
    enableMcpIntegration = false;
    # Writes to ~/.config/opencode/AGENTS.md
    rules = ''
      - Please read `./AGENTS.md`
      - See your abilities in `~/nix-config/modules/opencode/home.nix`.
        - In short; you have no write for the most part. Don't suggest editing a file.
      - I use [NixOS with Nix](https://github.com/NixOS/nix), see `~/nix-config/nix.nix`-file.
      - I use [Helix editor](https://github.com/helix-editor/helix), see `~/nix-config/modules/helix/home.nix`-file.
        - My config is in `~/nix-config/modules/helix/config/`-dir.
      - I use [zmx](https://github.com/neurosnap/zmx), see `~/nix-config/modules/zmx/default.nix`-file.
      - I use [Fish shell](https://github.com/fish-shell/fish-shell), see `~/nix-config/modules/fish/default.nix`-file.
        - My config is in `~/nix-config/modules/fish/config/`-dir.
    '';
    settings = {
      # model = "";
      autoshare = false;
      autoupdate = "notify";
      permission = {
        "*" = "deny";
        "read" = {
          "*" = "allow";
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = "allow";
          "*config.php" = "deny";
          "example.config.php" = "allow";
        };
        "edit" = "deny";
        "glob" = "allow";
        "grep" = "allow";
        "bash" = {
          "*" = "deny";
          # opencode
          "opencode *" = "ask";
          # nix-shell
          "nix-shell" = "allow";
          # nix flake
          "nix flake *" = "deny";
          "nix flake show *" = "allow";
          "nix flake check *" = "allow";
          # misc.
          "man *" = "allow";
          # zmx
          "zmx *" = "deny";
          "zmx list *" = "allow";
          "zmx history *" = "ask";
          "zmx tail *" = "ask";
        };
        "question" = "allow";
        "webfetch" = "allow";
        "websearch" = "allow";
        "external_directory" = {
          "*" = "deny";
          "~/.config/opencode" = "allow";
          "~/.local/share/opencode" = "allow";
          "~/.local/state/opencode" = "allow";
          "~/.cache/opencode" = "allow";
          "~/.cache/nix" = "allow";
          "~/nix-config" = "allow";
        };
      };
    };
    commands = {
      "test" = ''
        # flake check without building
        Run `nix-shell`.
        Run `nix flake check --no-build`.
        Usage: /test
      '';
      "history" = ''
        # get history of zmx session
        run `zmx history $ARGUMENTS` and respond to what you see.
        Usage: /history <session_name>
      '';
      "tail" = ''
        # tail history of zmx session
        run `zmx tail $ARGUMENTS` and respond to what you see.
        Usage: /tail <session_name>
      '';
    };
  };
}
