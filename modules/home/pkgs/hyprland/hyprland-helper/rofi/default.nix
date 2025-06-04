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
    enable = pkgs.lib.mkDefault true;

  cycle = true;
  location = "center";
  font = "SpaceMono Nerd Font 12";
  plugins = with pkgs; [ rofi-emoji rofi-calc ];
  terminal = "${pkgs.kitty}/bin/kitty";
  # terminal = "uwsm app -s a kitty";
  # package = pkgs.rofi-wayland-unwrapped;
  package = pkgs.rofi-wayland.override {
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
    ];
  };
#yoffset = 3;

extraConfig = {

run-command = "hyprctl dispatch -- exec [workspace emptym] uwsm app -s a -- {cmd}";
# rofi -e "my message"

modes = [
  "window"
  "drun"
  "filebrowser"
];

display-drun = " ";
display-run = " ";
display-dmenu = " ";
display-filebrowser = " ";
display-window = " "; # 

window-thumbnail = true;
# hide-active-window = true;
window-format = "{w}{c}.{t}";

click-to-exit = true;

kb-primary-paste = "Control+V,Shift+Insert";
kb-secondary-paste = "Control+v,Insert";
# kb-toggle-case-sensitivity #TODO: assign later
# icon-theme = "candy icons";
# icon-size = 58;

ml-row-down = "ScrollDown";
hover-select = true;
me-select-entry = "";
me-accept-entry = "MousePrimary";
kb-delete-entry = "Shift+space"; # TODO: make this backspace
auto-select = true; # When one entry is left, automatically select it.

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
