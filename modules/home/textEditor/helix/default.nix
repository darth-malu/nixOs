{pkgs, lib,...}:
{
  programs.helix = {
    enable = true;
    settings = {
      #theme = "autumn_night_transparent";
      #editor.cursor-shape = {
      #normal = "block";
      #insert = "bar";
      #select = "underline";
      };
    };
  #languages = [{
  #name = "nix";
  #auto-format = true;
      # formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      #formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
  #}];
  #themes = {
  #autumn_night_transparent = {
  #"inherits" = "autumn_night";
  #"ui.background" = { };
  #};
  #};
  #};
}
