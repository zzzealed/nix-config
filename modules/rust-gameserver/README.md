# Rust gameserver
## Init/updating on force-wipe
`sudo steamcmd +force_install_dir /var/lib/rust-gameserver +login anonymous +app_update 258550 validate +quit`

## Update Oxide
`sudo curl -L https://github.com/OxideMod/Oxide.Rust/releases/latest/download/Oxide.Rust-linux.zip -o oxide.zip && sudo unzip -o oxide.zip -d /var/lib/rust-gameserver/`

## Config
Inside `/var/lib/rust-gameserver/server/my_server_identity/`

## Logs
Use `journalctl -fu rust-gameserver.service`

## Docs
https://wiki.facepunch.com/rust/Creating-a-server \
https://docs.oxidemod.com/guides/owners/permissions#introduction-to-permissions
