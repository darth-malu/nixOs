{ osConfig, lib, ... }:

let
  commonInput = {
    mouse_refocus = false; # if true mouse must cross boundary for focus change
    # focus_on_close = 1; # 0 - next window candidate::, 1 - under cursor
    kb_layout = "us";
    kb_options = "caps:swapescape";
    numlock_by_default = true;
    follow_mouse = 1;
    float_switch_override_focus = 2; # (1:: or 2), focus will change to the window under the cursor when changing from tiled-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches.
    # Follow Mouse legend
    # 0 - Cursor movement will not change focus.
    # 1- Cursor movement will always change focus to the window under the cursor,
    # 2- Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
    # 3 - completely detach,click wont change focus,0-cursor movement will not change focus
    # special_fallthrough= true; # floating will not block focus to regular workspace
  };
in
if osConfig.networking.hostName == "carthage" then
  {
    wayland.windowManager.hyprland.settings = {
      # head /sys/class/drm/*/status with monitors connected
      # name, resolution, position, scale::
      # To disable use -> monitor = name, disable
      # position -> special values(auto, auto-right/left/up/down) in pixels.calculated from the top-left corner
      # resolution -> highrr, highres, preferred, maxwidth

      monitorv2 = {
        output = "HDMI-A-1";
        mode = "1920x1080@240";
        position = "0x0";
        scale = 1;
        cm = "auto"; # srgb::, auto(recommended)
        # icc = "/media/Hyogo/Backups/ICC-profiles/XL2740_WHQL-driver_MP_Windows10_Windows7_Windows8/XL2740-WHQL-driver/XL2740.icm";
        # transform = 2;
      };

      binds = {
        allow_workspace_cycles = true; # workpsaces dontn forget their previous workspaces
        drag_threshold = 10;
      };
      input = commonInput // {
        scroll_factor = 1.6; # 1.2
      };

      device = [
        {
          name = "razer-razer-viper-mini";
          sensitivity = "-0.8";
        }
        # {
        # 😵
        # name = "sino-wealth-usb-keyboard";
        # repeat_delay = 350; # 400, ;;380
        # repeat_rate = 25; # ;;25 || nice: 39
        # }
        {
          # TODO: tangier keyboard increase repeat rate
          # TODO: see if production pressure needed
          name = "hp--inc-hyperx-alloy-origins-65";
          repeat_delay = 350; # 400, ;;380
          repeat_rate = 35; # ;;25 || nice: 39
        }
      ];
    };
  }
else
  lib.mkIf (osConfig.networking.hostName == "tangier") {
    # Default or pc settings here
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1, highres, auto, 1.25" # 1.333333
        ", preferred, auto,1, mirror, eDP-1" # for presentations
      ];

      # TODO: transfer to v21
      # monitorv2 = {
      #   output = "eDP-1";
      #   mode = "highres";
      #   position = "auto";
      #   scale = 1.25;
      # };

      # monitorv2 = {
      #   output = ",";
      #   mode = "auto";
      #   position = "";
      #   scale = 1.25;
      # };

      xwayland.force_zero_scaling = true;

      input = {
        # https://wiki.hyprland.org/Configuring/Variables/
        # scroll_factor = 1.2;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = true; # LMB,RMB,MMB to taps
          drag_lock = false;
          tap-and-drag = true;
          scroll_factor = 1.2;
        };
      }
      // commonInput;

      gesture = import ./laptop-gestures.nix;

      gestures = {
        workspace_swipe_distance = 260; # def: 300
        workspace_swipe_create_new = false; # new empty after last workspace
        workspace_swipe_touch = true; # swipe from the edge of touchpad
        # workspace_swipe_use_r = true; # r instead of m
        workspace_swipe_forever = true; # NOTE....false sucks
      };

      device = [
        {
          name = "at-translated-set-2-keyboard";
          repeat_delay = 380;
          repeat_rate = 39;
        }
      ];
      binde = [
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
    };
  }
