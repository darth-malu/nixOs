{
  wayland.windowManager.hyprland.settings = {
      windowrule = [# case sensitive, plain regex(class) | title 
        "float, file_progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, org.gnome.FileRoller"
        "float, title:^(Media viewer)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "centerwindow, floating:1"
        "size 75% 80%, floating:1" # exact screen size... can use only window size also x% y%
        "size 75% 80%, ^(Sign in)(.*)$"

        #"size 1160 960, title:^(Volume Control)$"
        #"move 5 315, title:^(Volume Control)$"

      #"float, Rofi"

      # "float, pwvucontrol"
        "float, com.saivert.pwvucontrol"
      #"center(1), com.saivert.pwvucontrol"

        # Select files dialog
        "center, title:^(Save)(.*)"
        "center, title:^(Select)(.*)"
        "center, title:(.*)(save to)(.*)"

      #"idleinhibit focus, vlc"
        "idleinhibit fullscreen, firefox"

      #"idleinhibit focus, zen-alpha"#TODO: make this better withh dbus tool
        "idleinhibit focus, chromium"
        "idleinhibit focus, ncmpcpp"

        "workspace special:quanta silent, qbittorrent"

        "float,Viewnior"
        #"size 80% 80%, Viewnior"
        "center(1), Viewnior"# center([opt]); opt =1 -> respect monitor reserved area

        "nofocus, title:(Discord Updater)"
        "workspace emptym, class:^(Chromium-browser)$"
        "workspace emptym, google-chrome" #TODO: do this with array?
        "workspace emptym, org.qutebrowser.qutebrowser"
        "workspace emptym, obsidian"
        "workspace emptym, spotube"
      ];

      windowrulev2 = [
        "noblur,class:^()$,title:^()$" # for chrome weird menus clear border
        "noblur,class:^(Xdg-desktop-portal-gtk)$,title:^(All Files)$" # for chrome weird menus clear border
        "noborder,class:^(Xdg-desktop-portal-gtk)$,title:^(All Files)$" # for chrome weird menus clear border

        "workspace emptym, initialClass:^(discord)$, initialTitle:^(.*)(Discord)$"
        "workspace emptym, initialClass:^(vesktop)$, initialTitle:^(.*)(DIscord)$"
        "workspace emptym silent, class:^(discord)$, title:(Discord Updater)"

        "size 80% 80%, initialClass:^(Viewnior)$"

        "suppressevent maximize, class:.*"
        "size 70% 70%,title:^(Select)(.*)"
        "workspace emptym, initialClass:^(zen-alpha)$, initialTitle:^(Zen Browser)$"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0" # fix some dragging issues with xwayland
      ];# class:[regex],initialClass,initialTitle,floating, focus etc

      workspace = [
        # GENERAL: f fullscreen, w window count, m monitor, n name workspaace n[bool], n[s:string], n[e:string], s[bool] special or not eg. special:scratchpad,
        "w[tv1],border:false" #no gaps when only = 1 # w[(flags)A-B], w[(flags)X], t tiled, v visible windows,f floating
        #"w[tv1],border:false,gapsout:2, gapsin:0"
        "f[1], gapsout:0, gapsin:0"

        # created empty
        "special:quanta, on-created-empty:sh -c \"hyprctl dispatch exec $terminal\" "
        # "special:nc, on-created-empty:sh -c \"hyprctl dispatch exec '[workspace special:nc;float;size 89% 85% ] kitty -e ncmpcpp'\""
        "special:nc, on-created-empty:sh -c \"hyprctl dispatch exec '[workspace special:nc; ] kitty -e ncmpcpp'\""
        # "special:nc, on-created-empty:sh -c \"hyprctl dispatch exec '[workspace special:nc; ] ghostty -e ncmpcpp'\""

        "special:easy, easyeffects"
      ];
    layerrule = [
      "dimaround, rofi"
      "blur, hyprpaper"
      # "blur, waybar"
    ];

    }; # EOM
}
