{ inputs, pkgs, osConfig, lib, ... }:

let #FIXME this block is not working
  # requirements:
  # - output alist [
  #   monitor1, location
  #   monitor2, location
  # ]
  set_wallpaper_script = pkgs.writeShellScriptBin "set_wallpaper.sh" ''
  # declare -a monitors
    if [[ "$HOSTNAME" == "carthage" ]]; then
      monitor1_wallpaper="/home/malu/Pictures/wallpapers/singed.png"
      monitor2_wallpaper="/home/malu/Pictures/wallpapers/thresh_purp.png"

      while IFS= read -r line; do
        monitor_id=$(echo "$line" | cut -d ' ' -f 2)
        if [[ "$line" == *"HDMI-A-1"* ]]; then
          # echo "$monitor1_id,$monitor1_wallpaper"
          # monitors+=("$monitor_id,$monitor1_wallpaper")
          hyprctl hyprpaper wallpaper "HDMI-A-1,$HOME/Pictures/wallpapers/singed.png"
        elif [[ "$line" == *"DP"* ]]; then
          # monitors+=("$monitor_id,$monitor2_wallpaper")
          # echo "$monitor2_id,$monitor2_wallpaper"
          hyprctl hyprpaper wallpaper "$monitor_id,$HOME/Pictures/wallpapers/thresh_purp.png"
        fi
      done < <(hyprctl monitors)

      # Output the array elements separated by newlines (without brackets)
      # for i in "''${monitors[@]}"; do
      #   printf '"%s"\n' "$i"
      # done

    elif [[ "$HOSTNAME" == "tangier" ]]; then
      echo "eDP-1,$HOME/Pictures/wallpapers/singed.png" # Use $HOME for portability
    fi
  '';
  # wall = "${set_wallpaper_script}/bin/set_wallpaper.sh"; TODO see if its possible to do this
in
{
  # home.packages = [ set_wallpaper_script ];

  services.hyprpaper = {
    # enable = lib.mkIf (osConfig.kde.enable == false) true;
    enable = true;
    settings = {
      ipc = true;
      splash = true;
      preload = [
        "$HOME/Pictures/wallpapers/singed-4096x2305.jpg"
        "$HOME/Pictures/wallpapers/jinx.png"
        "$HOME/Pictures/wallpapers/thresh_purp.png"
      ];
      # wallpaper = wall;
      wallpaper = [
        "HDMI-A-1,$HOME/Pictures/wallpapers/jinx.png"
        "DP-3,$HOME/Pictures/wallpapers/singed-4096x2305.jpg"
      ];
    };
  };
}
