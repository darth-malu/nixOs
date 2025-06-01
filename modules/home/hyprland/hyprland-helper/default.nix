{ pkgs, inputs, ... }:

{
  imports = [
    ./dunst.nix
    # ./eww
    ./rofi
    ./waybar
    ./scripts
    ./hypr-ecos
    # inputs.hyprshell.homeModules.hyprshell
  ];

  home.packages = with pkgs; [
    grimblast
    slurp
    viewnior
    vlc
    cliphist
    nautilus
    sushi
    yelp
    # inputs.hyprswitch.packages.x86_64-linux.default
    file-roller
  ];

  # programs.hyprshell = {
  #   enable = false;
  #   systemd.args = "-v";
  #   settings = {
  #     launcher = {
  #       max_items = 6;
  #       plugins.websearch = {
  #         enable = true;
  #         engines = [
  #           {
  #             name = "DuckDuckGo";
  #             url = "https://duckduckgo.com/?q=%s";
  #             key = "d";
  #           }
  #         ];
  #       };
  #     };
  #     # window.switcher.enable = false;
  #   };
  # };
}
