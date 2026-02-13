{
  programs.bluetuith = {
    enable = true;
    settings = {
      adapter = "hci0";
      receive-dir = "/home/malu/BluetoothTransfers";

      keybindings = {
        Menu = "Alt+m";
      };

      theme = {
        Adapter = "red";
      };
    };
  };
}
