{
  description = "Minimal NixOS installation media";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      exampleIso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ pkgs, modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
            environment.systemPackages = [ pkgs.neovim ];
            # Enable SSH in the boot process.
            systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
            users.users.root.openssh.authorizedKeys.keys = [
              "ssh-ed25519 AaAeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee username@host"
            ];
          })
        ];
      };
    };
  };
}

# git init
# git add flake.nix
# nix build .#nixosConfigurations.exampleIso.config.system.build.isoImage

# Find result in:
# $ ls result/iso/
# nixos-minimal-25.05.20250831.b4c2c57-x86_64-linux.iso

# Mount Isos
# sudo mount -o loop result/iso/nixos-*.iso mnt

# https://github.com/NixOS/nixpkgs/tree/bed020fc902b4bfd0768b04cd8e697c06bdbe289/nixos/modules/installer/cd-dvd
