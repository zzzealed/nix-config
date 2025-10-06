{ ... }:
{
  services.glance = {
    enable = true;
    openFirewall = true;
    settings = {
      theme = {
        light = false;
        background-color = "220 15 15";
        primary-color = "120 100 50";
        positive-color = "120 100 50";
        negative-color = "0 70 70";
        contrast-multiplier = "1.3";
      };
      pages = [
          {
            name = "Page1";
            columns = [
             {
              size = "small";
              widgets = [
                { type = "calendar"; }
              ];
             }
           ];
         }
      ];
    };
  };
}
