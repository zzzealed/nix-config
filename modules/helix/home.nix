{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Langauge servers
      bash-language-server # Bash
      clang-tools # C
      vscode-langservers-extracted # Various
      marksman # Markdown
      python313Packages.python-lsp-server # Python
      rust-analyzer # Rust
      svelte-language-server # Svelte
      sqls # SQL
      prettierd # Various
      tailwindcss-language-server # Tailwind
      tofu-ls # OpenTofu
      taplo # TOML
      typescript-language-server # Typescript
      yaml-language-server # YAML
      docker-compose-language-service # Docker Compose
      docker-language-server # Docker
      harper # Grammar
      fish-lsp # Fish shell
      lldb # Debugger
      lua-language-server # Lua
      systemd-lsp # Systemd
      tinymist # Typst
      # Nix
      nixd
      nixfmt
    ];
  };
  home.file.".config/helix" = {
    source = ./config;
    recursive = true;
  };
}
