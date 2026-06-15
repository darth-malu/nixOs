{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  services.sunshine = {
    enable = true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = true; # true::
    settings = {
      sunshine_name = "darthSunshine";
      gamepad = "x360";
      # port = 47989;
    };
  };

  # Enables the uinput kernel module and creates the uinput group
  hardware.uinput.enable = true;

  # Add your user to the uinput group (replace "your-username" with your actual username)

  users.users.your-username.extraGroups = [ "malu" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      47984
      47989
      47990
      48010
    ];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48000;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
}
