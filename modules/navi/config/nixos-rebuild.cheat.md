% nixos-rebuild
# Rebuild with flake and build sub
sudo nixos-rebuild --build-host <build-host> --use-substitutes --flake .#<host> <option> --specialisation <specialisation>
$ build-host:
$ host: nix flake show --json | jq -r '.nixosConfigurations | keys | join("\n")'
$ option: echo -e  "switch\nboot\ntest\nbuild"
$ specialisation:
