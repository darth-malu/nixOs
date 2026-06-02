{
  description = "Graphical NixOS installation media with remote building enabled";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        exampleIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              {
                pkgs,
                modulesPath,
                config,
                ...
              }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix") ];

                # 1. Properly enable OpenSSH (cleaner than modifying systemd services directly)
                services.openssh = {
                  enable = true;
                  settings.PermitRootLogin = "yes";
                };

                # 2. Add your keys to the standard live environment user ('nixos') and 'root'
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AaAeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee username@host"
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9bmUGM+Vxix3N6UsxEPwOLmH1JmBiCcudWMb0ZIzcD darth-malu@github.com"
                ];
                users.users.nixos.openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;

                # 3. CRITICAL FOR REMOTE BUILDING: Trust these users to interact with the Nix daemon
                nix.settings.trusted-users = [
                  "root"
                  "nixos"
                ];

                # Custom fast-compression settings for local iteration
                isoImage.squashfsCompression = "gzip -Xcompression-level 1";

                environment.systemPackages = with pkgs; [
                  neovim
                  yazi
                  kitty
                  git
                ];

                nixpkgs = {
                  hostPlatform = "x86_64-linux";
                  config.allowUnfree = true;
                };
              }
            )
          ];
        };
      };
    };
}
