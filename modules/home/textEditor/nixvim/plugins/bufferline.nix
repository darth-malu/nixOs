{
  programs.nixvim.plugins.bufferline = {
    enable = false;
    #diagnostics = true; #FIXME: not working
    #rightTruncMarker = "";
    #tabSize = 18;
    settings = {
      options = {
        #showBufferIcons = false;
        #showCloseIcon = false;
        #bufferCloseIcon = "";
        #closeIcon = "";
        #modifiedIcon = "●";
        #rightMouseCommand = "bdelete! %d"; #TODO: investigate why not just bd and what %d does
        showDuplicatePrefix = true; # default:null
        alwaysShowBufferline = false;
        separatorStyle = "thin"; # Type: null or one of “slant”, “padded_slant”, “slope”, “padded_slope”, “thick”, “thin” or raw lua code
        showBufferCloseIcons = false;
        truncateNames = false;
        colorIcons = true; # default: true
        hover = {
          enabled =  false;
          delay = 200;
          reveal = []; #null or [string]
        };
        indicator = {
          icon = "▎";
          #icon = "*";
          style = "icon"; #default: icon, underline
        };
      };
    };
  };
}
