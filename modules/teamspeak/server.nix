{ ... }:
{
  services.teamspeak3 = {
    enable = true;
    openFirewall = true;
    defaultVoicePort = 9987;
    fileTransferPort = 30033;
  };
}
