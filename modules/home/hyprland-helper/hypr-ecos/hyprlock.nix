{lib,...}:

{
  programs.hyprlock = {
    enable = lib.mkDefault true;
    # package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300; #seconds
        hide_cursor = true;
        no_fade_in = false;
        ignore_empty_input = true;
      };

      background = [
        {
          #path = "/home/malu/Pictures/Screenshots/FirstFlake.png";
          # path = "/media/linuxHdd/Pictures/wallpaper/city_minima.jpg";
          # path = "/media/linuxHdd/Pictures/wallpaper/city_minima.jpg";
          path = "/home/malu/Pictures/wallpapers/thresh_purp.png";
          blur_passes = 2;
          blur_size = 2;
        }
      ];

      # image = [
      #   {
      #   #monitor = ["HDMI-A-1"];
      #   monitor = "";
      #   #path = /home/me/cutie.png;
      #   path = "/media/linuxHdd/Pictures/iridium_by_skoxjz_dfyrvcf.jpg";
      #   size = 150;
      #   rounding = 8;
      #
      #   position = "0, 200";
      #   halign = "center";
      #   valign = "center";
      #   }
      # ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          dots_size = 0.2;
          dots_spacing = 0.35;
          hide_input = false;
          halign = "center";
          valign = "center";
          fade_on_empty = true;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 2;
          placeholder_text = "<i><span foreground=\"##5DD06A\">Weka password...shens</span></i>";
          shadow_passes = 2;
          font_family = "JetBrainsMono";
        }
      ];

      
      label = [
        # Date 
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "DaddyTimeMono Nerd Font";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # TIME 
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

    };
  };
}
