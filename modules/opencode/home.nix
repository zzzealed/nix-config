{ lib, pkgs, ... }:
let
  # Bubblewrap OpenCode
  # I've watched "Age of Ultron"
  opencode-bubblewrapped = pkgs.writeShellApplication {
    name = "opencode";
    runtimeInputs =
      with pkgs;
      (import ../lsp/pkgs.nix pkgs)
      ++ [
        bubblewrap
        unstable.opencode
        unstable.helix # For /editor
        unstable.mcp-nixos

        # Misc;
        dig
        ripgrep
      ];
    # This is the best I cared to come up with
    text = ''
      mkdir -p "$HOME/.config/opencode"
      mkdir -p "$HOME/.local/share/opencode"
      mkdir -p "$HOME/.local/state/opencode"
      mkdir -p "$HOME/.cache/opencode"
      mkdir -p "$HOME/.cache/mcp-nixos"

      # get CWD
      cwd=$(cd "$PWD" && pwd -P)

      exec bwrap \
        --dev /dev \
        --proc /proc \
        --tmpfs /tmp \
        --ro-bind /nix /nix \
        --ro-bind /run/current-system /run/current-system \
        --ro-bind /etc/resolv.conf /etc/resolv.conf \
        --ro-bind "$cwd" "$cwd" \
        --bind "$HOME/.config/opencode" "$HOME/.config/opencode" \
        --bind "$HOME/.local/share/opencode" "$HOME/.local/share/opencode" \
        --bind "$HOME/.local/state/opencode" "$HOME/.local/state/opencode" \
        --bind "$HOME/.cache/opencode" "$HOME/.cache/opencode" \
        --bind "$HOME/.cache/nix" "$HOME/.cache/nix" \
        --bind "/run/user/$UID/zmx" "/run/user/$UID/zmx" \
        --bind "$HOME/.config/helix" "$HOME/.config/helix" \
        --bind "$HOME/.cache/helix" "$HOME/.cache/helix" \
        --bind "$HOME/.cache/mcp-nixos" "$HOME/.cache/mcp-nixos" \
        --ro-bind "/mnt/c/Users/mads/nix-config" "/mnt/c/Users/mads/nix-config" \
        --setenv OPENCODE_DISABLE_CHANNEL_DB 1 \
        --setenv OPENCODE_DISABLE_FFF 1 \
        --setenv NIX_SSL_CERT_FILE /run/current-system/etc/ssl/certs/ca-certificates.crt \
        opencode "$@"
    '';
  };
in
{
  programs.mcp = {
    enable = true;
    servers = {
      mcp-nixos = {
        command = "mcp-nixos";
      };
    };
  };
  programs.opencode = {
    enable = true;
    package = opencode-bubblewrapped;
    enableMcpIntegration = true;
    tui = {
      theme = lib.mkForce "system";
    };
    # Writes to ~/.config/opencode/AGENTS.md
    context = ''
      - Please read `./README.md`
      - See your abilities in `/mnt/c/Users/mads/nix-config/modules/opencode/home.nix`.
        - In short; you have no write for the most part. Don't suggest editing a file.
    '';
    settings = {
      mcp = {
        mcp-nixos = {
          type = "local";
          command = [ "mcp-nixos" ];
          enabled = true;
          timeout = 30000;
        };
      };
      model = "opencode/deepseek-v4.1-flash-free";
      small_model = "opencode/big-pickle";
      default_agent = "plan";
      autoshare = false;
      autoupdate = "notify";
      lsp = true;
      permission = {
        "*" = "deny";
        "read" = {
          "*" = "allow";
          "*.env" = "deny";
          "*.env.*" = "deny";
          "*.env.example" = "allow";
          "*config.php" = "deny";
          "*config.php.bak" = "deny";
          "example.config.php" = "allow";
        };
        "edit" = "deny";
        "glob" = "allow";
        "grep" = "allow";
        "bash" = {
          "*" = "ask";
          # nix
          "nix-shell" = "allow";
          "nix flake *" = "deny";
          "nix flake show *" = "allow";
          "nix flake check *" = "allow";
          "nix eval *" = "allow";
          # misc.
          "man *" = "allow";
          "rg *" = "allow";
          # zmx
          "zmx history *" = "allow";
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
          "~/.cache/mcp-nixos" = "allow";
          "/mnt/c/Users/mads/nix-config" = "allow";
        };
        "mcp-nixos_nix" = "allow";
        "mcp-nixos_nix_versions" = "allow";
      };
    };
    commands = {
      "test" = ''
        Run `nix-shell`.
        Run `nix flake check --no-build`.
        Usage: /test
      '';
      "tail" = ''
        Template: Run this command to see the output of my shell.
        Description: Tail zmx session's history.
        Run: `zmx history $1 | tail $2`
        Usage: /tail <session_name> | tail -<lines>
      '';
    };
  };
}
