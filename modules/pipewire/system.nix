{ ... }:
{
  services.pipewire.systemWide = true;
  users.users.mads.extraGroups = [ "pipewire" ];
}
