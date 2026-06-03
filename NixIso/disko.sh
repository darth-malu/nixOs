# Partition with disko
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /run/media/nixos/Ventoy/disko-BTRFS-LUKS-BASIC.nix
# sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /run/media/nixos/Ventoy/Shibuya/hosts/common/disko-ZFS.nix

# sudo nixos-install --flake /run/media/nixos/Ventoy/Shibuya#tangier

#generate config optionally
# sudo nixos-generate-config --root /mnt --no-filesystems

sudo mount -o subvol=/swap /dev/mapper/GoodLuks /mnt/.swapvol

sudo truncate -s 0 /mnt/.swapvol/swapfile

sudo chattr +C /mnt/.swapvol/swapfile

sudo fallocate -l 26G /mnt/.swapvol/swapfile

sudo chmod 600 /mnt/.swapvol/swapfile

sudo mkswap /mnt/.swapvol/swapfile

sudo swapon /mnt/.swapvol/swapfile
