{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  services.sunshine = {
    enable = pkgs.lib.mkIf (config.networking.hostName == "carthage") true;
    openFirewall = true;
    capSysAdmin = true;
    autoStart = false; # true::
    settings = {
      sunshine_name = "darthSunshine"; # Use hostname by default
      gamepad = "x360";
      # port = 47989;
    };
  };

  # Enables the uinput kernel module and creates the uinput group
  hardware.uinput.enable = true;

  # Add your user to the uinput group (replace "your-username" with your actual username)

  users.users.malu.extraGroups = [ "uinput" ];

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
