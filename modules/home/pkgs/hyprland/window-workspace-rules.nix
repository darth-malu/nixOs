{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # case sensitive, plain regex(class) | title
      # centerwindow - center current window(floating only)
      "float, title:file_progress"
      "float, title:confirm"
      "float, title:dialog"
      "float, title:download"
      "float, title:notification"
      "float, title:error"
      "float, title:splash"
      "float, title:confirmreset"
      "float, title:Open File"
      "float, title:branchdialog"
      "float, class:org.gnome.FileRoller"
      "float, title:^(Media viewer)$"
      "float, title:^(Volume Control)$"
      "float, title:^(Picture-in-Picture)$"
      # "centerwindow, floating:1"
      "size 75% 80%, floating:1" # exact screen size... can use only window size also x% y%
      "size 75% 80%, title:^(Sign in)(.*)$"

      #"size 1160 960, title:^(Volume Control)$"
      #"move 5 315, title:^(Volume Control)$"

      #"float, Rofi"

      # "float, pwvucontrol"
      "float, class:com.saivert.pwvucontrol"
      #"center(1), com.saivert.pwvucontrol"

      # Select files dialog
      "center, title:^(Save)(.*)"
      "center, title:^(Select)(.*)"
      "center, title:(.*)(save to)(.*)"

      #"idleinhibit focus, vlc"
      "idleinhibit fullscreen, title:firefox"

      #"idleinhibit focus, zen-alpha"#TODO: make this better withh dbus tool
      "idleinhibit focus, class:chromium"
      "idleinhibit focus, class:ncmpcpp"

      "workspace special:quanta silent, class:qbittorrent"

      "float, class:Viewnior"
      #"size 80% 80%, Viewnior"
      "center(1), class:Viewnior" # center([opt]); opt =1 -> respect monitor reserved area

      "nofocus, title:(Discord Updater)"
      "workspace emptym, class:^(Chromium-browser)$"
      "workspace emptym, class:google-chrome" # TODO: do this with array?
      "workspace emptym, class:org.qutebrowser.qutebrowser"
      "workspace emptym, class:obsidian"
      "workspace emptym, class:spotube"
      "workspace emptym, class:Emacs"

      "workspace emptym, class:mpv"
      "monitor HDMI-A-1, class:mpv"
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
    ]; # class:[regex],initialClass,initialTitle,floating, focus etc

    workspace = [
      # comma seperate extra rules
      # GENERAL: f fullscreen, w window count, m monitor, n name workspaace n[bool], n[s:string], n[e:string], s[bool] special or not eg. special:scratchpad,
      "w[tv1],border:false" # no gaps when only = 1 # w[(flags)A-B], w[(flags)X], t tiled, v visible windows,f floating
      #"w[tv1],border:false,gapsout:2, gapsin:0"
      "f[1], gapsout:0, gapsin:0"

      # created empty
      # "special:quanta, on-created-empty:sh -c \"hyprctl dispatch -- exec '[workspace special:quanta;] uwsm app -s a kitty'\""
      "special:magic, on-created-empty:sh -c \"hyprctl dispatch -- exec '[workspace special:magic;float;size 89% 85%] kitty'\"" # might need center(1)
      # "special:nc, on-created-empty:sh -c \"hyprctl dispatch exec '[workspace special:nc; ] kitty -e ncmpcpp'\""

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
