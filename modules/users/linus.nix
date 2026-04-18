{ config, ... }:
{
  age.secrets."linus-password".file = ../../secrets/linus-password.age;
  users.users.linus = {
    description = "Linus";
    home = "/home/linus";
    isNormalUser = true;
    extraGroups = [
      "media"
    ];
    hashedPasswordFile = config.age.secrets."linus-password".path;
  };
}
