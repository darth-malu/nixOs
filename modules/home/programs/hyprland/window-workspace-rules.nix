{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # case sensitive, plain regex(class) | title
      "float true, match:title file_progress"
      # "match: float true, match:title confirm"
      # "match: float true, match:title dialog"
      # "match: float true, match:title download"
      # "match: float true, match:title notification"
      # "match: float true, match:title error"
      # "match: float true, match:title splash"
      # "match: float true, match:title confirmreset"
      # "match: float true, match:title Open File"
      # "match: float true, match:title branchdialog"
      "float true, match:class org.gnome.FileRoller"
      "float true, match:title ^(Media viewer)$"
      "float true, match:title ^(Volume Control)$"
      "float true, match:title ^(Picture-in-Picture)$"
      # "size 75% 80%, float:1" # exact screen size... can use only window size also x% y% :FIXME: cause issues with all popup menus lol
      # "size 75% 80%, match:title ^(Sign in)(.*)$"

      #"size 1160 960, match:title ^(Volume Control)$"
      #"move 5 315, match:title ^(Volume Control)$"

      #"match: float true, Rofi"

      # "match: float true, pwvucontrol"
      "float true, match:class com.saivert.pwvucontrol"
      "float true, match:class Maluware-yt"
      #"center true(1), com.saivert.pwvucontrol"
      "float true, match:workspace n[s:window] f[1], border_size 0, rounding 0"

      # Select files dialog
      "center true, match:title ^(Save)(.*)"
      "center true, match:title ^(Select)(.*)"
      "center true, match:title (.*)(save to)(.*)"

      #"idleinhibit focus, vlc"
      # "idleinhibit fullscreen, match:title firefox"

      # "idleinhibit focus, match:class ncmpcpp"

      # "workspace special:scratch silent, match:class ^(org.qbittorrent.qBittorrent)$" # TODO get popups only

      # "match: float true, match:class Viewnior"
      #"size 80% 80%, Viewnior"
      # "center true(1), match:class Viewnior" # match:center([opt]); opt =1 -> respect monitor reserved area

      "no_focus true, match:title (Discord Updater)"
      # "workspace emptym, match:class obsidian"
      # "workspace emptym, match:class spotube"

      # "workspace emptym silent, match:class steam, match:title Sign in to Steam"
      # "workspace nointialfocus, match:class steam, match:title Sign in to Steam"

      # don't render hyprbars on tiling windows
      # "plugin:hyprbars:nobar, float:0"

      # PYTHON
      # "workspace emptym, match:class getting-started.py"
      "match:class main.py, center true"
      "match:class youtubr, center true"
      "match:class youtubr, float true"

      "match:float true, border_size 0"

      # Are you sure dialog popups
      "match:modal true, float true"

      "match:class mpv, workspace emptym"
      "match:class mpv, monitor HDMI-A-1"

    ]
    ++ [
      # Gamer centric
      "match:class ^(cs2)$, immediate true" # Allow Tearing

      # allow tearing in games
      # "immediate, match:class ^(osu\!|cs2)$"
    ]
    ++ [
      "match:class .*, suppress_event maximize"

      "match:class ^()$,match:title ^()$, no_blur true" # for chrome weird menus clear border

      "match:class ^(Xdg-desktop-portal-gtk)$,match:title ^(All Files)$, no_blur true"

      "border_size 0,match:class ^(Xdg-desktop-portal-gtk)$, match:title ^(All Files)$"

      "workspace emptym, match:initial_class ^(discord)$, match:initial_title ^(.*)(Discord)$"
      "workspace emptym silent, match:class ^(discord)$, match:title (Discord Updater)"

      "workspace emptym, match:initial_class ^(org.qbittorrent.qBittorrent)$, match:initial_title ^(.*)(qBittorrent v5.1.0)$"

      "workspace 10, match:initial_class ^(spotube)$, match:initial_title ^(spotube)$"
      "workspace 10, match:initial_class ^(spotify)$"

      "match:initial_class ^(viewnior)$, size 80% 80%"
      "match:initial_class ^(viewnior)$, center true"
      "match:initial_class ^(viewnior)$, float true"

      "float true , match:initial_class ^(org.telegram.desktop)$, match:initial_title ^(Telegram)(.*)$"
      "size 80% 60%, match:initial_class ^(org.telegram.desktop)$, match:initial_title ^(Telegram)(.*)$"

      "workspace emptym, match:initial_class emacs, match:initial_title ^(.*)(Doom Emacs)$"
      "workspace emptym, match:initial_class Emacs, match:initial_title ^(.*)(Doom Emacs)$"
      "workspace emptym, match:initial_class Emacs, match:initial_title ^(.*)(GNU Emacs at tangier)$"

      # "size 70% 70%,match:title ^(Select)(.*)"
      # "workspace emptym, match:initial_class ^(zen-alpha)$, match:initial_title ^(Zen Browser)$"

      # "nofocus,match:class ^$,match:title ^$,xwayland:1,float:1,fullscreen:0,pinned:0" # fix some dragging issues with xwayland, FIXME: see if causing xwayland issues
    ]; # match:class [regex],initial_class,initial_title,float, focus etc

    workspace = [
      # GENERAL: f fullscreen, w window count, m monitor, n name workspaace n[bool], n[s:string], n[e:string], s[bool] special or not eg. special:scratchpad,
      "w[tv1],border:false" # no gaps when only = 1 # w[(flags)A-B], w[(flags)X], t tiled, v visible windows,f float
      "f[1], gapsout:0, gapsin:0"

      "special:magic, on-created-empty:sh -c \"hyprctl dispatch -- exec '[workspace special:magic;float true;size 89% 85%] kitty'\"" # might need center(1)

      # ncmpcpp
      "special:nc, on-created-empty:sh -c \"hyprctl dispatch exec '[workspace special:nc; ] kitty -e ncmpcpp'\", monitor:HDMI-A-1"

      "special:easy, easyeffects"

      # rules
      # persistent:[b], decorate:[b], rounding[b],
    ];
    layerrule = [
      "dim_around true, match:namespace ^rofi"
      # "blur, hyprpaper" #don't think it works lol
      # "blur, waybar"
    ];

  };
}
