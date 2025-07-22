  {
   programs.nixvim.plugins.lualine = {
     enable = true;
     settings = {
       options = {
         component_separators = {
           #left = "";
           #right = "";
           left = "";
           right = "";
         };
         section_separators = {
           #left = "";
           #right = "";
           #right = "";
           #left = "";
           right = "";
           left = "";
         };
         refresh = {
           statusline = 1000;
           tabline = 1000;
           winbar = 1000;
         };
         alwaysDivideMiddle = false; # sections cant take over entire line if true
         iconsEnabled = true;
         globalstatus = true;
         theme = "auto";
       };
       sections = {
         lualine_a = ["mode"];
         # "lualine_a.*.color" = "#F6511D"; #FIXME: make this work
         lualine_b = ["branch" "diff"];
         # lualine_c = [ "filename" "diagnostics" ];
         lualine_c = [ "diagnostics" ];
         #lualine_x = ["encoding" "fileformat" "filetype"];
         #lualine_x = ["encoding" "fileformat" "filetype"];
         #lualine_x = ["diagnostics"];
         # lualine_x = ["filetype"];
         lualine_x = [""];
         lualine_y = ["progress"];
         lualine_z = ["location"];
       };
       inactiveSections = {
         lualine_c = ["filename"];
         #"lualine_a.*.color" = "#F6511D"; #FIXME: make this work
         lualine_x = ["location"];
       };
     };
   };
 }
