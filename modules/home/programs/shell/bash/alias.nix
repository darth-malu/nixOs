{
  ".." = "cd ..";
  "_" = "cd -";
  yt = "yt-dlp";
  yta = "yt-dlp --extract-audio --audio-format mp3";
  # ".g" = "$(which git) --git-dir=$HOME/.darth/nixOs.git --work-tree=$HOME/Shibuya";
  tColor = "for C in {0..255}; do tput setab \$C; echo -n \"$C \"; done; tput sgr0;echo";
  speedtest = "$(curl -S https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -)";

  # l = "lsd -1";
  # ls = "lsd";
  # la = "lsd -A";

  studious = "git --git-dir=/media/Hyogo/Backups/Bare --work-tree=/media/Hyogo";
  dots = "git --git-dir=$HOME/Documents/IMPORTANT/BARE/Dots.git --work-tree=$HOME";
}
