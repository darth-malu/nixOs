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

  window#waybar.battery.critical.discharging {
    background-color: #f53c3c;
    border-top: 2px solid rgb(245, 60, 60);
  }

  #battery {
    /*background-color: #ffffff;*/
    /*color: #000000;*/
    padding: 0px 10px 0px 6px;
    /*padding: 0px 10px;*/
    font-size:11px;
    color: rgba(154 ,208 ,194, 0.85);
    /*background: rgba(255 ,200 ,0, 0.14);*/
    /*background: rgba(154 ,208 ,194, 0.25);*/
    /* border: 1px solid rgba(154 ,208 ,194, 0.25);  */
    border-top: 1px solid rgba(154 ,208 ,194, 0.25);
    margin: 3px 2px 3px 4px;
    border-radius: 12px;
  }

  #battery.charging, #battery.plugged {
      color: #ffffff;
      background-color: #26A65B;
      /*padding: 0px 12px 0px 6px;*/
  }

  #battery.critical.discharging {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }

  #backlight {
    /* background-color: #90b1b1; */
    /* background-color: transparent; */
    background: rgba(72 ,191 ,227, 0.00);
    color: rgba(72 ,191 ,227, 0.70);
    padding: 0px 4px;
    /* background-color: rgba(34,36,54,0.0); */
  }
''
