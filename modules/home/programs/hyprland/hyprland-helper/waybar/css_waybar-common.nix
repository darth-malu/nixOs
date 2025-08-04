''
  * {
      /* `otf-font-awesome` is required to be installed for icons */
      font-family: quicksand,nunito,JetBrainsMono Nerd Font Propo,ubuntu,fontawesome;
      min-height: 0;
      /*min-width: 0px;*/
      font-weight: bold;
      margin: 0px;
      border: none;
      border-radius: 0;
  }

  tooltip {
      font-size: 12px;
      padding: 0px;
      background: #183D3D;
      /*margin: 6px 4px 6px 4px;*/
      border-radius: 10px;
      border:1px solid #116A7B;
  }

  /*window#waybar.floating*/
  window#waybar {
      color: rgba(154 ,208 ,194, 0.86);
      margin: 0px 13px 0px 14px;
      font-size:14px;
      font-family: nunito;
      /* background-color: rgba(8 ,41 ,41, 0.65); */
      background-color: rgba(8 ,41 ,41, 0.58);
      border-radius: 18px;
      color: rgba(72 ,191 ,227, 0.83);
      color: rgba(53,162,159,1.0);
  }

  /*window#waybar.kitty {*/
      /*background-color: rgba(8 ,41 ,41, 0.75);*/
  /*}*/


  window#waybar.mpv {
      background-color: rgba(40, 44, 52, 0.0);
  }

  window#waybar.Emacs {
      background-color: rgba(40, 44, 52, 0.74);
  }

  window#waybar.org.qutebrowser.qutebrowser {
      background-color: rgba(108,107,120,0.24);
  }

  window#waybar.solo {
      border-bottom: 0px solid #ffffff;
  }

  window#waybar.empty {
      border-bottom: 0px solid #ffffff;
      background-color: rgba(23 ,39 ,41, 0);
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  #submap, #submap.resize {
    margin: 0px 6px 0px 2px;
  }

  window#waybar.firefox {
      background-color: rgba(0,0,0,1);
  }

  button {
      /* Use box-shadow instead of border so the text isn't offset */
      /*box-shadow: inset 0 -3px transparent;*/
      /* Avoid rounded borders under each button name */
      border: none;
      border-radius: 0px;
  }

  button:hover {
    box-shadow: none; /* Remove predefined box-shadow */
    text-shadow: none; /* Remove predefined text-shadow */
    background: none; /* Remove predefined background color (white) */
    transition: none; /* Disable predefined animations */    /*box-shadow: inset 0 -3px #ffffff;*/
  }

  #workspaces {
      padding:0px;
      margin-right: 16px;
  }

  #workspaces button.urgent {
      /*background-color: #eb4d4b;*/
      color: rgba(226,65,226,1.0);
  }

  #workspaces button {
      /*removing padding causes issues*/
      font-size: 13px;
      margin: 2px 2px 2px 0px;
      padding: 0px 2px;
      /*border: 1px solid rgba(0 ,196 ,255,0);*/
      /*min-width: 20.5px;*/
      /*min-width: 18px;*/
      border-radius: 12px;
      border: 1px solid rgba(0 ,196 ,255,0);
      color: rgba(159 ,162 ,178, 1);
      color: rgba(154 ,208 ,194, 0.84);
      color: rgba(72 ,191 ,227, 0.83);

      color: rgba(255 ,107 ,107, 0.66);
      color: rgba(255 ,158 ,170, 0.56);

      color: rgba(190,10,255,1.0);
      color: rgba(123,102,151,1.0);

      color:rgba(226,68,234,1.0);
      color: rgba(72 ,191 ,227, 0.73);

      color: rgba(53,162,159,1.0);
      color: rgba(7,177,169,0.86);
  }

  #workspaces button:hover {
      box-shadow: none;
      background: rgba(154 ,208 ,194, 0.16);
  }

  /*#workspaces button.hosting-monitor {*/
      /*background: rgba(238 ,216 ,169, 0.36);*/
      /*color: rgba(154 ,208 ,194, 0.95);*/
      /*color: rgba(236,164,0,1.0);*/
      /*color: rgba(54,147,179,1.0);*/
  /*}*/

  #workspaces button.active {
      background: rgba(154 ,208 ,194, 0.29);
      color: rgba(154 ,208 ,194, 1);

      /*background: rgba(255 ,107 ,107, 0.26);*/
      border: 1px solid rgba(255 ,107 ,107, 0.189);
      color: rgba(255 ,107 ,107, 0.99);
      color: rgba(255 ,107 ,107, 0.99);

      background: rgba(218,25,91,0.34);
      background: rgba(201,24,74,0.34);

      color: rgba(218,25,91,0.3);
      color: rgba(255,117,143,0.89);
      color: rgba(255 ,158 ,170, 0.86);

      border: 1px solid rgba(255 ,158 ,170, 0.21);
      border: 1px solid rgba(255,117,143,0.15);
  }

  #workspaces button.special {
      /*removing padding causes issues*/
      background: rgba(154 ,208 ,194, 0);
  }

  #workspaces button.special:hover {
      /*removing padding causes issues*/
      background: rgba(154 ,208 ,194, 0);
  }

  #workspaces button.empty {
      /*color: #fc819e;*/
      color: rgba(255, 255, 255, 0.182);
      border: 1px solid rgba(255 ,107 ,107, 0.0);
      background: transparent;
  }

  /* if workspaces is the leftmost module, omit left margin */
  /*.modules-left > widget:first-child > #workspaces {*/
      /*margin-left: 0;*/
      /*margin-right:0px;*/
  /*}*/

  /* if workspaces is the rightmost module, omit right margin */
  /*.modules-right > widget:last-child > #workspaces {*/
      /*margin-right: 0;*/
  /*}*/

  /*.modules-left {*/
      /*margin-right:0px;*/
      /*padding-right:0px;*/
  /*}*/

  #clock {
      font-size: 12px;
      color: rgba(154 ,208 ,194, 0.96);
      padding: 0px 1px 0px 1px;
      margin: 2px 4px 2px 4px;
      /* background: rgba(0 ,0 ,0, 0.569); */
      /* background: rgba(154 ,208 ,194, 0.12); */
  }

  #keyboard-state{
      color: #fab387;
      margin: 0px 5px;
      padding:0;
      }

  #cpu {
      font-size:12px;
      color: rgba(255 ,200 ,0, 0.8);
      background: rgba(255 ,200 ,0, 0.14);
      margin: 4px 0px 3px 6px;
      border: 1px solid rgba(255 ,200 ,0, 0.23);
      border-bottom-left-radius: 12px;
      border-top-left-radius: 12px;
  }

  #cpu:hover {
      background: rgba(255 ,200 ,0, 0.24);
  }

  #cpu:hover {
      background: rgba(255 ,200 ,0, 0.24);
  }

  #custom-launcher {
    margin: 0px 6px 0px 3px;
    padding: 0px 3px 0px 3px;
    /*font-size: 18;*/
  }

  #custom-cpu_freq {
      font-size:12px;
      color: rgba(243 ,222 ,44, 0.85);
      color: rgba(255 ,200 ,0, 0.61);
      background: rgba(255 ,200 ,0, 0.14);
      margin: 4px 0px 3px 0px;
      padding: 0px 0px 0px 1px;
  }

  #custom-audio_idle_inhibitor {
      font-size:12px;
      color: rgba(243 ,222 ,44, 0.85);
      margin: 3px 5px 3px 8px;
      padding: 0px 0px;
  }

  #memory {
      font-size: 12px;
      margin: 4px 0px 3px 0px;
      color: rgba(222 ,192 ,241, 0.8);
      background: rgba(72 ,191 ,227, 0.10);
      padding: 0px 2px 0px 5px;
      /*border: 1px solid rgba(222 ,192 ,241, 0.32);*/
  }

  #disk {
    margin: 4px 0px 3px 6px;
    border-top-left-radius: 12px;
    border-bottom-left-radius: 12px;
    /* border-radius: 12px; */
    padding: 0px 4px 0px 6px;
    font-size:12px;
    color: rgba(72 ,191 ,227, 0.83);
    background: rgba(72 ,191 ,227, 0.10);
    /* border: 1px solid rgba(72 ,191 ,227, 0.32); */
    border: 1px solid rgba(72 ,191 ,227, 0.32);
    /*font-family: VictorMono Nerd Font;*/
  }

  #disk:hover {
      background: rgba(72 ,191 ,227, 0.24);
  }

  #network {
      color: rgba(255 ,158 ,170, 0.73);
      font-size: 12px;
      margin: 0px 7px 0px 6px;
      background: rgba(255 ,107 ,107, 0.0);
  }

  /*#network.disconnected {*/
      /*background-color: grey;*/
      /*background: rgba(255, 255, 255, 0.1);*/
  /*}*/

  /*#network.wifi*/


  #pulseaudio {
      color: #89b4fa;
      /*border-left: 0px;*/
      padding-left:4px;
      margin-left:8px;
      /*border-right: 0px;*/
  }

  #pulseaudio.muted {
      background-color: #90b1b1;
      color: #2a5c45;
  }

  #wireplumber {
      font-size: 13px;
      margin: 2px 0px 3px 4px;
      padding: 0px 0px;
      color: rgba(255 ,158 ,170, 0.89);
  }

  #wireplumber.muted {
      color: #9d0006;
      margin: 3px 3px 3px 3px;
      /* padding: 0px 6px 0px 6px; */
      border-radius: 12px;
  }

  #temperature {
      margin: 4px 2px 3px 0px;
      padding: 0px 3px 0px 3px;
      color: rgba(159 ,162 ,178, 1);
      border-bottom-right-radius: 12px;
      border-top-right-radius: 12px;
      font-size: 10px;
      /* font-family: VictorMono Nerd Font Propo; */
      background: rgba(255 ,200 ,0, 0.14);
  }

  #temperature.critical {
      color: rgba(255 ,158 ,170, 0.83);
  }

  #tray {
      opacity: 1;
      border-radius: 12px;
      margin: 4px 2px 3px 6px;
      padding:0px 4px;
      min-width: 0px;
      background: rgba(154 ,208 ,194, 0.12);
  }

  #tray > .passive {
      -gtk-icon-effect: dim;
      margin: 0;
  }

  /*#tray > .active status active icons*/
  /*#tray > menu -- for the context menu*/

  #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: rgba(255, 255, 255, 0.1);
  }

  #tray > .empty {
      background:transparent;
      padding: 0px;
      margin: 0px;
      opacity: 0;
  }

  #custom-weather {
      /*color: rgba(154 ,208 ,194, 0.65);*/
      /*opacity: 0.7;*/
      margin: 0px 7px 0px 6px;
      font-size: 11px;
      color: rgba(159 ,162 ,178, 1);
  }

  #custom-swap_workspace {
      color: rgba(255, 255, 255, 0.66);
      margin: 0px 0px 0px 6px;
      font-size: 12px;
      color: rgba(14 ,124 ,232,0.954);
      /*font-family: Font Awesome;*/
  }

  #keyboard-state > label {
      padding: 0px 5px 0px 5px;
      /*margin: 5px;*/
      color: #56403e;
  }

  #keyboard-state > label.numlock {
      margin-left:2px;
  }

  #keyboard-state > label.locked {
      /*background: rgba(0, 0, 0, 0.2);*/
      color: #FBFF1E;
  }

  #taskbar {
      background: rgba(0, 0, 0, 0.505);
      margin: 3px 2px 2px 8px;
      opacity: 0.70;
      padding:0px 2px;
      border-radius: 12px;
  }

  #taskbar button {
      margin:0;
      border-radius: 15px;
      padding: 2px 5px 2px 5px;
  }

  #taskbar.empty {
      margin:0;
      min-width: 0px;
      padding: 0px;
      background: transparent;
      border:0;
  }

  #mpris {
      font-size: 13px;
      padding: 0px 6px;
      margin: 3px 2px 3px 9px;
      /*background: rgba(154 ,208 ,194, 0.12);*/
      background: rgba(154 ,208 ,194, 0.00);
      color: rgba(154 ,208 ,194, 0.82);
      color: rgba(7,177,169,0.86);
      border-radius: 12px;
  }

  #mpd {
      font-size: 12px;
      padding: 0px 0px;
      margin: 0px 0px 0px 6px;
      color: rgba(154 ,208 ,194, 0.52);
  }

  /*#mpris:hover {*/
      /*color: rgba(154 ,208 ,194, 0.86);*/
  /*}*/

  #mpris.spotify{
      color: rgba(22 ,255 , 0, 0.688);
      /*background: rgba(22 ,255 , 0, 0.120);*/
      border-radius:12px;
  }

  #power-profiles-daemon {
      padding:0px;
      margin: 2px 0px 0px 2px;
      background-color: transparent;
      /* font-size: 14px; */
  }

  #power-profiles-daemon.balanced {
      padding:0px;
      background-color: transparent;
      /* font-size: 14px; */
  }

  #power-profiles-daemon.power-saver {
      padding:0px;
      /* font-size: 14px; */
  }

  #idle_inhibitor {
      padding:0px;
      /* font-size:11px; */
      margin: 0px 6px 0px 6px;
      background-color: #d46547;
      font-size: 16px;
  }

  #idle_inhibitor.activated {
      background-color: transparent;
      color: #FFD700;
      font-size: 14px;
  }

  #idle_inhibitor.deactivated {
      background-color: transparent;
      color: rgba(159 ,162 ,178, 0.5);
  }

  #idle_inhibitor.deactivated:hover {
      color: rgba(0,180,216,1.0);
  }

  #drawer-child {
      /*background: black;*/
      background: transparent;
  }
''
