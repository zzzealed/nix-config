{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.helix
    # Langauge servers
    bash-language-server
    clang-tools
    vscode-langservers-extracted
    docker-language-server
    marksman
    nil
    python313Packages.python-lsp-server
    rust-analyzer
    svelte-language-server
    sqls
    tailwindcss-language-server
    opentofu-ls
    taplo
    typescript-language-server
    yaml-language-server
    docker-compose-language-service
    docker-language-server
    harper
    fish-lsp
    lldb
    lua-language-server
    unstable.systemd-lsp
  ];
}
