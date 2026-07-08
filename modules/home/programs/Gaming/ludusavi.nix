{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.ludusavi = {
    enable = true;
    # Path to a Ludusavi config.yaml. Mutually exclusive with the settings option. See https://github.com/mtkennerly/ludusavi/blob/master/docs/help/configuration-file.md for available options.
    # configFile
    frequency = "daily"; # daily::, "*-*-* 8:00:00" - systemd.time(7)
    settings = {
      # https://github.com/mtkennerly/ludusavi#configuration-file
      backup = {
        # path = "~/.local/state/backups/ludusavi";
        path = "/media/Hyogo/Backups/ludusavi";
      };
      language = "en-US";
      restore = {
        # path = "~/.local/state/backups/ludusavi";
        path = "/media/Hyogo/Backups/ludusavi";
      };
      # roots = [
      #   {
      #     path = "~/.local/share/Steam";
      #     store = "steam";
      #   }
      # ];
      theme = "dark"; # light::
    };
    backupNotification = true;
  };
}
