''
  #custom-ssd_temp {
    margin: 4px 0px 3px 0px;
    border-top-right-radius: 12px;
    border-bottom-right-radius: 12px;
    padding: 0px 2px 0px 2px;
    font-size:11px;
    color: rgba(72 ,191 ,227, 0.69);
    color: rgba(159 ,162 ,178, 1);
    background: rgba(72 ,191 ,227, 0.16);
    color: rgba(72 ,191 ,227, 0.83);
    background: rgba(72 ,191 ,227, 0.10);
  }

  #cpu {
      font-size:11px;
      margin: 4px 0px 3px 4px;
  }

  window#waybar.battery-critical {
    border-bottom: 1px solid rgba(245, 60, 60, 1.0);
  }

  #battery {
    padding: 0px 6px 0px 4px;
    margin: 4px 2px 3px 2px;
    color: rgba(154 ,208 ,194, 0.95);
    background: rgba(154 ,208 ,194, 0.134);
    border: 1px solid rgba(154 ,208 ,194, 0.05);
    border-radius: 12px;
    font-size:11px;
  }

  #battery.charging, #battery.plugged {
      color: #ffffff;
      background-color: #26A65B;
      padding: 0px 4px 0px 4px;
      /*padding: 0px 12px 0px 6px;*/
  }

  #battery.warning.discharging {
      /* background-color: #f53c3c; */
      color: #ffffff;
      background-color: rgba(228,76,249,1.0);
      /* animation-name: blink; */
      /* animation-duration: 0.5s; */
      /* animation-timing-function: linear; */
      /* animation-iteration-count: infinite; */
      /* animation-direction: alternate; */
  }

  #battery.critical.discharging {
      background-color: #f53c3c;
      color: #ffffff;
      /* animation-name: blink; */
      /* animation-duration: 0.5s; */
      /* animation-timing-function: linear; */
      /* animation-iteration-count: infinite; */
      /* animation-direction: alternate; */
  }

  #backlight {
      /* background-color: #90b1b1; */
      /* background-color: transparent; */
      /* background: rgba(72 ,191 ,227, 0.00); */
      color: rgba(72 ,191 ,227, 0.70);
      /* padding: 0px 4px; */
      margin: 0px 3px 2px 3px;
      font-size: 16px;
      /* background-color: rgba(34,36,54,0.0); */
  }

  #wireplumber {
      font-size: 12px;
      margin: 2px 0px 0px 7px;
      padding: 0px;
      color: rgba(255 ,158 ,170, 0.89);
  }

  #wireplumber.muted {
      color: #9d0006;
      /* margin: 3px 3px 3px 3px; */
      /* padding: 0px 6px 0px 6px; */
      border-radius: 12px;
  }

  #idle_inhibitor {
      padding:0px;
      margin: 4px 6px 0px 6px;
      font-size: 16px;
  }
''
