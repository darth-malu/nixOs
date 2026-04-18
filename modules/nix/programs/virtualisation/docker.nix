{ lib, config, ... }:
{
  options.docker = {
    enable = lib.mkEnableOption "Enable Docker 😀";
  };

  config = lib.mkIf config.docker.enable {
    # users.extraGroups.docker.members = [ "malu" ];
    virtualisation.docker = {
      enable = if config.networking.hostName == "tangier" then false else false;
      storageDriver = "zfs";
      rootless = {
        enable = true;
        setSocketVariable = true; # DOCKER_HOST
      };
      # Optionally customize rootless Docker daemon settings
      daemon.settings = {
        dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
    };
  };
}
