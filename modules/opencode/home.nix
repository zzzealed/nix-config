{ pkgs, ... }:
let
  # Bubblewrap OpenCode
  # I've watched "Age of Ultron"
  opencode-sandboxed = pkgs.writeShellApplication {
    name = "opencode";
    runtimeInputs = [ pkgs.bubblewrap ];
    text = ''
      mkdir -p "$HOME/.config/opencode"
      mkdir -p "$HOME/.local/share/opencode"

      exec bwrap \
        --ro-bind / / \
        --tmpfs /tmp \
        --tmpfs /var/tmp \
        --dev /dev \
        --proc /proc \
        --bind "$HOME/.config/opencode" "$HOME/.config/opencode" \
        --bind "$HOME/.local/share/opencode" "$HOME/.local/share/opencode" \
        --bind "$HOME/.cache/opencode" "$HOME/.cache/opencode" \
        --bind "$HOME/.cache/nix" "$HOME/.cache/nix" \
        "${pkgs.opencode}/bin/opencode" "$@"
    '';
  };
in
{
  programs.opencode = {
    enable = true;
    package = opencode-sandboxed;
    enableMcpIntegration = false;
    rules = ''
      See your abilities in `~/nix-config/modules/opencode/home.nix`.
      In short; you have no write for the most part. Don't suggest editing a file.
    '';
    settings = {
      # model = "";
      autoshare = false;
      autoupdate = true;
      permission = {
        "*" = "deny";
        "read" = {
          "*" = "allow";
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = "allow";
          "config.php" = "deny";
        };
        "glob" = "allow";
        "grep" = "allow";
        "bash" = {
          "*" = "deny";
          "nix-shell" = "allow";
          "nix flake *" = "allow";
          "man *" = "allow";
        };
        "question" = "allow";
        "webfetch" = "allow";
        "websearch" = "allow";
        "external_directory" = {
          "*" = "deny";
          "~/.config/opencode" = "allow";
          "~/.local/share/opencode" = "allow";
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
    };
  };
}
