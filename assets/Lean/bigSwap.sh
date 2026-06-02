sudo mount -o subvol=/swap /dev/mapper/GoodLuks /mnt/.swapvol

sudo truncate -s 0 /mnt/.swapvol/swapfile

sudo chattr +C /mnt/.swapvol/swapfile 

sudo fallocate -l 30G /mnt/.swapvol/swapfile 

sudo chmod 600 /mnt/.swapvol/swapfile 

sudo mkswap /mnt/.swapvol/swapfile 

sudo swapon /mnt/.swapvol/swapfile

