# Rust gameserver
## Init/updating
`steamcmd +force_install_dir /var/lib/rust-gameserver +login anonymous +app_update 258550 validate +quit` \
Download + extract Oxdie files into `/var/lib/rust-gameserver/data/RustDedicated_Data` (TODO: Automate?)

## Config
Inside `/var/lib/rust-gameserver/data/server/my_server_identity/`

## Logs
Use `journalctl -fu rust-gameserver.service`

## Docs
https://wiki.facepunch.com/rust/Creating-a-server
https://docs.oxidemod.com/guides/owners/permissions#introduction-to-permissions
