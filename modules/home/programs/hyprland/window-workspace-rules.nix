{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float true, match:class com.saivert.pwvucontrol"
      "center true, match:class com.saivert.pwvucontrol"
      "size (monitor_w*0.8) (monitor_h*0.7), match:class com.saivert.pwvucontrol"

      # kcalc
      "float true, match:class org.kde.kalk"
      "persistent_size true, match:class org.kde.kalk"

      # Sign in windows
      # Zen
      "float true, match:class zen match:title ^(Sign in)(.*)"
      "center true, match:class zen match:title ^(Sign in)(.*)"
      "size (monitor_w*0.8) (monitor_h*0.7), match:class zen match:title ^(Sign in)(.*)"

      # "float true, match:class alarm-clock-applet"
      # "center true, match:class alarm-clock-applet"
      # "size (monitor_w*0.6) (monitor_h*0.6), match:class alarm-clock-applet"

      "float true, match:class Maluware-yt"
      "float true, match:workspace n[s:window] f[1], border_size 0, rounding 0"

      # Select files dialog
      "center true, match:title ^(Save)(.*)"
      "size (monitor_w*0.6) (monitor_h*0.6), match:title ^(Save)(.*)"

      "center true, match:title ^(Select)(.*)"
      "size (monitor_w*0.6) (monitor_h*0.6), match:title ^(Select)(.*)"

      "center true, match:title (.*)(save to)(.*)"
      "size (monitor_w*0.6) (monitor_h*0.6), match:title (.*)(save to)(.*)"

      # LUKS / udiskie
      "center true, match:class udiskie, match:title udiskie"
      "float true, match:class udiskie, match:title udiskie"
      "size (monitor_w*0.2) (monitor_h*0.1), match:class udiskie, match:title udiskie"

      # Zenity eg...protonfixes
      "center true, match:class zenity"
      "float true, match:class zenity"
      # "idleinhibit focus, match:class ncmpcpp"

      # "workspace special:scratch silent, match:class ^(org.qbittorrent.qBittorrent)$" # TODO get popups only

      "no_focus true, match:title (Discord Updater)"

      # Steam
      "workspace emptym, match:title ^(steam)$,match:class ^(steam)$"
      # "no_focus true, match:title (Discord Updater)" # TODO steam initial

      # don't render hyprbars on tiling windows
      # "plugin:hyprbars:nobar, float:0"

      # PYTHON
      # "workspace emptym, match:class getting-started.py"
      "match:class main.py, center true"

      "match:class youtubr, center true"
      "match:class youtubr, float true"

      # "match:title youtubr, center true"
      # "match:title youtubr, float true"

      "match:float true, border_size 0"
      "match:float true, center true"

      # Are you sure dialog popups
      "match:modal true, float true"

      "match:class mpv, workspace emptym"
      "match:class mpv, monitor HDMI-A-1"

    ]
    ++ [
      # Gamer centric
      "match:class ^(cs2|dota)$, immediate true" # Allow Tearing
      "match:class ^(cs2|dota)$, content game" # Allow Tearing

      # allow tearing in games
      # "immediate, match:class ^(osu\!|cs2)$"
    ]
    ++ [
      # match:class [regex],initial_class,initial_title,float, focus etc
      "match:class .*, suppress_event maximize"

      # Chrome
      "match:class ^()$,match:title ^()$, no_blur true" # for chrome weird menus clear border
      "persistent_size true, match:class ^(google-chrome)"
      # TODO: float...zoom, meet pip (all pip)

      # "match:class ^(Xdg-desktop-portal-gtk)$,match:title ^(All Files)$, no_blur true"

      # "border_size 0,match:class ^(Xdg-desktop-portal-gtk)$, match:title ^(All Files)$"

      "workspace emptym, match:initial_class ^(discord)$, match:initial_title ^(.*)(Discord)$"
      "workspace emptym silent, match:class ^(discord)$, match:title (Discord Updater)"

      "workspace emptym, match:initial_class ^(org.qbittorrent.qBittorrent)$, match:initial_title ^(.*)(qBittorrent v.*)$"

      "persistent_size true, match:class ^(org.quickshell)"
      "center true, match:class ^(org.quickshell)"
      "float true, match:class ^(org.quickshell)"

      "match:initial_class ^(viewnior)$, size (monitor_w*0.8) (monitor_h*0.8)"
      "match:initial_class ^(viewnior)$, center true"
      "match:initial_class ^(viewnior)$, float true"

      "match:modal true, center true"
      "match:modal true, size (monitor_w*0.8) (monitor_h*0.8)"
      "match:modal true, center true"

      "float true , match:initial_class ^(org.telegram.desktop)$, match:initial_title ^(Telegram)(.*)$"
      "size (monitor_w*0.8) (monitor_h*0.6), match:initial_class ^(org.telegram.desktop)$, match:initial_title ^(Telegram)(.*)$"

      "workspace emptym, match:initial_class emacs, match:initial_title ^(.*)(Doom Emacs)$"
      "workspace emptym, match:initial_class Emacs, match:initial_title ^(.*)(Doom Emacs)$"
      "workspace emptym, match:initial_class Emacs, match:initial_title ^(.*)(GNU Emacs at tangier)$"

      "workspace emptym, match:initial_class steam_app_default, match:initial_title ^(.*)(Battle.net)$"

      # "border_size 0, match:workspace w[tv1]" # NOTE not need?

      # "size 70% 70%,match:title ^(Select)(.*)"
      # "workspace emptym, match:initial_class ^(zen-alpha)$, match:initial_title ^(Zen Browser)$"

      # "nofocus,match:class ^$,match:title ^$,xwayland:1,float:1,fullscreen:0,pinned:0" # fix some dragging issues with xwayland, FIXME: see if causing xwayland issues | ps: dont remember need
      "match:workspace w[tv1]s[false],border_size 0" # no gaps when only = 1 # w[(flags)A-B], w[(flags)X], t tiled, v visible windows,f float | A-B inclusive range, X specific number

      # Workspace
      # "workspace 10, match:initial_class ^(spotube)$, match:initial_title ^(spotube)$"
      "workspace 10, match:initial_class ^(spotify)$"

      "workspace 10, match:class ^(FreeTube)$"
      # "workspace emptym, match:class ^(com.stremio.Stremio)$"
    ];

    workspace = [
      "layoutopt:direction:down"
      # GENERAL: f fullscreen, w window count, m monitor, n name workspaace n[bool], n[s:string], n[e:string], s[bool] special or not eg. special:scratchpad,
      "f[1], gapsout:0, gapsin:0"
      "special:magic, on-created-empty:sh -c \"hyprctl dispatch -- exec '[workspace special:magic;float true;size (monitor_w*0.9) (monitor_h*0.8);center true] app2unit -s a kitty -d ~/Shibuya'\""

      # ncmpcpp
      "special:nc, on-created-empty:sh -c \"hyprctl dispatch -- exec app2unit -s a 'kitty -e ncmpcpp'\", monitor:HDMI-A-1"

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
