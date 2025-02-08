{
    v = "nvim";
    lss = "ls -lah --color=auto";
    lx = "eza -a --color=auto";
    lxx = "eza -al --color=auto";
    ".." = "cd ..";
    "_" = "cd -";
    yt = "yt-dlp";
    yta = "yt-dlp --extract-audio --audio-format mp3";
    ".g" = "$(which git) --git-dir=$HOME/.darth/nixOs.git --work-tree=$HOME/Shibuya";
    tColor = "for C in {0..255}; do tput setab \$C; echo -n \"$C \"; done";
}
