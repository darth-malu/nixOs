{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.docker.enable = lib.mkEnableOption "Enable Docker 😀";

  config = lib.mkIf config.docker.enable {
    # users.extraGroups.docker.members = [ "malu" ];
    virtualisation.docker = {
      enable = (config.networking.hostName == "tangier");
      storageDriver = "btrfs";
      enableOnBoot = true;
      extraOptions = "--default-runtime=nvidia";
      # APply the demo set
      # kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/1.0.0-beta4/nvidia-device-plugin.yml
      rootless = {
        enable = true;
        setSocketVariable = true; # DOCKER_HOST
        # daemon = {
        #   fixed-cidr-v6 = "fd00::/80";
        #   ipv6 = true;
        # };
      };
      # autoPrune = false;
      # Optionally customize rootless Docker daemon settings
      daemon.settings = {
        live-restore = true; # restart dockerd without affecting container
        dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
      extraPackages = with pkgs; [ criu ];
    };

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/cluster/k3s/docs/examples/NVIDIA.md
    hardware = {
      nvidia-container-toolkit.enable = if config.networking.hostName == "tangier" then true else false; # Enable dynamic CDI (container device interface) configuration for Nvidia devices by running nvidia-container-toolkit on boot.
      nvidia-container-toolkit.mount-nvidia-executables = true;
    };

    environment.systemPackages = with pkgs; [
      nvidia-container-toolkit
    ];
  };
}
