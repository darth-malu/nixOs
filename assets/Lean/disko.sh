# Partition with disko
#generate config optionally
# sudo nixos-generate-config --root /mnt --no-filesystems
#
# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /run/media/nixos/Ventoy/Shibuya/hosts/common/disko-BTRFS-LUKS.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /run/media/nixos/Ventoy/Jaja/Shibuya/assets/Lean/disko.sh

sudo nixos-install --flake /run/media/nixos/Ventoy/Shibuya#tangier #Install
