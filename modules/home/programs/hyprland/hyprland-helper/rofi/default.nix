{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [ ./theme.nix ];

options.rofi = {
  enable = lib.mkEnableOption "rofi";
};

config = lib.mkIf config.rofi.enable {
  programs.rofi = {
    enable = true;

    cycle = true;
    location = "center";
    font = "SpaceMono Nerd Font 12";
    terminal = "${pkgs.kitty}/bin/kitty";

modes = [
  "window"
  "drun"
  # "filebrowser"
  # "calc"
  "emoji"
];

  plugins = with pkgs; [
    rofi-emoji
    rofi-calc
  ];

pass = {
  enable = true;
};

extraConfig = {

run-command = "hyprctl dispatch -- exec [workspace emptym] app2unit -s a -- {cmd}";
# rofi -e "my message"

display-drun = "";
display-run = "";
display-dmenu = "";
display-emoji = "❄️";
display-calc = "🧮";
display-filebrowser = "📂";
display-window = ""; # 

window-thumbnail = true; # FIXME not working
# hide-active-window = true; #FIXME not working
window-format = "{w}{c}  .  {t}";

click-to-exit = true;

kb-primary-paste = "Control+V,Shift+Insert";
kb-secondary-paste = "Control+v,Insert";
# kb-toggle-case-sensitivity #TODO: assign later

kb-row-down = "Control+j,Down";
kb-row-up = "Control+k,Up";
kb-remove-to-eol = "";
kb-accept-entry = "KP_Enter,Return";

icon-theme = "Yaru";
# icon-size = 88;#not working

ml-row-down = "ScrollDown";
hover-select = false;
me-select-entry = "MouseSecondary";
me-accept-entry = "MousePrimary";
kb-delete-entry = "Shift+space"; # Shift+space;;
auto-select = false; # When one entry is left, automatically select it.

drun-use-desktop-cache = true; # slow PC, Build and use a cache with the content of desktop files to reload when enabled -> -drun-reload-desktop-cache flag
drun-reload-desktop-cache = true;
# pid = "/home/malu/.rofi.pid"; #FIXME:
# replace = true;

monitor = 4; # 1 - currently focused monitor, 2;; - currently focused window, 3 - mouse (see more in docs), 4 - monitor with the focused window, 5-monitor with mouse pointer::

# dpi = 1; # 0 - aauto-detect based on x11 screen size(similar to i3 and gtk), 1 - auto based on monitor rofi is on
# matching = "normal"; #normal ::, regex, glob(slower for large list), fuzzy, prefix
# no-lazy-grab = true; # Disables lazy grab, this forces the keyboard being grabbed before gui is shown.

scroll-method = 1; # 0 page::, 1 - continuous

}; # end of programs.rofi
 }; #end of config
  }; #imports
   } #EOF - end of attrSet
