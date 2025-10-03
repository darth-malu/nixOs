{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # case sensitive, plain regex(class) | title
      "float, title:file_progress"
      # "float, title:confirm"
      # "float, title:dialog"
      # "float, title:download"
      # "float, title:notification"
      # "float, title:error"
      # "float, title:splash"
      # "float, title:confirmreset"
      # "float, title:Open File"
      # "float, title:branchdialog"
      "float, class:org.gnome.FileRoller"
      "float, title:^(Media viewer)$"
      "float, title:^(Volume Control)$"
      "float, title:^(Picture-in-Picture)$"
      # "size 75% 80%, floating:1" # exact screen size... can use only window size also x% y% :FIXME: cause issues with all popup menus lol
      # "size 75% 80%, title:^(Sign in)(.*)$"

      #"size 1160 960, title:^(Volume Control)$"
      #"move 5 315, title:^(Volume Control)$"

      #"float, Rofi"

      # "float, pwvucontrol"
      "float, class:com.saivert.pwvucontrol"
      "float, class:Maluware-yt"
      #"center(1), com.saivert.pwvucontrol"

      # Select files dialog
      "center, title:^(Save)(.*)"
      "center, title:^(Select)(.*)"
      "center, title:(.*)(save to)(.*)"

      #"idleinhibit focus, vlc"
      # "idleinhibit fullscreen, title:firefox"

      # "idleinhibit focus, class:ncmpcpp"

      # "workspace special:scratch silent, class:^(org.qbittorrent.qBittorrent)$" # TODO get popups only

      # "float, class:Viewnior"
      #"size 80% 80%, Viewnior"
      # "center(1), class:Viewnior" # center([opt]); opt =1 -> respect monitor reserved area

      "nofocus, title:(Discord Updater)"
      # "workspace emptym, class:obsidian"
      # "workspace emptym, class:spotube"

      # "workspace emptym silent, class:steam, title:Sign in to Steam"
      # "workspace nointialfocus, class:steam, title:Sign in to Steam"

      # PYTHON
      "workspace emptym, class:getting-started.py"
      "center, class:main.py"
      "center, class:Maluware-yt"
      "center, title:Darth-Yt"
      # "center, class:youtubr"
      "center, class:youtubr"
      "float, class:youtubr"

      "workspace emptym, class:mpv"
      "monitor HDMI-A-1, class:mpv"

    ]
    ++ [
      # Gamer centric
      "immediate, class:^(cs2)$" # Allow Tearing
    ];

    windowrulev2 = [

      "suppressevent maximize, class:.*"

      "noblur,class:^()$,title:^()$" # for chrome weird menus clear border

      "noblur,class:^(Xdg-desktop-portal-gtk)$,title:^(All Files)$" # for chrome weird menus clear border
      "noborder,class:^(Xdg-desktop-portal-gtk)$,title:^(All Files)$" # for chrome weird menus clear border

      "workspace emptym, initialClass:^(discord)$, initialTitle:^(.*)(Discord)$"
      "workspace emptym silent, class:^(discord)$, title:(Discord Updater)"

      "workspace emptym, initialClass:^(org.qbittorrent.qBittorrent)$, initialTitle:^(.*)(qBittorrent v5.1.0)$"

      "noinitialfocus, initialClass:^(jetbrains-studio)$, floating:1"

      "workspace 10, initialClass:^(spotube)$, initialTitle:^(spotube)$"
      "workspace 10, initialClass:^(spotify)$"

      "size 80% 80%, initialClass:^(viewnior)$"
      "center , initialClass:^(viewnior)$"
      "float , initialClass:^(viewnior)$"

      "float , initialClass:^(org.telegram.desktop)$, initialTitle:^(Telegram)(.*)$"
      "size 80% 60%, initialClass:^(org.telegram.desktop)$, initialTitle:^(Telegram)(.*)$"

      "workspace emptym, initialClass:emacs, initialTitle:^(.*)(Doom Emacs)$"
      "workspace emptym, initialClass:Emacs, initialTitle:^(.*)(Doom Emacs)$"
      "workspace emptym, initialClass:Emacs, initialTitle:^(.*)(GNU Emacs at tangier)$"

      # "size 70% 70%,title:^(Select)(.*)"
      # "workspace emptym, initialClass:^(zen-alpha)$, initialTitle:^(Zen Browser)$"

      # "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # fix some dragging issues with xwayland, FIXME: see if causing xwayland issues
    ]; # class:[regex],initialClass,initialTitle,floating, focus etc

    workspace = [
      # comma seperate extra rules

      # GENERAL: f fullscreen, w window count, m monitor, n name workspaace n[bool], n[s:string], n[e:string], s[bool] special or not eg. special:scratchpad,
      "w[tv1],border:false" # no gaps when only = 1 # w[(flags)A-B], w[(flags)X], t tiled, v visible windows,f floating
      #"w[tv1],border:false,gapsout:2, gapsin:0"
      "f[1], gapsout:0, gapsin:0"

      "special:magic, on-created-empty:sh -c \"hyprctl dispatch -- exec '[workspace special:magic;float;size 89% 85%] kitty'\"" # might need center(1)

      # ncmpcpp
      "special:nc, on-created-empty:sh -c \"hyprctl dispatch exec '[workspace special:nc; ] kitty -e ncmpcpp'\", monitor:HDMI-A-1"

      "special:easy, easyeffects"
      # rules
      # persistent:[b], decorate:[b], rounding[b],
    ];
    layerrule = [
      "dimaround, rofi"
      # "blur, hyprpaper" #don't think it works lol
      # "blur, waybar"
    ];

  };
}
