{
  # v = "nvim"; # FIXME emacs better 🫠
  # lss = "ls -lah --color=auto";
  lx = "eza -a --color=auto";
  lxx = "eza -al --color=auto";
  ".." = "cd ..";
  "_" = "cd -";
  yt = "yt-dlp";
  ytV = "yt-dlp -P ~/Music/musicVideos/";
  yta = "yt-dlp --extract-audio --audio-format mp3";
  # ".g" = "$(which git) --git-dir=$HOME/.darth/nixOs.git --work-tree=$HOME/Shibuya";
  tColor = "for C in {0..255}; do tput setab \$C; echo -n \"$C \"; done; tput sgr0;echo";
  speedtest = "$(curl -S https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -)";
}
