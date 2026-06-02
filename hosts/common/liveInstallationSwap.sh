# 1. Ensure your swap subvolume is mounted to the installation root
sudo mkdir -p /mnt/.swapvol
sudo mount -o subvol=/swap /dev/mapper/crypted /mnt/.swapvol

# 2. Create an empty file for the swap
sudo truncate -s 0 /mnt/.swapvol/swapfile

# 3. CRITICAL: Disable Copy-on-Write (CoW) on the file
# This must be done while the file is completely empty (size 0)
sudo chattr +C /mnt/.swapvol/swapfile

# 4. Allocate the actual size (e.g., 8 Gigabytes)
sudo fallocate -l 8G /mnt/.swapvol/swapfile

# 5. Set the correct permissions (Linux requires swap files to be secure)
sudo chmod 600 /mnt/.swapvol/swapfile

# 6. Format it as swap area
sudo mkswap /mnt/.swapvol/swapfile

# 7. Turn the swap on
sudo swapon /mnt/.swapvol/swapfile
