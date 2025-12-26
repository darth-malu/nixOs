{ lib, config, ... }:
{
  options.docker = {
    enable = lib.mkEnableOption "Enable Docker 😀";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = "zfs";
      # users.extraGroups.docker.members = [ "malu" ]; # instead of users.<>.extraGroups
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
