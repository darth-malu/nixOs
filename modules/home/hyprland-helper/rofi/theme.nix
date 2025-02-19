{config, ...}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in 
{
  programs.rofi.theme = {
    "*" = {
      default-background = mkLiteral "rgba(12,44,44,100%)"; # <- anything less than 100% sucks :),
      
      default-foreground = mkLiteral "rgba(196, 203, 212, 100%)";
      default-border = mkLiteral "rgba(63,167,197,40%)";
      alternative-background = mkLiteral "rgba(64, 69, 82, 59%)";
      invisible = mkLiteral "rgba(0, 0, 0, 0%)";
      entry-background = mkLiteral "rgba(64, 69, 82, 59%)";

      # Colors
      # hard-blue: rgba( 82, 148, 226, 100%);
      hard-blue = mkLiteral "#1CD6CE";
      # light-blue = mkLiteral "rgba(24, 53, 69, 80%)";
      light-blue = mkLiteral "rgba(72 ,191 ,227, 15%)";

      hard-red = mkLiteral "rgba(141, 58, 80, 100%)";
      light-red = mkLiteral "rgba(77, 31, 37, 100%)"; 
      hard-green = mkLiteral "rgba(39, 161, 69, 100%)";
      light-green = mkLiteral "rgba(19, 55, 35, 100%)";

      # Universal
      background-color = mkLiteral "@invisible";
      border-color = mkLiteral "@default-border";
      text-color = mkLiteral "@default-foreground";
    };


    # "#textbox-prompt-colon" = {
    #   expand = false;
    #   str = ":";
    #   margin = mkLiteral "0px 0.3em 0em 0em";
    #   text-color = mkLiteral "@foreground-color";
    # };

    # ┌────────────────────────────────────────────────────────────────────────────────────┐
    # │ window {BOX:vertical}                                                              │
    # │ ┌───────────────────────────────────────────────────────────────────────────────┐  │
    # │ │ mainbox  {BOX:vertical}                                                       │  │
    # │ │ ┌───────────────────────────────────────────────────────────────────────────┐ │  │
    # │ │ │ inputbar {BOX:horizontal}                                                 │ │  │
    # │ │ │ ┌─────────┐ ┌─┐ ┌───────────────────────────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ │ │  │
    # │ │ │ │ prompt  │ │:│ │ entry                         │ │#fr│ │ / │ │#ns│ │ci │ │ │  │
    # │ │ │ └─────────┘ └─┘ └───────────────────────────────┘ └───┘ └───┘ └───┘ └───┘ │ │  │
    # │ │ └───────────────────────────────────────────────────────────────────────────┘ │  │

    "#window" = {
      background-color = mkLiteral "@default-background";
      border = 1;
      width = 470; # %, px
      # height = 400;
      # columns = 2;
      border-radius = 6;
      border-color = mkLiteral "@default-border";
      padding = 8;
    };

    # "#mainbox Packs" = mkLiteral "inputbar, message, listview, mode-switcher";
    # "#inputbar Packs" = mkLiteral "prompt,entry,case-indicator";
    "#mainbox" = { border =  0; padding = 0; };


      # ┌───────────────────────────────────────────────────────────────────────────┐
      # │ inputbar {BOX:horizontal}                                                 │
      # │ ┌─────────┐ ┌─┐ ┌───────────────────────────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ │
      # │ │ prompt  │ │:│ │ entry                         │ │#fr│ │ / │ │#ns│ │ci │ │
      # │ └─────────┘ └─┘ └───────────────────────────────┘ └───┘ └───┘ └───┘ └───┘ │
      # └───────────────────────────────────────────────────────────────────────────┘
      "#inputbar" = {
          children = map mkLiteral [ "prompt" "entry" ]; #TODO: investigate case-indicator, prompt , entry
          spacing = 0;
          # border-radius = 4;
          # border = mkLiteral "0 0 1 0";
          padding = mkLiteral "0 2 0 4";
          # children = mkLiteral "[prompt,entry]";
          # children = mkLiteral "[prompt,entry,overlay,case-indicator]";
      };

      "#prompt" = {
          padding = mkLiteral "0 12 0 4";
          margin = "0 0 0 5";
      };

      "#entry" = {
          # background-color: @alternative-background;
          background-color = mkLiteral "transparent";
          padding = mkLiteral "1 6 1 6";
          # border = mkLiteral "0 0 1 0";
          # border-radius = mkLiteral "2 2 2 2";
          # border-radius = 4;
          # placeholder = "Type here"; # works now
          #  cursor = mkLiteral "text, pointer"
          cursor = mkLiteral "text";
          # cursor-color = mkLiteral "rgb(220,20,60)";
          # cursor-color = mkLiteral "rgba(28,214,206,60%)";
          cursor-width = mkLiteral "0px"; #8px, 2px::
      };

      # right of entry?? what its purpose
      "#case-indicator" = {
          spacing = 0;
          padding = mkLiteral "3px";
          #background-color = mkLiteral "@alternative-background";
          background-color = mkLiteral "transparent";
          border = mkLiteral "1 1 1 0";
          border-radius = mkLiteral "0 2 2 0";
      };


      # "textbox-custom" = {
      #   expand = mkLiteral "false";
      #   content = mkLiteral "My Message";
      # };

    # ┌───────────────────────────────────────────────────────────────────────────┐
    # │ message                                                                   │
    # │ ┌───────────────────────────────────────────────────────────────────────┐ │
    # │ │ textbox                                                               │ │
    # │ └───────────────────────────────────────────────────────────────────────┘ │
    # └───────────────────────────────────────────────────────────────────────────┘
      "#message" = {
          border = 0;
          border-radius = 3;
          padding = 5;
          # background-color = mkLiteral "@alternative-background";
          background-color = mkLiteral "transparent";
      };

      "#textbox" = {
          # background-color = mkLiteral "@entry-background";
          background-color = mkLiteral "transparent";
      };

      horibox = {
        orientation = "horizontal";
        children = [ "prompt" "entry" "listview" ];
      };



      # ┌───────────────────────────────────────────────────────────────────────────┐
      # │ listview                                                                  │
      # │ ┌─────────────────────────────────────────────────────────────────────┐   │
      # │ │ element                                                             │   │
      # │ │ ┌─────────────────┐ ┌─────────────────────────────────────────────┐ │   │
      # │ │ │element─icon     │ │element─text                                 │ │   │
      # │ │ └─────────────────┘ └─────────────────────────────────────────────┘ │   │
      # │ └─────────────────────────────────────────────────────────────────────┘   │
      # └───────────────────────────────────────────────────────────────────────────┘
      "#listview" = {
          fixed-height = false; # boolean Always show lines rows, even if fewer elements are available.
          # fixed-columns = true;
          spacing = 4; # distance between elements
          scrollbar = false;
          lines = 5; #8
          # columns = 2;
          # dynamic = true; # True if the size should change when filtering the list, False if it should keep the original height.
          # flow = "horizontal";
          layout = mkLiteral "vertical";
          padding = mkLiteral "2 0 0";
          
      };

      "#element" = { # holds listview - app and icon in list
          padding = 8;
          border = mkLiteral "0 1 0 1";
          border-radius = 2;
          border-color = mkLiteral "@invisible";
          #children = mkLiteral "[ element-text, element-icon ]";
          children = map mkLiteral [ "element-icon"  "element-text" ]; #TODO: see map
          spacing = mkLiteral "20px";
          #orientation = mkLiteral "vertical";
          cursor = mkLiteral "pointer";
      };

      "#element-icon" = {
          # size: 2.5em;# 
          size = mkLiteral "25px";
          cursor = mkLiteral "pointer";
      };

      "#element-text" = {
        vertical-align = mkLiteral "0.5";
        cursor = mkLiteral "pointer";
        highlight = "underline red";
      };


      "#element.normal.normal" = {
          background-color = mkLiteral "@invisible";
      };

      "#element.normal.urgent" = {
          background-color = mkLiteral "@light-red";
      };

      "#element.normal.active" = {
        background-color = mkLiteral "@light-green";
      };

      "#element.selected.normal" = {
          background-color = mkLiteral "@light-blue";
          border-color =     mkLiteral "@hard-blue";
      };

      "#element.selected.urgent" = {
          background-color = mkLiteral "@light-red";
          border-color =     mkLiteral "@hard-red";
      };

      "#element.selected.active" = {
          background-color = mkLiteral "@light-green";
          border-color =     mkLiteral "@hard-green";
      };

      # ┌───────────────────────────────────────────────────────────────────────────┐
      # │  mode─switcher {BOX:horizontal}                                           │
      # │ ┌───────────────┐   ┌───────────────┐  ┌──────────────┐ ┌───────────────┐ │
      # │ │ Button        │   │ Button        │  │ Button       │ │ Button        │ │
      # │ └───────────────┘   └───────────────┘  └──────────────┘ └───────────────┘ │
      # └───────────────────────────────────────────────────────────────────────────┘
      "#mode-switcher" = {
          spacing = 0;
      };

      "#button" = {
          border = mkLiteral "0 0 3 0";
          border-color = mkLiteral "@invisible";
          padding = 3;
      };

      "#button.selected" = {
          border-color = mkLiteral "@hard-blue";
      };

  };
}
# ┌────────────────────────────────────────────────────────────────────────────────────┐
# │ window {BOX:vertical}                                                              │
# │ ┌───────────────────────────────────────────────────────────────────────────────┐  │
# │ │ mainbox  {BOX:vertical}                                                       │  │
# │ │ ┌───────────────────────────────────────────────────────────────────────────┐ │  │
# │ │ │ inputbar {BOX:horizontal}                                                 │ │  │
# │ │ │ ┌─────────┐ ┌─┐ ┌───────────────────────────────┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ │ │  │
# │ │ │ │ prompt  │ │:│ │ entry                         │ │#fr│ │ / │ │#ns│ │ci │ │ │  │
# │ │ │ └─────────┘ └─┘ └───────────────────────────────┘ └───┘ └───┘ └───┘ └───┘ │ │  │
# │ │ └───────────────────────────────────────────────────────────────────────────┘ │  │
# │ │                                                                               │  │
# │ │ ┌───────────────────────────────────────────────────────────────────────────┐ │  │
# │ │ │ message                                                                   │ │  │
# │ │ │ ┌───────────────────────────────────────────────────────────────────────┐ │ │  │
# │ │ │ │ textbox                                                               │ │ │  │
# │ │ │ └───────────────────────────────────────────────────────────────────────┘ │ │  │
# │ │ └───────────────────────────────────────────────────────────────────────────┘ │  │
# │ │                                                                               │  │
# │ │ ┌───────────────────────────────────────────────────────────────────────────┐ │  │
# │ │ │ listview                                                                  │ │  │
# │ │ │ ┌─────────────────────────────────────────────────────────────────────┐   │ │  │
# │ │ │ │ element                                                             │   │ │  │
# │ │ │ │ ┌─────────────────┐ ┌─────────────────────────────────────────────┐ │   │ │  │
# │ │ │ │ │element─icon     │ │element─text                                 │ │   │ │  │
# │ │ │ │ └─────────────────┘ └─────────────────────────────────────────────┘ │   │ │  │
# │ │ │ └─────────────────────────────────────────────────────────────────────┘   │ │  │
# │ │ └───────────────────────────────────────────────────────────────────────────┘ │  │
# │ │                                                                               │  │
# │ │ ┌───────────────────────────────────────────────────────────────────────────┐ │  │
# │ │ │  mode─switcher {BOX:horizontal}                                           │ │  │
# │ │ │ ┌───────────────┐   ┌───────────────┐  ┌──────────────┐ ┌───────────────┐ │ │  │
# │ │ │ │ Button        │   │ Button        │  │ Button       │ │ Button        │ │ │  │
# │ │ │ └───────────────┘   └───────────────┘  └──────────────┘ └───────────────┘ │ │  │
# │ │ └───────────────────────────────────────────────────────────────────────────┘ │  │
# │ └───────────────────────────────────────────────────────────────────────────────┘  │
# └────────────────────────────────────────────────────────────────────────────────────┘
