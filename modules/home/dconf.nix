{ config, lib, pkgs, ... }:

{
 dconf.settings = {
   "/org/gnome/desktop/interface" = {
     gtk-theme = "'Nightfox-Dark'";
   };
 };
}
